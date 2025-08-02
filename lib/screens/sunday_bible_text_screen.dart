import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:overlay_support/overlay_support.dart';
import 'dart:convert';
// import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bcsv_flutter_project/services/api_data_fetch.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/components/list_tile.dart';
import 'package:bcsv_flutter_project/data_models/data_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bcsv_flutter_project/data_models/model_param.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBibleTextFromGoogleSheet();
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
      body: isLoading
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

  /// Refresh data when user pulls down
  Future<void> _refreshData() async {
    log('🔄 User initiated refresh for Sunday bible text');
    setState(() {
      bibleTextTiles.clear();
    });
    await getBibleTextFromGoogleSheet();
  }

  Future<void> getBibleTextFromGoogleSheet() async {
    //Show loading spinner
    setState(() {
      isLoading = true;
    });

    ModelParam modelParam = ModelParam(
      apiEndpoint: ApiEndpoint.apiMap['BIBLE_TEXT']!,
      tag: 'bibleText',
      cacheFileName: kBibleTextData,
      getSharedReference: UserSharedPreferences.getBibleTextCache,
      setSharedReference: UserSharedPreferences.setBibleTextCache,
    );

    Map data = {};
    ApiGoogleDocContent myGoogleDocContent = ApiGoogleDocContent(
        modelParam: modelParam, body: data, isBodyRequired: false);

    String _bibleTextList = await myGoogleDocContent.getContent();
    var jsonObj = jsonDecode(_bibleTextList)[modelParam.tag] as List;

    List<dynamic> bibleTextList =
        jsonObj.map((tagJson) => BibleText.fromJson(tagJson)).toList();

    setState(
      () {
        String referenceText = "";
        String reviewQuestion = "";

        for (BibleText content in bibleTextList.reversed) {
          if (content.title.isEmpty && content.category == 'ReferenceText') {
            referenceText +=
                "\n\n📚참고본문: ${content.bibleChapter}\n${content.bibleText}";
          } else if (content.title.isEmpty &&
              content.category == 'ReviewQuestion') {
            reviewQuestion +=
                "\n\n✏️말씀 Review: ${content.bibleChapter}\n${content.bibleText}";
          } else {
            bibleTextTiles.add(
              ContentListTile(
                icon: FontAwesomeIcons.bookBible,
                headerText: Text('${content.date}\n${content.title}',
                    style: kBodyTextStyle(context)),
                contents: [
                  ElevatedButton(
                    child: Text(AppLocalizations.of(context)!.copy),
                    onPressed: () async {
                      showMessage("Bible Text");
                      Clipboard.setData(ClipboardData(
                          text:
                              "${content.bibleText} $referenceText $reviewQuestion"));
                    },
                  ),
                  SelectableText(
                          "📖본문: ${content.bibleText} $referenceText $reviewQuestion",
                          style: kBodyTextStyle(context))
                      .animate()
                      .fade(duration: 500.ms),
                  Center(
                    child: content.fileUrl.toString().isEmpty
                        ? null
                        : ElevatedButton(
                            child: const Text('Open PDF'),
                            onPressed: () async {
                              final Uri url = Uri.parse(content.fileUrl);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                          ),
                  ),
                ],
              ),
            );
            referenceText = '';
            reviewQuestion = '';
          }
        }

        //Hide loading spinner
        isLoading = false;
      },
    );
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
