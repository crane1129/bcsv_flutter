import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/components/advanced_tile.dart';
import 'package:bcsv_flutter_project/services/api_get_google_doc_contents.dart';
import 'package:bcsv_flutter_project/data_models/endpoint_model.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';

class AnnouncementPage extends StatefulWidget {
  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAnnouncementFromGoogleSheet();
  }

  var announcementTiles = <AdvancedTile>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: AppBarHeaderText(text1: 'Announcement', text2: ''),
      ),
      body: isLoading
          ? Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: SpinKitFadingCube(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            )
          : SingleChildScrollView(
              child: ExpansionPanelList.radio(
                children: announcementTiles
                    .map(
                      (tile) => ExpansionPanelRadio(
                        value: tile.title,
                        canTapOnHeader: true,
                        headerBuilder: (context, isExpanded) => buildTile(tile),
                        body: Column(
                          children: tile.tiles.map(buildTile).toList(),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
    );
  }

  Widget buildTile(AdvancedTile tile) {
    return ListTile(
      leading: tile.icon != null ? Icon(tile.icon) : null,
      title: tile.title,
    );
  }

  void getAnnouncementFromGoogleSheet() async {
    //Show loading spinner
    isLoading = true;

    ApiGoogleDocContent myGoogleDocContent = ApiGoogleDocContent(
        api_endpoint: ApiEndpoint.apiMap['ANNOUNCEMENT2'],
        tag: 'announcements');

    List<dynamic> announcementList = await myGoogleDocContent.getContent();

    setState(
      () {
        for (Announcement content in announcementList) {
          if (content.announcement.isEmpty) {
            continue;
          }
          announcementTiles.add(
            AdvancedTile(
              icon: Icons.book,
              title: Text(content.date, style: kBodyTextStyle),
              tiles: [
                AdvancedTile(
                    title:
                        Text('설교 ${content.preacher}', style: kBodyTextStyle),
                    icon: Icons.mic),
                AdvancedTile(
                    title: Text('기도 ${content.prayer}', style: kBodyTextStyle),
                    icon: FontAwesomeIcons.pray),
                AdvancedTile(
                    title: Text('광고내용\n${content.announcement}',
                        style: kBodyTextStyle),
                    icon: Icons.note),
              ],
            ),
          );
        }

        //Hide loading spinner
        isLoading = false;
      },
    );
  }
}
