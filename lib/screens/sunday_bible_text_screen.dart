import 'package:flutter/material.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:url_launcher/link.dart';
import 'package:bcsv_flutter_project/services/api_data_fetch.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/components/list_tile.dart';
import 'package:bcsv_flutter_project/data_models/data_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bcsv_flutter_project/data_models/model_param.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';

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
        title: AppBarHeaderText(text1: 'Sermon Bible Text', text2: ''),
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
        leading: tile.icon != null ? Icon(tile.icon) : null,
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
    ApiGoogleDocContent myGoogleDocContent =
        ApiGoogleDocContent(modelParam: modelParam, body: data, isBodyRequired: false);

    String _bibleTextList = await myGoogleDocContent.getContent();
    var jsonObj = jsonDecode(_bibleTextList)[modelParam.tag] as List;

    List<dynamic> bibleTextList =
        jsonObj.map((tagJson) => BibleText.fromJson(tagJson)).toList();

    setState(
      () {
        String referenceText = "";

        for (BibleText content in bibleTextList.reversed) {
          if (content.title.isEmpty) {
            //This is header title
            referenceText +=
                "\n\n📚참고본문: ${content.bibleChapter}\n${content.bibleText}";
          } else {
            //This is main text
            bibleTextTiles.add(
              ContentListTile(
                icon: FontAwesomeIcons.bible,
                headerText: Text('${content.date}\n${content.title}',
                    style: kBodyTextStyle),
                contents: [
                  SelectableText("📖본문: ${content.bibleText} $referenceText",
                      style: kBodyTextStyle),
                  Center(
                    child: content.fileUrl.toString().isEmpty
                        ? null
                        : Link(
                            target: LinkTarget.blank,
                            uri: Uri.parse(content.fileUrl),
                            builder: (context, followLink) => ElevatedButton(
                              child: const Text('Open PDF'),
                              onPressed: followLink,
                            ),
                          ),
                  ),
                ],
              ),
            );
            referenceText = '';
          }
        }

        //Hide loading spinner
        isLoading = false;
      },
    );
  }
}
