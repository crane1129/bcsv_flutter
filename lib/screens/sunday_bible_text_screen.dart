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

class SundayBibleTextScreen extends StatefulWidget {
  const SundayBibleTextScreen({Key? key}) : super(key: key);

  @override
  _SundayBibleTextScreenState createState() => _SundayBibleTextScreenState();
}

class _SundayBibleTextScreenState extends State<SundayBibleTextScreen> {
  bool isLoading = false;

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
        backgroundColor: Colors.transparent.withOpacity(0.5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: kNavBackButtonColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppBarHeaderText(
            text1: AppLocalizations.of(context)!.sermonBibleText, text2: ''),
      ),
      body: isLoading
          ? Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: SpinKitFadingCube(
                  itemBuilder: (BuildContext context, int index) {
                    return const DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            )
          : SingleChildScrollView(
              child: _buildListPanel(),
            ),
    );
  }

  Widget _buildListPanel() {
    return ExpansionPanelList.radio(
      children: bibleTextTiles
          .map(
            (tile) => ExpansionPanelRadio(
              backgroundColor: kActiveCardColor,
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
        leading:
            tile.icon != null ? Icon(tile.icon, color: kActiveIconColor) : null,
        title: tile.headerText);
  }

  Widget buildContentTile(Widget content) {
    return ListTile(
      title: content,
    );
  }

  void getBibleTextFromGoogleSheet() async {
    //Show loading spinner
    isLoading = true;

    ModelParam modelParam = ModelParam(
      apiEndpoint: ApiEndpoint.apiMap['BIBLE_TEXT'],
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
                    style: kBodyTextStyle),
                contents: [
                  ElevatedButton(
                    child: Text(AppLocalizations.of(context)!.copy),
                    onPressed: () async {
                      showMessage("Bible Text");
                      Clipboard.setData(
                          ClipboardData(text: "${content.bibleText}"));
                    },
                  ),
                  SelectableText(
                          "📖본문: ${content.bibleText} $referenceText $reviewQuestion",
                          style: kBodyTextStyle)
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
