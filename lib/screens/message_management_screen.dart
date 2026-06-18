import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:bcsv_flutter_project/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:bcsv_flutter_project/screens/disconnect_screen.dart';
import 'package:bcsv_flutter_project/domain/entities/message.dart';
import 'package:bcsv_flutter_project/data/models/message_model.dart';
import 'package:bcsv_flutter_project/presentation/providers/message_provider.dart';
import 'package:overlay_support/overlay_support.dart';
import '../components/appbar_header_text.dart';
import '../utilities/constants.dart';
import 'dart:developer';

class MessageManagementScreen extends ConsumerStatefulWidget {
  const MessageManagementScreen({super.key});

  @override
  ConsumerState<MessageManagementScreen> createState() => _MessageManagementScreenState();
}

class _MessageManagementScreenState extends ConsumerState<MessageManagementScreen> {
  List<MessageEntity> messages = [];
  bool isLoading = true;
  String? errorMessage;

  final List<String> categories = [
    'Announcement',
    'News',
    'Event',
    'Prayer',
    'Urgent',
    'Others'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkNetworkAndLoad();
    });
  }

  Future<void> _checkNetworkAndLoad() async {
    try {
      log('🔍 Checking network connectivity for message management...');

      final hasConnection = await InternetConnectionChecker.instance
          .hasConnection
          .timeout(Duration(seconds: 10));

      if (!hasConnection) {
        log('❌ No network connection detected');
        _navigateToDisconnectScreen();
        return;
      }

      log('✅ Network available, loading messages');
      await _loadMessages();
    } catch (e) {
      log('❌ Network check failed: $e');
      _navigateToDisconnectScreen();
    }
  }

  void _navigateToDisconnectScreen() {
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DisconnectScreen(
          returnScreen: MessageManagementScreen(),
        ),
      ),
    );
  }

  Future<void> _loadMessages() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Use scheduleMessages endpoint to include future scheduled messages (for admin)
      final uri = Uri.parse('https://www.bridgeway.online/_functions/scheduleMessages');
      log('🔄 Fetching scheduled messages (active + future) from: $uri');

      final response = await http
          .get(uri, headers: {"Content-Type": "application/json"})
          .timeout(Duration(seconds: 15));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final messagesList = jsonData['items'] as List<dynamic>?;

        if (messagesList == null || messagesList.isEmpty) {
          log('⚠️ No messages found');
          setState(() {
            messages = [];
            isLoading = false;
          });
          return;
        }

        // Wix endpoint already excludes expired messages
        final loadedMessages = messagesList
            .map((json) => MessageModel.fromJson(json as Map<String, dynamic>).toEntity())
            .toList();

        log('✅ Loaded ${loadedMessages.length} messages (active + scheduled)');

        setState(() {
          messages = loadedMessages;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load messages: ${response.statusCode}');
      }
    } catch (e) {
      log('❌ Error loading messages: $e');
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _refreshData() async {
    log('🔄 User initiated refresh');
    await _loadMessages();
  }

  void _showEditBottomSheet(MessageEntity message) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _EditMessageSheet(
        message: message,
        categories: categories,
        onSaved: () {
          Navigator.pop(context);
          // Clear message cache so message_list shows updated data
          ref.read(messageNotifierProvider.notifier).clearCacheAndReload();
          _loadMessages();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withValues(alpha: 0.5),
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: kNavBackButtonColor,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ).animate().fadeIn(delay: 200.ms).scale(begin: Offset(0.8, 0.8)),
        title: AppBarHeaderText(
          text1: localizations.manageMessages,
          text2: '',
        ).animate().fade().scale(duration: 500.ms),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surface.withValues(alpha: 0.95),
            ],
          ),
        ),
        child: SafeArea(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : errorMessage != null
                  ? _buildErrorState()
                  : messages.isEmpty
                      ? _buildEmptyState()
                      : RefreshIndicator(
                          onRefresh: _refreshData,
                          child: _buildMessageList(),
                        ),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red),
          SizedBox(height: 16),
          Text('Failed to load messages'),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: _loadMessages,
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(AppLocalizations.of(context)!.selectMessageToEdit),
        ],
      ),
    );
  }

  /// Check if message is scheduled for the future (not yet active)
  bool _isFutureMessage(MessageEntity message) {
    final now = DateTime.now();
    final todayLocal = DateTime(now.year, now.month, now.day);
    final startDateOnly = DateTime(message.startDate.year, message.startDate.month, message.startDate.day);
    return startDateOnly.isAfter(todayLocal);
  }

  Widget _buildMessageList() {
    final theme = Theme.of(context);

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final dateFormat = DateFormat('yyyy-MM-dd');
        final isFuture = _isFutureMessage(message);

        return Card(
          margin: EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _showEditBottomSheet(message),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          message.category,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      // Status badge (only show for future/scheduled messages)
                      if (isFuture)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Scheduled',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      Spacer(),
                      Icon(Icons.edit_rounded, size: 20, color: theme.colorScheme.primary),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    message.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(
                        '${dateFormat.format(message.startDate)}${message.endDate != null ? ' - ${dateFormat.format(message.endDate!)}' : ''}',
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  if (message.hasImage) ...[
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.image, size: 14, color: Colors.green),
                        SizedBox(width: 4),
                        Text(
                          'Has image',
                          style: theme.textTheme.bodySmall?.copyWith(color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ).animate().fadeIn(delay: (100 * index).ms).slideX(begin: 0.1, end: 0);
      },
    );
  }
}

