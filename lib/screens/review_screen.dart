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

class SermonReviewScreen extends StatefulWidget {
  const SermonReviewScreen({Key? key}) : super(key: key);

  @override
  _SermonReviewScreenState createState() => _SermonReviewScreenState();
}

class _SermonReviewScreenState extends State<SermonReviewScreen> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSermonReviewFromGoogleSheet();
  }

  var SermonReviewTiles = <ContentListTile>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.5),
        title: AppBarHeaderText(text1: 'Sermon Review', text2: ''),
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
      children: SermonReviewTiles.map(
        (tile) => ExpansionPanelRadio(
          value: tile.headerText,
          canTapOnHeader: true,
          headerBuilder: (context, isExpanded) => buildHeaderTile(tile),
          body: Column(
            children: tile.contents.map(buildContentTile).toList(),
          ),
        ),
      ).toList(),
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

  void getSermonReviewFromGoogleSheet() async {
    //Show loading spinner
    isLoading = true;

    ModelParam modelParam = ModelParam(
      apiEndpoint: ApiEndpoint.apiMap['BIBLE_REVIEW'],
      tag: 'sundayReview',
      cacheFileName: kBibleTextData,
      getSharedReference: UserSharedPreferences.getBibleReviewCache,
      setSharedReference: UserSharedPreferences.setBibleReviewCache,
    );

    Map data = {};
    ApiGoogleDocContent myGoogleDocContent = ApiGoogleDocContent(
        modelParam: modelParam, body: data, isBodyRequired: false);

    String _reviewTextList = await myGoogleDocContent.getContent();
    var jsonObj = jsonDecode(_reviewTextList)[modelParam.tag] as List;

    List<dynamic> reviewTextList =
        jsonObj.map((tagJson) => SermonReview.fromJson(tagJson)).toList();

    setState(
      () {
        String applicationText = "";
        String inDepthText = "";
        String reviewText = "";

        for (SermonReview content in reviewTextList.reversed) {
          if (content.title.isEmpty) {
            if (content.review.isNotEmpty) {
              //This is InDepth question
              reviewText += "\n📚복습 질문: ${content.review}\n";
            } else if (content.application.isNotEmpty) {
              //This is application question
              applicationText += "\n️💁‍♀️적용 질문: ${content.application}\n";
            } else if (content.in_depth.isNotEmpty) {
              //This is application question
              inDepthText += "\n🎓심화학습 질문: ${content.in_depth}\n";
            }
          } else {
            print(applicationText);
            print(reviewText);
            print(inDepthText);

            SermonReviewTiles.add(
              ContentListTile(
                icon: FontAwesomeIcons.bible,
                headerText: Text('${content.date}\n${content.title}',
                    style: kBodyTextStyle),
                contents: [
                  SelectableText(
                      "📚복습질문: ${content.review}\n$reviewText\n💁‍♀️️적용질문: ${content.application}\n$applicationText\n🎓심화학습 질문: ${content.in_depth}\n$inDepthText",
                      style: kBodyTextStyle),
                ],
              ),
            );
            applicationText = '';
            inDepthText = '';
            reviewText = '';
          }
        }

        //Hide loading spinner
        isLoading = false;
      },
    );
  }
}
