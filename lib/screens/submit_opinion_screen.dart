// ✅ SubmitOpinionScreen with File Picker support
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:bcsv_flutter_project/screens/disconnect_screen.dart';
import 'dart:developer';

class SubmitOpinionScreen extends StatefulWidget {
  const SubmitOpinionScreen({super.key});

  @override
  _SubmitOpinionScreenState createState() => _SubmitOpinionScreenState();
}

class _SubmitOpinionScreenState extends State<SubmitOpinionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController messageCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();

  String selectedCategory = 'Suggestion';
  bool isSubmitting = false;
  PlatformFile? pickedFile;
  final ImagePicker _imagePicker = ImagePicker();

  final List<String> categories = [
    'Prayer Request',
    'Suggestion',
    'Complaint',
    'Others'
  ];

  @override
  void initState() {
    super.initState();
    // Check network connectivity when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkNetworkConnectivity();
    });
  }

  /// Check network connectivity
  Future<void> _checkNetworkConnectivity() async {
    try {
      log('🔍 Checking network connectivity for submit opinion...');
      
      final hasConnection = await InternetConnectionChecker.instance
          .hasConnection
          .timeout(Duration(seconds: 10));

      if (!hasConnection) {
        log('❌ No network connection detected on submit opinion screen');
        _navigateToDisconnectScreen();
        return;
      }

      log('✅ Network available on submit opinion screen');
    } catch (e) {
      log('❌ Network check failed on submit opinion screen: $e');
      _navigateToDisconnectScreen();
    }
  }

  /// Navigate to disconnect screen when network is unavailable
  void _navigateToDisconnectScreen() {
    if (!mounted) return;
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DisconnectScreen(
          returnScreen: SubmitOpinionScreen(),
        ),
      ),
    );
  }

  /// Refresh data when user pulls down
  Future<void> _refreshData() async {
    log('🔄 User initiated refresh for submit opinion');
    await _checkNetworkConnectivity();
  }



  /// Remove the attached file
  void _removeAttachedFile() {
    setState(() {
      pickedFile = null;
    });
    
    if (mounted) {
      showSimpleNotification(
        Text(
          "🗑️ Image removed successfully",
          style: TextStyle(color: Colors.white),
        ),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.check_rounded,
            color: Colors.white,
            size: 16,
          ),
        ),
        background: Colors.grey[600]!,
        elevation: 8,
        duration: Duration(seconds: 2),
      );
    }
    
    log('🗑️ Attached file removed by user');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent.withValues(alpha: 0.5),
          elevation: 0,
          leading: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: kNavBackButtonColor,
            onPressed: () => Navigator.of(context).pop(),
          ),
          ).animate().fadeIn(delay: 200.ms).scale(begin: Offset(0.8, 0.8)),
          title: AppBarHeaderText(
            text1: AppLocalizations.of(context)!.bridgewayOpinion,
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
                theme.colorScheme.surface.withValues(alpha: 0.9),
              ],
              stops: [0.0, 0.7, 1.0],
            ),
          ),
          child: SafeArea(
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: CustomScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                            // Modern header section
                            Container(
                              margin: EdgeInsets.only(bottom: 24),
                              padding: EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
                                    theme.colorScheme.surface,
                                    theme.colorScheme.secondaryContainer.withValues(alpha: 0.05),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: theme.colorScheme.outline.withValues(alpha: 0.1),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.colorScheme.primary.withValues(alpha: 0.08),
                                    blurRadius: 16,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(
                                      Icons.question_answer,
                                      size: 32,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.opinionTitle,
                                          style: kListSubtitleStyle(context).copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                          AppLocalizations.of(context)!.opinionSubTitle,
                                          style: kListSubtitleStyle(context).copyWith(
                                            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ).animate()
                              .fadeIn(duration: 600.ms)
                              .slideY(begin: -0.2, end: 0),

                            // Modern form section
                            Container(
                              margin: EdgeInsets.only(bottom: 24),
                              padding: EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: theme.colorScheme.outline.withValues(alpha: 0.1),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.colorScheme.shadow.withValues(alpha: 0.08),
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Form header
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Icon(
                                          Icons.edit_rounded,
                                          size: 20,
                                          color: theme.colorScheme.secondary,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'Opinion Form',
                                        style: theme.textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 24),

                                                                     // Category dropdown
                                   Container(
                                     margin: EdgeInsets.only(bottom: 16),
                                     child: DropdownButtonFormField<String>(
                      value: selectedCategory,
                                       decoration: kTextFieldInputDecoration(context).copyWith(
                                         labelText: 'Category',
                                         prefixIcon: Icon(Icons.category_rounded),
                                         enabledBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(12),
                                           borderSide: BorderSide(
                                             color: theme.colorScheme.outline.withValues(alpha: 0.5),
                                             width: 1.5,
                                           ),
                                         ),
                                         focusedBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(12),
                                           borderSide: BorderSide(
                                             color: theme.colorScheme.primary,
                                             width: 2.0,
                                           ),
                                         ),
                                         filled: true,
                                         fillColor: theme.colorScheme.surface.withValues(alpha: 0.8),
                                       ),
                      items: categories
                          .map((c) => DropdownMenuItem(
                                value: c,
                                                 child: Text(c, style: kBodyTextStyle(context)),
                              ))
                          .toList(),
                      onChanged: (val) =>
                          setState(() => selectedCategory = val!),
                    ),
                                   ),

                                                                     // Message field
                                   Container(
                                     margin: EdgeInsets.only(bottom: 16),
                                     child: TextFormField(
                      controller: messageCtrl,
                      maxLines: 5,
                      maxLength: 200,
                                       style: kBodyTextStyle(context),
                      decoration: kTextFieldInputDecoration(context).copyWith(
                        labelText: 'Message (required)',
                                         prefixIcon: Padding(
                                           padding: EdgeInsets.only(top: 8),
                                           child: Icon(Icons.message_rounded),
                                         ),
                                         alignLabelWithHint: true,
                                         enabledBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(12),
                                           borderSide: BorderSide(
                                             color: theme.colorScheme.outline.withValues(alpha: 0.5),
                                             width: 1.5,
                                           ),
                                         ),
                                         focusedBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(12),
                                           borderSide: BorderSide(
                                             color: theme.colorScheme.primary,
                                             width: 2.0,
                                           ),
                                         ),
                                         errorBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(12),
                                           borderSide: BorderSide(
                                             color: theme.colorScheme.error,
                                             width: 1.5,
                                           ),
                                         ),
                                         focusedErrorBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(12),
                                           borderSide: BorderSide(
                                             color: theme.colorScheme.error,
                                             width: 2.0,
                                           ),
                                         ),
                                         filled: true,
                                         fillColor: theme.colorScheme.surface.withValues(alpha: 0.8),
                      ),
                      validator: (val) => val == null || val.trim().isEmpty
                          ? 'Please enter your message'
                          : null,
                    ),
                                   ),

                                                                     // Name field
                                   Container(
                                     margin: EdgeInsets.only(bottom: 16),
                                     child: TextFormField(
                      controller: nameCtrl,
                                       style: kBodyTextStyle(context),
                      decoration: kTextFieldInputDecoration(context).copyWith(
                        labelText: 'Name (optional)',
                                         prefixIcon: Icon(Icons.person_rounded),
                                         enabledBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(12),
                                           borderSide: BorderSide(
                                             color: theme.colorScheme.outline.withValues(alpha: 0.5),
                                             width: 1.5,
                                           ),
                                         ),
                                         focusedBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(12),
                                           borderSide: BorderSide(
                                             color: theme.colorScheme.primary,
                                             width: 2.0,
                                           ),
                                         ),
                                         filled: true,
                                         fillColor: theme.colorScheme.surface.withValues(alpha: 0.8),
                                       ),
                                     ),
                                   ),

                                                                     // Email field
                                   Container(
                                     margin: EdgeInsets.only(bottom: 20),
                                     child: TextFormField(
                      controller: emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                                       style: kBodyTextStyle(context),
                      decoration: kTextFieldInputDecoration(context).copyWith(
                        labelText: 'Email (optional)',
                                         prefixIcon: Icon(Icons.email_rounded),
                                         enabledBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(12),
                                           borderSide: BorderSide(
                                             color: theme.colorScheme.outline.withValues(alpha: 0.5),
                                             width: 1.5,
                                           ),
                                         ),
                                         focusedBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(12),
                                           borderSide: BorderSide(
                                             color: theme.colorScheme.primary,
                                             width: 2.0,
                                           ),
                                         ),
                                         filled: true,
                                         fillColor: theme.colorScheme.surface.withValues(alpha: 0.8),
                                       ),
                                     ),
                                   ),

                                  // Modern file picker button
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(bottom: 24),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: theme.colorScheme.outline.withValues(alpha: 0.3),
                                      ),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTap: pickFile,
                                        child: Padding(
                                          padding: EdgeInsets.all(16),
                                          child: Row(
                                            children: [
                                                                                             Icon(
                                                 Icons.image_rounded,
                                                 color: theme.colorScheme.primary,
                                               ),
                                              SizedBox(width: 12),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                                                                                                                              Text(
                                                       pickedFile != null ? 'Image attached' : 'Attach Image (optional)',
                                                       style: theme.textTheme.bodyLarge?.copyWith(
                                                         color: theme.colorScheme.onSurface,
                                                         fontWeight: FontWeight.w500,
                                                       ),
                                                     ),
                                                     SizedBox(height: 4),
                                                     if (pickedFile != null) ...[
                                                       Text(
                                                         pickedFile!.name,
                                                         style: theme.textTheme.bodySmall?.copyWith(
                                                           color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                                                         ),
                                                         maxLines: 1,
                                                         overflow: TextOverflow.ellipsis,
                                                       ),
                                                     ] else ...[
                                                       Text(
                                                         'HEIC files will be auto-converted to JPEG',
                                                         style: theme.textTheme.bodySmall?.copyWith(
                                                           color: theme.colorScheme.primary.withValues(alpha: 0.8),
                                                           fontSize: 11,
                                                           fontWeight: FontWeight.w500,
                                                         ),
                                                       ),
                                                     ],
                                                  ],
                                                ),
                                              ),
                                                                                             if (pickedFile != null) ...[
                                                 SizedBox(width: 8),
                                                 Container(
                                                   decoration: BoxDecoration(
                                                     color: Colors.red.withValues(alpha: 0.1),
                                                     borderRadius: BorderRadius.circular(8),
                                                   ),
                                                   child: Material(
                                                     color: Colors.transparent,
                                                     child: InkWell(
                                                       borderRadius: BorderRadius.circular(8),
                                                       onTap: _removeAttachedFile,
                                                       child: Padding(
                                                         padding: EdgeInsets.all(8),
                                                         child: Icon(
                                                           Icons.close_rounded,
                                                           color: Colors.red,
                                                           size: 20,
                                                         ),
                                                       ),
                                                     ),
                                                   ),
                                                 ),
                                                 SizedBox(width: 8),
                                                 Icon(
                                                   Icons.check_circle_rounded,
                                                   color: Colors.green,
                                                 ),
                                               ],
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Modern submit button
                                  SizedBox(
                                    width: double.infinity,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isSubmitting 
                                            ? theme.colorScheme.primary.withValues(alpha: 0.5) 
                                            : theme.colorScheme.primary,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: isSubmitting ? null : [
                                          BoxShadow(
                                            color: theme.colorScheme.primary.withValues(alpha: 0.3),
                                            blurRadius: 8,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(12),
                                          onTap: isSubmitting
                          ? null
                          : () {
                                                  FocusScope.of(context).unfocus();
                        submitData();
                      },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                if (isSubmitting) ...[
                                                  SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      valueColor: AlwaysStoppedAnimation<Color>(
                                                        theme.colorScheme.onPrimary,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 12),
                                                ] else ...[
                                                  Icon(
                                                    Icons.send_rounded,
                                                    color: theme.colorScheme.onPrimary,
                                                    size: 20,
                                                  ),
                                                  SizedBox(width: 8),
                                                ],
                                                Text(
                                                  isSubmitting ? 'Submitting...' : AppLocalizations.of(context)!.submit,
                                                  style: theme.textTheme.titleMedium?.copyWith(
                                                    color: theme.colorScheme.onPrimary,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ).animate()
                              .fadeIn(delay: 800.ms, duration: 600.ms)
                              .slideY(begin: 0.3, end: 0),
                            
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickFile() async {
    try {
      log('🖼️ Opening image picker for opinion attachment...');
      
      // Show dialog to choose between camera and gallery
      final ImageSource? source = await showDialog<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          final theme = Theme.of(context);
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Icon(Icons.image_rounded, color: theme.colorScheme.primary),
                SizedBox(width: 12),
                Text('Select Image Source'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose how you want to select your image:',
                  style: theme.textTheme.bodyMedium,
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_rounded, 
                           color: theme.colorScheme.primary, 
                           size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'HEIC files will be automatically converted to JPEG format',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton.icon(
                icon: Icon(Icons.photo_library_rounded),
                label: Text('Gallery'),
                onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
              TextButton.icon(
                icon: Icon(Icons.camera_alt_rounded),
                label: Text('Camera'),
                onPressed: () => Navigator.of(context).pop(ImageSource.camera),
              ),
            ],
          );
        },
      );
      
      if (source == null) {
        log('📱 User cancelled image source selection');
        return;
      }
      
      log('📱 User selected image source: ${source.name}');
      
      // Pick image with automatic HEIC conversion
      final XFile? xFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 85, // Optimize for reasonable file size
        maxWidth: 1920,   // Limit maximum dimensions
        maxHeight: 1920,
      );
      
      if (xFile != null) {
        // Convert XFile to PlatformFile-compatible structure
        final bytes = await xFile.readAsBytes();
        final fileSize = bytes.length;
        
        // Create a PlatformFile-like object for compatibility
        final file = PlatformFile(
          name: xFile.name,
          size: fileSize,
          bytes: bytes,
          path: xFile.path,
        );
        
        log('✅ Image selected and converted: ${file.name} (${file.size} bytes)');
        
        setState(() => pickedFile = file);
        
        if (mounted) {
          showSimpleNotification(
            Text(
              "🖼️ Image attached successfully: ${file.name}",
              style: TextStyle(color: Colors.white),
            ),
            leading: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
            background: Colors.green,
            elevation: 8,
            duration: Duration(seconds: 3),
          );
        }
    } else {
        log('❌ Image picker cancelled or failed');
        
        if (mounted) {
          showSimpleNotification(
            Text(
              "⚠️ No image selected",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(Icons.info_rounded, color: Colors.white),
            background: Colors.grey[600]!,
            elevation: 8,
          );
        }
      }
    } catch (e) {
      log('❌ Image picker exception: $e');
      
      // Check if it's a plugin registration issue
      if (e.toString().contains('MissingPluginException')) {
        log('⚠️ Plugin registration issue detected - suggesting app restart');
        
        if (mounted) {
      showSimpleNotification(
            Text(
              "⚠️ Please restart the app and try again. The image picker needs to be initialized.",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(Icons.refresh_rounded, color: Colors.white),
        background: Colors.orange,
            elevation: 8,
            duration: Duration(seconds: 6),
          );
        }
      } else {
        if (mounted) {
          showSimpleNotification(
            Text(
              "❌ Error accessing images. Please try again.",
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(Icons.error_rounded, color: Colors.white),
            background: Colors.red,
            elevation: 8,
          );
        }
      }
    }
  }


  Future<void> submitData() async {
    FocusScope.of(context).unfocus(); // ✅ Hide the keyboard

    if (!_formKey.currentState!.validate()) return;

    // Check network connectivity before submitting
    try {
      log('🔍 Checking network connectivity before submitting opinion...');
      
      final hasConnection = await InternetConnectionChecker.instance
          .hasConnection
          .timeout(Duration(seconds: 5));

      if (!hasConnection) {
        log('❌ No network connection for opinion submission');
        _navigateToDisconnectScreen();
        return;
      }
    } catch (e) {
      log('❌ Network check failed for opinion submission: $e');
      _navigateToDisconnectScreen();
      return;
    }

    setState(() => isSubmitting = true);
    FocusScope.of(context).unfocus();

    log('📝 Submitting opinion: category=$selectedCategory, message length=${messageCtrl.text.trim().length}');

    final data = {
      'category': selectedCategory,
      'message': messageCtrl.text.trim(),
      'name': nameCtrl.text.trim().isEmpty ? null : nameCtrl.text.trim(),
      'email': emailCtrl.text.trim().isEmpty ? null : emailCtrl.text.trim(),
      'fileName': pickedFile?.name ?? '',
      'fileData': pickedFile != null ? base64Encode(pickedFile!.bytes!) : null
    };

    try {
      final uri =
          Uri.parse('https://bcsv-api.crane1129.workers.dev/api/opinionSubmit');
      final res = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      ).timeout(Duration(seconds: 30));

      if (res.statusCode == 200) {
        log('✅ Opinion submitted successfully');
        
        messageCtrl.clear();
        nameCtrl.clear();
        emailCtrl.clear();
        setState(() => pickedFile = null);

        if (mounted) {
        showSimpleNotification(
            Text(
              "✅ Thank you! Your opinion has been submitted.",
              style: TextStyle(color: Colors.white),
            ),
            leading: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          background: Colors.green,
            elevation: 8,
            duration: Duration(seconds: 4),
        );
        }
      } else {
        log('❌ Opinion submission failed: ${res.statusCode} - ${res.body}');
        
        String errorMessage = "❌ Submission failed. Please try again later.";
        
        // Check for specific error types (rare since we now auto-convert HEIC)
        if (res.statusCode == 400 && res.body.contains('Unsupported file type')) {
          errorMessage = "❌ Image processing failed. Please try a different image or contact support.";
        }
        
        if (mounted) {
        showSimpleNotification(
            Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            ),
            leading: Icon(Icons.error_rounded, color: Colors.white),
          background: Colors.red,
            elevation: 8,
            duration: Duration(seconds: 6),
        );
        }
      }
    } catch (e) {
      log('❌ Opinion submission exception: $e');
      
      // Check if it's a network-related error
      if (e.toString().contains('connection') || 
          e.toString().contains('network') || 
          e.toString().contains('timeout')) {
        
        // Double-check network connectivity
        try {
          final hasConnection = await InternetConnectionChecker.instance
              .hasConnection
              .timeout(Duration(seconds: 5));
          
          if (!hasConnection) {
            log('🌐 Network disconnection confirmed during submission');
            _navigateToDisconnectScreen();
            return;
          }
        } catch (networkError) {
          log('❌ Network verification failed during submission: $networkError');
          _navigateToDisconnectScreen();
          return;
        }
      }
      
      if (mounted) {
      showSimpleNotification(
          Text(
            "⚠️ An error occurred. Please try again.",
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(Icons.warning_rounded, color: Colors.white),
          background: Colors.orange,
          elevation: 8,
        );
      }
    } finally {
      if (mounted) {
      setState(() => isSubmitting = false);
      }
    }
  }
}
