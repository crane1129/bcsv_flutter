import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/components/list_tile.dart';
import 'package:bcsv_flutter_project/services/api_get_google_doc_contents.dart';
import 'package:bcsv_flutter_project/data_models/endpoint_model.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:url_launcher/link.dart';

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

  var announcementTiles = <AnnounceListTile>[];

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

  void getAnnouncementFromGoogleSheet() async {
    //Show loading spinner
    isLoading = true;

    ApiGoogleDocContent myGoogleDocContent = ApiGoogleDocContent(
        api_endpoint: ApiEndpoint.apiMap['ANNOUNCEMENT'],
        tag: 'announcements');

    List<dynamic> announcementList = await myGoogleDocContent.getContent();

    setState(
      () {
        for (Announcement content in announcementList) {
          if (content.announcement.isEmpty) {
            continue;
          }
          announcementTiles.add(
            AnnounceListTile(
              icon: Icons.calendar_today_outlined,
              headerText: '주일: ${content.date}',
              contents: [
                Text('설교 ${content.preacher}', style: kBodyTextStyle),
                Text('기도 ${content.prayer}', style: kBodyTextStyle),
                SelectableText('광고내용\n${content.announcement}',
                    style: kBodyTextStyle),
                Center(
                  child: Link(
                    target: LinkTarget.blank,
                    uri: Uri.parse(content.File_url),
                    builder: (context, followLink) => ElevatedButton(
                      child: content.File_url.toString().isEmpty
                          ? const Text('PDF not available')
                          : const Text('Open PDF'),
                      onPressed: followLink,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        //Hide loading spinner
        isLoading = false;
      },
    );
  }

  Widget _buildListPanel() {
    return ExpansionPanelList.radio(
      children: announcementTiles
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

  Widget buildHeaderTile(AnnounceListTile tile) {
    return ListTile(
        leading: tile.icon != null ? Icon(tile.icon) : null,
        title: Text(tile.headerText));
  }

  Widget buildContentTile(Widget content) {
    return ListTile(
      title: content,
    );
  }
}
