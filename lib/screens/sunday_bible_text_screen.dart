import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:bcsv_flutter_project/presentation/providers/sunday_bible_text_provider.dart';
import 'package:bcsv_flutter_project/domain/entities/sunday_bible_text.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/loading_shimmer.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/empty_state.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/error_state.dart';
import 'package:bcsv_flutter_project/presentation/shared/widgets/offline_banner.dart';
import 'dart:developer';

class SundayBibleTextScreen extends ConsumerStatefulWidget {
  const SundayBibleTextScreen({super.key});

  @override
  ConsumerState<SundayBibleTextScreen> createState() => _SundayBibleTextScreenState();
}

class _SundayBibleTextScreenState extends ConsumerState<SundayBibleTextScreen> {
  // Search filter variables
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  int fromMonth = DateTime.now().month;
  int toMonth = DateTime.now().month;
  String keyword = '';

  // UI Controllers
  final TextEditingController _keywordController = TextEditingController();

  // UI State for collapsible filter
  bool _isFilterExpanded = false;

  @override
  void initState() {
    super.initState();
    // Load data after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _performSearch();
    });
  }

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sundayBibleTextNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withValues(alpha: 0.5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: kNavBackButtonColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppBarHeaderText(
          text1: AppLocalizations.of(context)!.sermonBibleText,
          text2: '',
        ),
        actions: [
          OfflineBanner(
            isOffline: state.isOfflineData,
            lastUpdated: state.lastUpdated,
            style: OfflineBannerStyle.icon,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Compact search filters section
            _buildCompactSearchFilters(),

            // Content section
            Expanded(
              child: state.isLoading
                  ? _buildLoadingState()
                  : state.hasError
                      ? _buildErrorState(state.errorMessage)
                      : RefreshIndicator(
                          onRefresh: _refreshData,
                          child: state.isEmpty
                              ? _buildEmptyState()
                              : SingleChildScrollView(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  child: _buildBibleTextList(state.texts),
                                ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build list of Bible texts as expansion panels
  Widget _buildBibleTextList(List<SundayBibleTextEntity> texts) {
    // Convert entities to expansion panels
    return ExpansionPanelList.radio(
      children: texts.map((text) => _buildBibleTextPanel(text)).toList(),
    );
  }

  /// Build a single Bible text panel
  ExpansionPanelRadio _buildBibleTextPanel(SundayBibleTextEntity text) {
    return ExpansionPanelRadio(
      value: '${text.date}_${text.title}', // Unique value for expansion
      canTapOnHeader: true,
      headerBuilder: (context, isExpanded) => _buildPanelHeader(text),
      body: _buildPanelBody(text),
    );
  }

  /// Build panel header
  Widget _buildPanelHeader(SundayBibleTextEntity text) {
    final theme = Theme.of(context);

    return ListTile(
      tileColor: theme.colorScheme.surface,
      title: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                text.date,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Title
            Text(
              text.title,
              style: kBodyTextStyle(context).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            // Bible chapter
            Text(
              text.bibleChapter,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms),
    );
  }

  /// Build panel body with content
  Widget _buildPanelBody(SundayBibleTextEntity text) {
    final theme = Theme.of(context);

    // Build complete text for copying
    final buffer = StringBuffer();
    buffer.write(text.bibleText);

    for (final ref in text.references) {
      buffer.write('\n\n📚참고본문: ${ref.bibleChapter}\n${ref.bibleText}');
    }

    if (text.reviewQuestion != null) {
      final reviewQ = text.reviewQuestion!;
      buffer.write('\n\n✏️말씀 Review: ${reviewQ.bibleChapter.isNotEmpty ? '${reviewQ.bibleChapter}\n' : ''}${reviewQ.bibleText}');
    }

    final completeText = buffer.toString();

    return Column(
      children: [
        // Action buttons row
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.copy, size: 18),
                  label: Text(AppLocalizations.of(context)!.copy),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primaryContainer,
                    foregroundColor: theme.colorScheme.onPrimaryContainer,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: completeText));
                    _showCopiedMessage('Bible Text');
                  },
                ),
              ),
              if (text.hasPdfAttachment) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.picture_as_pdf, size: 18),
                    label: const Text('PDF'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.secondaryContainer,
                      foregroundColor: theme.colorScheme.onSecondaryContainer,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    onPressed: () => _openPdfUrl(text.fileUrl),
                  ),
                ),
              ],
            ],
          ),
        ).animate().scale(duration: 300.ms),

        // Bible text content
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: SelectableText(
            '📖본문:\n${text.bibleText}',
            style: kBodyTextStyle(context).copyWith(height: 1.6),
          ),
        ).animate().fade(duration: 500.ms),

        // References section
        if (text.hasReferences)
          ...text.references.map((ref) => Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.2),
              ),
            ),
            child: SelectableText(
              '📚참고본문: ${ref.bibleChapter}\n${ref.bibleText}',
              style: kBodyTextStyle(context).copyWith(
                height: 1.5,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ).animate().slideX(begin: 0.2, end: 0)),

        // Review question section
        if (text.hasReviewQuestion)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.secondary.withValues(alpha: 0.2),
              ),
            ),
            child: SelectableText(
              '✏️말씀 Review: ${text.reviewQuestion!.bibleChapter.isNotEmpty ? '${text.reviewQuestion!.bibleChapter}\n' : ''}${text.reviewQuestion!.bibleText}',
              style: kBodyTextStyle(context).copyWith(
                height: 1.5,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ).animate().slideY(begin: 0.2, end: 0),

        const SizedBox(height: 8),
      ],
    );
  }

  /// Show copied notification
  void _showCopiedMessage(String title) {
    showSimpleNotification(
      Text('$title copied to clipboard'),
      leading: const Icon(Icons.content_paste_outlined),
      background: Colors.blueAccent,
      elevation: 5,
    );
  }

  /// Open PDF URL
  Future<void> _openPdfUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open PDF: $url')),
        );
      }
    }
  }

  /// Build modern loading state
  Widget _buildLoadingState() {
    return const LoadingIndicator(
      style: LoadingStyle.spinner,
      size: 50.0,
    );
  }

  /// Build empty state when no bible texts are available
  Widget _buildEmptyState() {
    return EmptyState(
      icon: FontAwesomeIcons.bookBible,
      title: AppLocalizations.of(context)?.sermonBibleText ?? 'No Bible Texts',
      message: 'No Bible texts found for the selected filters.\nTry adjusting your search criteria.',
      actionLabel: AppLocalizations.of(context)?.tryAgain ?? 'Refresh',
      onAction: _refreshData,
    );
  }

  /// Build error state
  Widget _buildErrorState(String? errorMessage) {
    return ErrorState(
      title: 'Failed to load Bible texts',
      message: errorMessage,
      errorType: ErrorType.unknown,
      onRetry: _refreshData,
      retryLabel: AppLocalizations.of(context)?.tryAgain ?? 'Try Again',
    );
  }

  /// Build compact search filters UI with collapsible design
  Widget _buildCompactSearchFilters() {
    final theme = Theme.of(context);
    
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Compact header with quick filters
          _buildQuickFilterHeader(),
          
          // Expandable detailed filters
          if (_isFilterExpanded) _buildExpandedFilters(),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  /// Build quick filter header
  Widget _buildQuickFilterHeader() {
    final theme = Theme.of(context);
    
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          // Quick search row with keyword and search button
          Row(
            children: [
              // Keyword search field (compact)
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: _keywordController,
                    decoration: InputDecoration(
                      hintText: 'Search keyword...',
                      prefixIcon: Icon(Icons.search, size: 20),
                      suffixIcon: _keywordController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear, size: 18),
                              onPressed: () {
                                _keywordController.clear();
                                setState(() {
                                  keyword = '';
                                });
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: theme.colorScheme.outline.withValues(alpha: 0.3),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: theme.colorScheme.outline.withValues(alpha: 0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    onChanged: (value) {
                      setState(() {
                        keyword = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(width: 8),
              
              // Search button
              SizedBox(
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: _performSearch,
                  icon: Icon(Icons.search, size: 18),
                  label: Text('Search'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              
              // Expand/collapse button
              IconButton(
                icon: Icon(
                  _isFilterExpanded ? Icons.expand_less : Icons.expand_more,
                  color: theme.colorScheme.primary,
                ),
                onPressed: () {
                  setState(() {
                    _isFilterExpanded = !_isFilterExpanded;
                  });
                },
                tooltip: _isFilterExpanded ? 'Hide filters' : 'Show more filters',
              ),
            ],
          ),
          
          // Quick filter chips
          SizedBox(height: 8),
          Row(
            children: [
              // Year chip
              _buildFilterChip(
                label: selectedYear.toString(),
                icon: Icons.calendar_today,
                onTap: () {
                  setState(() {
                    _isFilterExpanded = true;
                  });
                },
              ),
              SizedBox(width: 8),
              
              // Month chip
              _buildFilterChip(
                label: fromMonth == toMonth 
                    ? 'Month $fromMonth' 
                    : 'Months $fromMonth-$toMonth',
                icon: Icons.date_range,
                onTap: () {
                  setState(() {
                    _isFilterExpanded = true;
                  });
                },
              ),
              
              // Active filters indicator
              if (keyword.isNotEmpty) ...[
                SizedBox(width: 8),
                _buildFilterChip(
                  label: 'Keyword',
                  icon: Icons.label,
                  isActive: true,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  /// Build filter chip
  Widget _buildFilterChip({
    required String label,
    required IconData icon,
    VoidCallback? onTap,
    bool isActive = false,
  }) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isActive 
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.secondaryContainer.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive 
                ? theme.colorScheme.primary.withValues(alpha: 0.3)
                : theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: isActive 
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            SizedBox(width: 4),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: isActive 
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build expanded filters (detailed filter options)
  Widget _buildExpandedFilters() {
    final theme = Theme.of(context);
    
    return Container(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Column(
        children: [
          Divider(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
          SizedBox(height: 8),
          
          // Year and Month row
          Row(
            children: [
              // Year dropdown
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Year',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      height: 36,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.outline.withValues(alpha: 0.3),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: selectedYear,
                          isExpanded: true,
                          isDense: true,
                          items: List.generate(5, (index) {
                            final year = DateTime.now().year - 2 + index;
                            return DropdownMenuItem<int>(
                              value: year,
                              child: Text(year.toString(), style: theme.textTheme.bodySmall),
                            );
                          }),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedYear = value;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              
              // Month dropdown
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Month',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      height: 36,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.outline.withValues(alpha: 0.3),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: selectedMonth,
                          isExpanded: true,
                          isDense: true,
                          items: List.generate(12, (index) {
                            final month = index + 1;
                            final monthNames = [
                              'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                              'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                            ];
                            return DropdownMenuItem<int>(
                              value: month,
                              child: Text(
                                '${month.toString().padLeft(2, '0')} ${monthNames[index]}',
                                style: theme.textTheme.bodySmall,
                              ),
                            );
                          }),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedMonth = value;
                                // Auto-update month range
                                fromMonth = value;
                                toMonth = value;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          
          // Month range row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From Month',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      height: 36,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.outline.withValues(alpha: 0.3),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: fromMonth,
                          isExpanded: true,
                          isDense: true,
                          items: List.generate(12, (index) {
                            final month = index + 1;
                            return DropdownMenuItem<int>(
                              value: month,
                              child: Text(month.toString().padLeft(2, '0'), style: theme.textTheme.bodySmall),
                            );
                          }),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                fromMonth = value;
                                if (toMonth < fromMonth) {
                                  toMonth = fromMonth;
                                }
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'To Month',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      height: 36,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.outline.withValues(alpha: 0.3),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: toMonth,
                          isExpanded: true,
                          isDense: true,
                          items: List.generate(12, (index) {
                            final month = index + 1;
                            return DropdownMenuItem<int>(
                              value: month,
                              child: Text(month.toString().padLeft(2, '0'), style: theme.textTheme.bodySmall),
                            );
                          }),
                          onChanged: (value) {
                            if (value != null && value >= fromMonth) {
                              setState(() {
                                toMonth = value;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().slideY(begin: -0.3, end: 0);
  }

  /// Build original search filters UI (backup method)
  Widget _buildSearchFilters() {
    final theme = Theme.of(context);
    
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                FontAwesomeIcons.filter,
                color: theme.colorScheme.primary,
                size: 18,
              ),
              SizedBox(width: 8),
              Text(
                'Search Filters',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          
          // Year and Month row
          Row(
            children: [
              // Year dropdown
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Year',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.outline.withValues(alpha: 0.3),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: selectedYear,
                          isExpanded: true,
                          items: List.generate(5, (index) {
                            final year = DateTime.now().year - 2 + index;
                            return DropdownMenuItem<int>(
                              value: year,
                              child: Text(year.toString()),
                            );
                          }),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedYear = value;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              
              // Month dropdown
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Month',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.outline.withValues(alpha: 0.3),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: selectedMonth,
                          isExpanded: true,
                          items: List.generate(12, (index) {
                            final month = index + 1;
                            final monthNames = [
                              'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                              'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                            ];
                            return DropdownMenuItem<int>(
                              value: month,
                              child: Text('${month.toString().padLeft(2, '0')} ${monthNames[index]}'),
                            );
                          }),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedMonth = value;
                                // Auto-update month range
                                fromMonth = value;
                                toMonth = value;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          
          // Month range row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From Month',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.outline.withValues(alpha: 0.3),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: fromMonth,
                          isExpanded: true,
                          items: List.generate(12, (index) {
                            final month = index + 1;
                            return DropdownMenuItem<int>(
                              value: month,
                              child: Text(month.toString().padLeft(2, '0')),
                            );
                          }),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                fromMonth = value;
                                if (toMonth < fromMonth) {
                                  toMonth = fromMonth;
                                }
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'To Month',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.outline.withValues(alpha: 0.3),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: toMonth,
                          isExpanded: true,
                          items: List.generate(12, (index) {
                            final month = index + 1;
                            return DropdownMenuItem<int>(
                              value: month,
                              child: Text(month.toString().padLeft(2, '0')),
                            );
                          }),
                          onChanged: (value) {
                            if (value != null && value >= fromMonth) {
                              setState(() {
                                toMonth = value;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          
          // Keyword search
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Keyword',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              SizedBox(height: 4),
              TextField(
                controller: _keywordController,
                decoration: InputDecoration(
                  hintText: 'Enter keyword to search...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: _keywordController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            _keywordController.clear();
                            setState(() {
                              keyword = '';
                            });
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: theme.colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: theme.colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    keyword = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          
          // Search button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _performSearch,
              icon: Icon(Icons.search),
              label: Text('Search'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2, end: 0);
  }

  /// Perform search with current filter settings
  Future<void> _performSearch() async {
    log('🔍 Performing search: Year=$selectedYear, Month=$selectedMonth, Range=$fromMonth-$toMonth, Keyword="$keyword"');

    final notifier = ref.read(sundayBibleTextNotifierProvider.notifier);

    // Set year first
    if (selectedYear != ref.read(sundayBibleTextNotifierProvider).filter.year) {
      await notifier.setYear(selectedYear);
    }

    // Handle keyword search vs month filtering
    if (keyword.trim().isNotEmpty) {
      // Keyword search takes precedence
      await notifier.setKeyword(keyword.trim());
    } else {
      // Month filtering
      if (fromMonth == toMonth) {
        await notifier.setMonth(fromMonth);
      } else {
        await notifier.setMonthRange(fromMonth, toMonth);
      }
    }
  }

  /// Refresh data when user pulls down
  Future<void> _refreshData() async {
    log('🔄 User initiated refresh for Sunday bible text');
    await ref.read(sundayBibleTextNotifierProvider.notifier).refresh();
  }
}
