import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:overlay_support/overlay_support.dart';
import 'dart:convert';
import 'dart:async';
// import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/components/list_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:developer';

class SundayBibleTextScreen extends StatefulWidget {
  const SundayBibleTextScreen({Key? key}) : super(key: key);

  @override
  _SundayBibleTextScreenState createState() => _SundayBibleTextScreenState();
}

class _SundayBibleTextScreenState extends State<SundayBibleTextScreen> {
  bool isLoading = true;  // Start with loading spinner

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
    getBibleTextFromDataSource();
  }

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  var bibleTextTiles = <ContentListTile>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withValues(alpha: 0.5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: kNavBackButtonColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppBarHeaderText(
            text1: AppLocalizations.of(context)!.sermonBibleText, text2: ''),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Compact search filters section
            _buildCompactSearchFilters(),
            
            // Content section
            Expanded(
              child: isLoading
                  ? _buildLoadingState()
                  : RefreshIndicator(
                      onRefresh: _refreshData,
                      child: bibleTextTiles.isEmpty
                          ? _buildEmptyState()
                          : SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: _buildListPanel(),
                            ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListPanel() {
    return ExpansionPanelList.radio(
      children: bibleTextTiles
          .map(
            (tile) => ExpansionPanelRadio(
              //backgroundColor: Theme.of(context).colorScheme.onSurface,
              value: tile.headerText,
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) => buildHeaderTile(tile),
              body: Column(
                children: tile.contents.map(buildContentTile).toList(),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget buildHeaderTile(ContentListTile tile) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.surface,
        leading: tile.icon != null
            ? Icon(tile.icon, color: Theme.of(context).colorScheme.surface)
            : null,
        title: tile.headerText);
  }

  Widget buildContentTile(Widget content) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.surface,
      title: content,
    );
  }

  /// Build modern loading state
  Widget _buildLoadingState() {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: SpinKitFadingCube(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)?.dataLoading ?? 'Loading Bible text...',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  /// Build empty state when no bible texts are available
  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.bookBible,
            size: 80,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)?.sermonBibleText ?? 'No texts available',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'Pull down to refresh or check your connection',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _refreshData,
            icon: Icon(Icons.refresh),
            label: Text(AppLocalizations.of(context)?.tryAgain ?? 'Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
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
  void _performSearch() {
    log('🔍 Performing search: Year=$selectedYear, Month=$selectedMonth, Range=$fromMonth-$toMonth, Keyword="$keyword"');
    getBibleTextFromDataSource();
  }

  /// Refresh data when user pulls down
  Future<void> _refreshData() async {
    log('🔄 User initiated refresh for Sunday bible text v2');
    setState(() {
      bibleTextTiles.clear();
    });
    getBibleTextFromDataSource();
  }

  /// Main data loading method with search parameters
  Future<void> getBibleTextFromDataSource() async {
    try {
      // Show loading spinner
      setState(() {
        isLoading = true;
        bibleTextTiles.clear();
      });

      log('🔄 Loading Bible text data with filters: Year=$selectedYear, Month=$selectedMonth, Range=$fromMonth-$toMonth, Keyword="$keyword"');

      // Build URL with query parameters
      String baseUrl = 'https://script.google.com/macros/s/AKfycbwCn5iCa3MK1fPtz8y_Ut5PP-HlwWs-K8_YDrJW_UQpCOUEkQTf8xjpqOTt2ah6MnLX7A/exec';
      List<String> queryParams = [];
      
      // Always add year
      queryParams.add('year=$selectedYear');
      
      // Add keyword if provided - when keyword is present, skip month filters
      if (keyword.trim().isNotEmpty) {
        queryParams.add('keyword=${Uri.encodeComponent(keyword.trim())}');
        log('🔍 Using keyword search: "${keyword.trim()}" - skipping month filters');
      } else {
        // Only add month filters when no keyword is provided
        if (fromMonth == toMonth) {
          // Exact month filter
          queryParams.add('month=$fromMonth');
          log('📅 Using exact month filter: $fromMonth');
        } else {
          // Month range filter
          queryParams.add('start=$fromMonth');
          queryParams.add('end=$toMonth');
          log('📅 Using month range filter: $fromMonth to $toMonth');
        }
      }
      
      String finalUrl = '$baseUrl?${queryParams.join('&')}';
      log('🌐 Request URL: $finalUrl');

      // Make HTTP request directly
      final response = await http.get(
        Uri.parse(finalUrl),
        headers: {"Content-Type": "application/json"},
      ).timeout(
        Duration(seconds: 30),
        onTimeout: () => throw TimeoutException('Request timeout', Duration(seconds: 30)),
      );
      
      if (response.statusCode != 200) {
        log('❌ HTTP Error: ${response.statusCode} - ${response.reasonPhrase}');
        throw Exception('HTTP Error: ${response.statusCode}');
      }

      String responseData = response.body;
      
      if (responseData.isEmpty) {
        log('❌ Empty response received from API');
        throw Exception('No data received from server');
      }

      log('📥 Received data: ${responseData.length} characters');
      log('📄 Response preview: ${responseData.length > 200 ? responseData.substring(0, 200) + "..." : responseData}');

      var jsonObj = jsonDecode(responseData);
      
      // Handle response format
      List<dynamic> bibleTextList;
      if (jsonObj is Map && jsonObj.containsKey('bibleText')) {
        bibleTextList = jsonObj['bibleText'] as List;
      } else if (jsonObj is List) {
        bibleTextList = jsonObj;
      } else {
        throw Exception('Unexpected response format: ${jsonObj.runtimeType}');
      }

      log('✅ Parsed ${bibleTextList.length} Bible text entries');

      await _buildBibleTextTilesFromApi(bibleTextList);

      setState(() {
        isLoading = false;
      });

      log('🎉 Bible text data loaded successfully: ${bibleTextTiles.length} tiles created');

    } catch (e, stackTrace) {
      log('❌ Error loading Bible text data: $e');
      log('Stack trace: $stackTrace');
      
      setState(() {
        isLoading = false;
      });

      // Show error to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load Bible texts: ${e.toString()}'),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: () {
                log('🔁 User requested retry');
                getBibleTextFromDataSource();
              },
            ),
          ),
        );
      }
    }
  }

  /// Build Bible text tiles from API response data
  Future<void> _buildBibleTextTilesFromApi(List<dynamic> bibleTextList) async {
    List<ContentListTile> newTiles = [];

    for (var item in bibleTextList) {
      try {
        // Extract basic information
        String date = item['Date'] ?? '';
        String title = item['Title'] ?? '';
        String bibleChapter = item['Bible_chapter'] ?? '';
        String bibleText = item['Bible_text'] ?? '';
        String fileUrl = item['File_url'] ?? '';
        
        // Process References
        String referencesText = "";
        if (item['References'] != null && item['References'] is List) {
          List<dynamic> references = item['References'];
          for (var ref in references) {
            if (ref['Text_Class'] == 'ReferenceText') {
              referencesText += "\n\n📚참고본문: ${ref['Bible_chapter']}\n${ref['Bible_text']}";
            }
          }
        }
        
        // Process Review Question
        String reviewQuestionText = "";
        if (item['ReviewQuestion'] != null) {
          var reviewQ = item['ReviewQuestion'];
          if (reviewQ['Text_Class'] == 'ReviewQuestion') {
            String chapter = reviewQ['Bible_chapter'] ?? '';
            String questionText = reviewQ['Bible_text'] ?? '';
            reviewQuestionText = "\n\n✏️말씀 Review: ${chapter.isNotEmpty ? '$chapter\n' : ''}$questionText";
          }
        }

        // Build complete text for copying
        String completeText = "$bibleText$referencesText$reviewQuestionText";

        // Create tile
        newTiles.add(
          ContentListTile(
            icon: FontAwesomeIcons.bookBible,
            headerText: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      date,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  // Title
                  Text(
                    title,
                    style: kBodyTextStyle(context).copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  // Bible chapter
                  Text(
                    bibleChapter,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms),
            contents: [
              // Action buttons row
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.copy, size: 18),
                        label: Text(AppLocalizations.of(context)!.copy),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                          padding: EdgeInsets.symmetric(vertical: 8),
                        ),
                        onPressed: () async {
                          showMessage("Bible Text");
                          Clipboard.setData(ClipboardData(text: completeText));
                        },
                      ),
                    ),
                    if (fileUrl.isNotEmpty) ...[
                      SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.picture_as_pdf, size: 18),
                          label: Text('PDF'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                            foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
                            padding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          onPressed: () async {
                            final Uri url = Uri.parse(fileUrl);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url, mode: LaunchMode.externalApplication);
                            } else {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Could not open PDF: $fileUrl')),
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ).animate().scale(duration: 300.ms),
              
              // Bible text content
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                  ),
                ),
                child: SelectableText(
                  "📖본문:\n$bibleText",
                  style: kBodyTextStyle(context).copyWith(
                    height: 1.6,
                  ),
                ),
              ).animate().fade(duration: 500.ms),
              
              // References section
              if (referencesText.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: SelectableText(
                    referencesText.trim(),
                    style: kBodyTextStyle(context).copyWith(
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                ).animate().slideX(begin: 0.2, end: 0),
              
              // Review question section
              if (reviewQuestionText.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: SelectableText(
                    reviewQuestionText.trim(),
                    style: kBodyTextStyle(context).copyWith(
                      height: 1.5,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                ).animate().slideY(begin: 0.2, end: 0),
            ],
          ),
        );

        log('✅ Created tile for: $title ($date)');
        
      } catch (e) {
        log('❌ Error processing Bible text item: $e');
        log('   Item data: $item');
        continue; // Skip this item and continue with the next
      }
    }

    bibleTextTiles.addAll(newTiles);
    log('📊 Total tiles created: ${newTiles.length}');
  }

  void showMessage(title) {
    showSimpleNotification(
        Text(
          title + " copied to clipboard",
        ),
        leading: Icon(Icons.content_paste_outlined),
        background: Colors.blueAccent,
        elevation: 5);
  }
}