/// Bottom sheet for editing a message
class _EditMessageSheet extends StatefulWidget {
  final MessageEntity message;
  final List<String> categories;
  final VoidCallback onSaved;

  const _EditMessageSheet({
    required this.message,
    required this.categories,
    required this.onSaved,
  });

  @override
  _EditMessageSheetState createState() => _EditMessageSheetState();
}

class _EditMessageSheetState extends State<_EditMessageSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController titleCtrl;
  late TextEditingController messageCtrl;
  late TextEditingController externalLinkCtrl;

  late String selectedCategory;
  late DateTime startDate;
  DateTime? endDate;
  bool isSubmitting = false;
  PlatformFile? pickedFile;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Pre-populate with existing values
    // Convert <br> tags back to newlines for editing
    final messageText = widget.message.message
        .replaceAll('<br>', '\n')
        .replaceAll('<br/>', '\n')
        .replaceAll('<br />', '\n');

    titleCtrl = TextEditingController(text: widget.message.title);
    messageCtrl = TextEditingController(text: messageText);
    externalLinkCtrl = TextEditingController(text: widget.message.externalLink);
    selectedCategory = widget.message.category;
    startDate = widget.message.startDate;
    endDate = widget.message.endDate;
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    messageCtrl.dispose();
    externalLinkCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        startDate = picked;
        if (endDate != null && endDate!.isBefore(startDate)) {
          endDate = null;
        }
      });
    }
  }

  Future<void> _pickEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? startDate,
      firstDate: startDate,
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => endDate = picked);
    }
  }

  void _clearEndDate() {
    setState(() => endDate = null);
  }

  Future<void> _pickImage() async {
    try {
      final ImageSource? source = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Select Image Source'),
          actions: [
            TextButton.icon(
              icon: Icon(Icons.photo_library_rounded),
              label: Text('Gallery'),
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
            ),
            TextButton.icon(
              icon: Icon(Icons.camera_alt_rounded),
              label: Text('Camera'),
              onPressed: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        ),
      );

      if (source == null) return;

      final XFile? xFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );

      if (xFile != null) {
        final bytes = await xFile.readAsBytes();
        setState(() {
          pickedFile = PlatformFile(
            name: xFile.name,
            size: bytes.length,
            bytes: bytes,
            path: xFile.path,
          );
        });

        showSimpleNotification(
          Text("🖼️ New image selected: ${xFile.name}"),
          background: Colors.green,
        );
      }
    } catch (e) {
      log('❌ Image picker error: $e');
      showSimpleNotification(
        Text("❌ Failed to pick image"),
        background: Colors.red,
      );
    }
  }

  Future<void> _submitUpdate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSubmitting = true);

    final dateFormat = DateFormat('yyyy-MM-dd');

    // Convert newlines to <br> tags for HTML display
    final messageHtml = messageCtrl.text.trim().replaceAll('\n', '<br>');

    final data = {
      'id': widget.message.id,
      'title': titleCtrl.text.trim(),
      'message': messageHtml,
      'category': selectedCategory,
      'startDate': dateFormat.format(startDate),
      'endDate': endDate != null ? dateFormat.format(endDate!) : null,
      'externalLink': externalLinkCtrl.text.trim().isEmpty
          ? null
          : externalLinkCtrl.text.trim(),
      'fileName': pickedFile?.name ?? '',
      'fileData': pickedFile != null ? base64Encode(pickedFile!.bytes!) : null,
    };

    log('📝 Updating message: ${widget.message.id}');

    try {
      final uri = Uri.https('www.bridgeway.online', '/_functions/messageUpdate');
      final res = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: 30));

      if (res.statusCode == 200) {
        log('✅ Message updated successfully');

        showSimpleNotification(
          Text("✅ ${AppLocalizations.of(context)!.updateSuccess}"),
          background: Colors.green,
        );

        widget.onSaved();
      } else {
        log('❌ Update failed: ${res.statusCode} - ${res.body}');
        showSimpleNotification(
          Text("❌ Update failed. Please try again."),
          background: Colors.red,
        );
      }
    } catch (e) {
      log('❌ Update exception: $e');
      showSimpleNotification(
        Text("⚠️ An error occurred. Please try again."),
        background: Colors.orange,
      );
    } finally {
      if (mounted) {
        setState(() => isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    final dateFormat = DateFormat('yyyy-MM-dd');

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(Icons.edit_rounded, color: theme.colorScheme.primary),
                SizedBox(width: 12),
                Text(
                  localizations.editMessage,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Divider(),
          // Form
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title field
                    TextFormField(
                      controller: titleCtrl,
                      decoration: InputDecoration(
                        labelText: '${localizations.messageTitle} *',
                        prefixIcon: Icon(Icons.title_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (val) =>
                          val == null || val.trim().isEmpty ? 'Required' : null,
                    ),
                    SizedBox(height: 16),

                    // Category dropdown
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: InputDecoration(
                        labelText: localizations.selectCategory,
                        prefixIcon: Icon(Icons.category_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: widget.categories
                          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                          .toList(),
                      onChanged: (val) => setState(() => selectedCategory = val!),
                    ),
                    SizedBox(height: 16),

                    // Message field
                    TextFormField(
                      controller: messageCtrl,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: '${localizations.messageContent} *',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 80),
                          child: Icon(Icons.message_rounded),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignLabelWithHint: true,
                      ),
                      validator: (val) =>
                          val == null || val.trim().isEmpty ? 'Required' : null,
                    ),
                    SizedBox(height: 16),

                    // Start date
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.calendar_today_rounded,
                          color: theme.colorScheme.primary),
                      title: Text('${localizations.startDateLabel} *'),
                      subtitle: Text(dateFormat.format(startDate)),
                      onTap: _pickStartDate,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    SizedBox(height: 12),

                    // End date
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.event_rounded,
                          color: theme.colorScheme.primary),
                      title: Text(localizations.endDateLabel),
                      subtitle: Text(
                          endDate != null ? dateFormat.format(endDate!) : 'No end date'),
                      trailing: endDate != null
                          ? IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: _clearEndDate,
                            )
                          : null,
                      onTap: _pickEndDate,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    SizedBox(height: 16),

                    // External link
                    TextFormField(
                      controller: externalLinkCtrl,
                      decoration: InputDecoration(
                        labelText: localizations.externalLinkLabel,
                        prefixIcon: Icon(Icons.link_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.url,
                    ),
                    SizedBox(height: 16),

                    // Current image preview
                    if (widget.message.hasImage) ...[
                      Text('Current Image:', style: theme.textTheme.titleSmall),
                      SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          widget.message.imageUrl,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 120,
                            color: Colors.grey[200],
                            child: Center(child: Icon(Icons.broken_image)),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                    ],

                    // Image picker
                    OutlinedButton.icon(
                      onPressed: _pickImage,
                      icon: Icon(Icons.image_rounded),
                      label: Text(pickedFile != null
                          ? 'New: ${pickedFile!.name}'
                          : 'Replace Image'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),

                    // Submit button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isSubmitting ? null : _submitUpdate,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isSubmitting
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Text(
                                localizations.update,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
