import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/link.dart';
import 'dart:convert';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/data_models/model_param.dart';
import 'package:bcsv_flutter_project/components/list_tile.dart';
import 'package:bcsv_flutter_project/services/api_data_fetch.dart';
import 'package:bcsv_flutter_project/data_models/data_model.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';

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

  var announcementTiles = <ContentListTile>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withValues(alpha:0.5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: kNavBackButtonColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppBarHeaderText(
            text1: AppLocalizations.of(context)!.announcement, text2: ''),
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
                        color: Colors.grey,
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
    ModelParam modelParam = ModelParam(
      apiEndpoint: ApiEndpoint.apiMap['ANNOUNCEMENT'],
      tag: 'announcements',
      cacheFileName: kAnnouncementData,
      getSharedReference: UserSharedPreferences.getAnnouncementCache,
      setSharedReference: UserSharedPreferences.setAnnouncementCache,
    );

    Map data = {};
    ApiGoogleDocContent myGoogleDocContent = ApiGoogleDocContent(
        modelParam: modelParam, body: data, isBodyRequired: false);

    String _announcementList = await myGoogleDocContent.getContent();
    var jsonObj = jsonDecode(_announcementList)[modelParam.tag] as List;

    List<dynamic> announcementList =
        jsonObj.map((tagJson) => Announcement.fromJson(tagJson)).toList();

    setState(
      () {
        for (Announcement content in announcementList.reversed) {
          if (content.announcement.isEmpty) {
            continue;
          }
          announcementTiles.add(
            ContentListTile(
              icon: Icons.calendar_today_outlined,
              headerText: Text('${content.date}  설교 ${content.preacher}',
                  style: kBodyTextStyle(context)),
              contents: [
                Text('기도 ${content.prayer}', style: kBodyTextStyle(context)),
                SelectableText(
                    '광고내용\n${content.announcement}\n\n헌금: ${content.offering}',
                    style: kBodyTextStyle(context)).animate().fade(duration: 500.ms),
                Center(
                  child: content.File_url.toString().isEmpty
                      ? null
                      : Link(
                          target: LinkTarget.blank,
                          uri: Uri.parse(content.File_url),
                          builder: (context, followLink) => ElevatedButton(
                            child: const Text('Open PDF'),
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
      leading: tile.icon != null ? Icon(tile.icon) : null,
      title: tile.headerText,
      iconColor: Theme.of(context).colorScheme.surface,
      //tileColor: Theme.of(context).colorScheme.onSurface,
      // selectedTileColor: Colors.indigo,
    );
  }

  Widget buildContentTile(Widget content) {
    return ListTile(
      title: content,
    );
  }
}
