import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/data_models/model_param.dart';
import 'package:bcsv_flutter_project/services/api_data_fetch.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';


class DailyBibleTextScreen extends StatefulWidget {
  const DailyBibleTextScreen({Key? key}) : super(key: key);

  @override
  _DailyBibleTextScreenState createState() => _DailyBibleTextScreenState();
}

class _DailyBibleTextScreenState extends State<DailyBibleTextScreen> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDailyBibleText();
  }

  var dailyBibleTiles = <Widget>[];

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
        title: AppBarHeaderText(text1: AppLocalizations.of(context)!.dailyBible, text2: ''),
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
              child: Column(
                children: dailyBibleTiles,
              ),
            ),
    );
  }

  void getDailyBibleText() async {
    //Show loading spinner
    isLoading = true;
    ModelParam modelParam = ModelParam(
      apiEndpoint: ApiEndpoint.apiMap['DAILY_BIBLE1'],
      tag: '',
      cacheFileName: kDailyBible1Data,
      getSharedReference: UserSharedPreferences.getDailyBibleText1Cache,
      setSharedReference: UserSharedPreferences.setDailyBibleText1Cache,
    );

    DateTime now = DateTime.now();
    String formattedCurrentDate = DateFormat('yyyy-MM-dd').format(now);

    Map data = {'qt_ty': 'QT1', 'Base_de': formattedCurrentDate};
    ApiGoogleDocContent myGoogleDocContent = ApiGoogleDocContent(
        modelParam: modelParam, body: data, isBodyRequired: true);
    String dailyBibleText1 = await myGoogleDocContent.getContent();

    ModelParam modelParam2 = ModelParam(
      apiEndpoint: ApiEndpoint.apiMap['DAILY_BIBLE2'],
      tag: '',
      cacheFileName: kDailyBible2Data,
      getSharedReference: UserSharedPreferences.getDailyBibleText2Cache,
      setSharedReference: UserSharedPreferences.setDailyBibleText2Cache,
    );

    ApiGoogleDocContent myGoogleDocContent2 = ApiGoogleDocContent(
        modelParam: modelParam2, body: data, isBodyRequired: true);
    String dailyBibleText2 = await myGoogleDocContent2.getContent();

    var jsonObj1 = jsonDecode(dailyBibleText1);
    var jsonObj2 = jsonDecode(dailyBibleText2);

    setState(
      () {
        dailyBibleTiles.add(
          ListTile(
            leading: Icon(FontAwesomeIcons.bookBible, color: kActiveIconColor(context)),
            title: Text(
                "${jsonObj1['Bible_name']}  ${jsonObj1['Bible_chapter']}",
                style: kBodyTextStyle(context)),
            subtitle: Text(jsonObj1['Base_de'],style: kBodyTextStyle(context)),
          ),
        );

        String bodyText = '';

        for (var word in jsonObj2) {
          bodyText += "${word['Verse'].toString()} ${word['Bible_Cn']}\n\n";
        }

        dailyBibleTiles.add(
          ListTile(
            title: SelectableText(
              bodyText,
              style: kBodyTextStyle(context),
            ).animate().fade(duration: 500.ms),
          ),
        );

        // for (var word in jsonObj2) {
        //   dailyBibleTiles.add(
        //     ListTile(
        //       leading: Text(
        //         word['Chapter'].toString(),
        //       ),
        //       title: SelectableText(
        //         "${word['Verse'].toString()} ${word['Bible_Cn']}",
        //         style: kBodyTextStyle,
        //       ),
        //     ),
        //   );
        // }
        //Hide loading spinner
        isLoading = false;
      },
    );
  }
}

class DailyBibleTile extends StatelessWidget {
  const DailyBibleTile(
      {Key? key,
      required this.content,
      required this.leadingText,
      required this.subTitle})
      : super(key: key);

  final Widget leadingText;
  final String content;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingText,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          content.isEmpty ? Text('N/A') : Text(content, style: kBodyTextStyle(context)),
        ],
      ),
    );
  }
}
