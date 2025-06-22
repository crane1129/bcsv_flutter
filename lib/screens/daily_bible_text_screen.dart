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

double _fontSize = 16.0;

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

  Map<String, dynamic>? _headerData;
  String _bodyText = '';

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
            text1: AppLocalizations.of(context)!.dailyBible, text2: ''),
        actions: [
          IconButton(
            icon: Icon(Icons.font_download_outlined),
            onPressed: () {
              setState(() {
                _fontSize += 2;
              });
            },
            tooltip: 'Increase Font Size',
          ),
          IconButton(
            icon: Icon(Icons.font_download),
            onPressed: () {
              setState(() {
                _fontSize = (_fontSize - 2).clamp(10.0, 30.0);
              });
            },
            tooltip: 'Decrease Font Size',
          ),
        ],
      ),
      body: isLoading
          ? Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: SpinKitFadingCube(
            itemBuilder: (BuildContext context, int index) {
              return const DecoratedBox(
                decoration: BoxDecoration(color: Colors.grey),
              );
            },
          ),
        ),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            if (_headerData != null)
              ListTile(
                leading: Icon(FontAwesomeIcons.bookBible,
                    color: kActiveIconColor(context)),
                title: Text(
                  _headerData!['title'],
                  style: kBodyTextStyle(context, fontSize: _fontSize),
                ),
                subtitle: Text(
                  _headerData!['subtitle'],
                  style: kBodyTextStyle(context, fontSize: _fontSize),
                ),
              ),
            if (_bodyText.isNotEmpty)
              ListTile(
                title: SelectableText(
                  _bodyText,
                  style: kBodyTextStyle(context, fontSize: _fontSize),
                ).animate().fade(duration: 500.ms),
              ),
          ],
        ),
      ),

    );
  }

  void getDailyBibleText() async {
    //Show loading spinner
    isLoading = true;
    ModelParam modelParam = ModelParam(
      apiEndpoint: ApiEndpoint.apiMap['DAILY_BIBLE1']!,
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
      apiEndpoint: ApiEndpoint.apiMap['DAILY_BIBLE2']!,
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

    setState(() {
      _headerData = {
        'title': "${jsonObj1['Bible_name']}  ${jsonObj1['Bible_chapter']}",
        'subtitle': jsonObj1['Base_de'],
      };

      _bodyText = '';
      for (var word in jsonObj2) {
        _bodyText += "${word['Verse'].toString()} ${word['Bible_Cn']}\n\n";
      }

      isLoading = false;
    });
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
          content.isEmpty
              ? Text('N/A')
              : Text(content,
                  style: kBodyTextStyle(context, fontSize: _fontSize)),
        ],
      ),
    );
  }
}
