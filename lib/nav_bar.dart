import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:bcsv_flutter_project/screens/bible_search_screen.dart';
import 'package:bcsv_flutter_project/screens/bible_keyword_search_screen.dart';
import 'package:bcsv_flutter_project/screens/keyverse_screen.dart';
import 'package:bcsv_flutter_project/screens/submit_opinion_screen.dart';
import 'package:bcsv_flutter_project/screens/unconfirmed_opinion_screen.dart';
import 'package:bcsv_flutter_project/screens/message_upload_screen.dart';
import 'package:bcsv_flutter_project/screens/message_management_screen.dart';
import 'package:bcsv_flutter_project/utilities/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bcsv_flutter_project/screens/daily_bible_text_screen.dart';
import 'package:bcsv_flutter_project/screens/setting_screen.dart';
import 'package:bcsv_flutter_project/components/webview/webview_screen.dart';
import 'package:bcsv_flutter_project/screens/offering_screen.dart';
import 'package:bcsv_flutter_project/screens/announcement_screen.dart';
import 'package:bcsv_flutter_project/screens/serving_turn_screen.dart';
import 'package:bcsv_flutter_project/screens/sunday_bible_text_screen.dart';
import 'package:bcsv_flutter_project/screens/about_screen.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:bcsv_flutter_project/services/api_endpoint.dart';
import 'package:bcsv_flutter_project/services/background_service.dart';
import 'package:bcsv_flutter_project/screens/reimbursement_screen.dart';
import 'package:bcsv_flutter_project/l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bcsv_flutter_project/presentation/providers/opinion_provider.dart';

class NavBar extends ConsumerStatefulWidget {
  const NavBar({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends ConsumerState<NavBar> {
  Widget emptyString = const SizedBox.shrink();
  Timer? _endpointCheckTimer;
  bool _endpointsInitialized = false;
  int _unconfirmedCount = 0;
  bool _isStaffMessageMode = false;
  bool _isStaffOpinionMode = false;

  @override
  void initState() {
    super.initState();
    _checkEndpointInitialization();
    _initStaffMode();
  }

  Future<void> _initStaffMode() async {
    final isMessage = await UserSharedPreferences.isStaffMessageModeEnabled();
    final isOpinion = await UserSharedPreferences.isStaffOpinionModeEnabled();
    if (!mounted) return;
    setState(() {
      _isStaffMessageMode = isMessage;
      _isStaffOpinionMode = isOpinion;
    });
    if (isOpinion) {
      _loadUnconfirmedCount();
    } else {
      ref.read(unconfirmedOpinionNotifierProvider.notifier).reset();
    }
  }

  @override
  void dispose() {
    _endpointCheckTimer?.cancel();
    super.dispose();
  }

  void _checkEndpointInitialization() {
    // Check if endpoints are already initialized
    if (ApiEndpoint().isInitialized) {
      _onEndpointsReady();
      return;
    }

    // Set up a timer to periodically check for endpoint initialization
    _endpointCheckTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (ApiEndpoint().isInitialized && !_endpointsInitialized) {
        _onEndpointsReady();
        timer.cancel();
      }
    });

    // Also listen for background service completion
    BackgroundService().onInitializationComplete(() {
      if (!_endpointsInitialized && mounted) {
        _onEndpointsReady();
      }
    });
  }

  void _onEndpointsReady() {
    if (mounted && !_endpointsInitialized) {
      setState(() {
        _endpointsInitialized = true;
      });
      _endpointCheckTimer?.cancel();
      if (_isStaffOpinionMode) {
        _loadUnconfirmedCount();
      }
    }
  }

  Future<void> _loadUnconfirmedCount() async {
    try {
      // If endpoints map has dedicated endpoint, prefer it; else fallback to fixed path
      final Uri uri = ApiEndpoint.apiMap['UNCONFIRMED_OPINIONS_COUNT'] ??
          Uri.parse('https://bcsv-api.crane1129.workers.dev/api/unconfirmedOpinions');

      final response = await http
          .get(uri)
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        int count;
        if (body is Map && body.containsKey('count')) {
          count = (body['count'] as num).toInt();
        } else if (body is Map && body.containsKey('result')) {
          final list = body['result'];
          count = (list is List) ? list.length : 0;
        } else if (body is List) {
          count = body.length;
        } else {
          count = 0;
        }
        if (mounted) {
          setState(() {
            _unconfirmedCount = count;
          });
          ref.read(unconfirmedOpinionNotifierProvider.notifier).setCount(count);
        }
      }
    } catch (_) {
      // Silent fail; keep last known count
    }
  }

  Widget _buildBadge(int value) {
    return ClipOval(
      child: Container(
        color: Colors.red,
        width: 18,
        height: 18,
        child: Center(
          child: Text(
            value.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //backgroundColor: Theme.of(context).colorScheme.onSurface,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(AppLocalizations.of(context)!.missionStatement),
            accountEmail: Text(AppLocalizations.of(context)!.missionVerse,
                style: TextStyle(fontSize: 10)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              backgroundImage: AssetImage('assets/images/app.png'),
            ),
            decoration: BoxDecoration(
                color: kMainAppBarColor,
                image: DecorationImage(
                  image: AssetImage('assets/images/mountain1.jpg'),
                  fit: BoxFit.cover,
                )),
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 30.0),
            leading:
            Icon(Icons.key, color: kActiveIconColor(context), size: 20),
            title: Text(AppLocalizations.of(context)!.key_verse,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => KeyVerseScreen()));
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            //leading: Icon(FontAwesomeIcons.church, color: kInactiveIconColor),
            title: Text(AppLocalizations.of(context)!.sundaySermons,
                style: kDrawerTitleMenuTextStyle(context)),
          ),
          ListWebViewMenu(
              myIcon: Icons.voice_chat_outlined,
              menuName: AppLocalizations.of(context)!.sermonArchives,
              url: ApiEndpoint.apiMap['SERMON_YOUTUBE'],
              trailing: emptyString),
          ListWebViewMenu(
              myIcon: FontAwesomeIcons.youtube,
              menuName: AppLocalizations.of(context)!.youtubeLive,
              url: ApiEndpoint.apiMap['YOUTUBE_LIVE'],
              trailing: emptyString),
          const Divider(color: Colors.grey),
          ListTile(
            //leading: Icon(Icons.speaker_notes, color: kInactiveIconColor),
            title: Text(AppLocalizations.of(context)!.notification,
                style: kDrawerTitleMenuTextStyle(context)),
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 30.0),
            leading: Icon(Icons.accessibility_new_outlined,
                color: kActiveIconColor(context), size: 20),
            title: Text(AppLocalizations.of(context)!.servingTurn,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ServingTurnPage()));
            },
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 30.0),
            leading: Icon(Icons.notifications_none,
                color: kActiveIconColor(context), size: 20),
            title: Text(AppLocalizations.of(context)!.announcement,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AnnouncementPage()));
            },
          ),
          // ListTile(
          //   //contentPadding: EdgeInsets.only(left: 30.0),
          //   leading:
          //       Icon(Icons.mail_outline, color: kActiveIconColor(context), size: 20),
          //   title: Text(AppLocalizations.of(context)!.newMessage,
          //       style: kDrawerMenuTextStyle(context)),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (_) => MessageListScreen())).then(
          //       (onValue) {
          //         updateMessageCounter();
          //       },
          //     );
          //   },
          //   trailing: displayMsgCounter(),
          // ),
          const Divider(color: Colors.grey),
          ListTile(
            //leading: Icon(FontAwesomeIcons.bible, color: kInactiveIconColor),
            title: Text(AppLocalizations.of(context)!.bibleText,
                style: kDrawerTitleMenuTextStyle(context)),
          ),
          ListTile(
            //contentPadding: EdgeInsets.only(left: 30.0),
            leading: Icon(Icons.book_outlined,
                color: kActiveIconColor(context), size: 20),
            title: Text(AppLocalizations.of(context)!.sermonBibleText,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SundayBibleTextScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.auto_stories, color: kActiveIconColor(context)),
            title: Text(AppLocalizations.of(context)!.dailyBible,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => DailyBibleTextScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.search, color: kActiveIconColor(context)),
            title: Text(AppLocalizations.of(context)!.bible_search,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => BibleSearchScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.manage_search, color: kActiveIconColor(context)),
            title: Text(AppLocalizations.of(context)!.keywordSearch,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => BibleKeywordSearchScreen()));
            },
          ),
          // ListWebViewMenu(
          //     myIcon: FontAwesomeIcons.magnifyingGlass,
          //     menuName: AppLocalizations.of(context)!.bible_search,
          //     url: ApiEndpoint.apiMap['BIBLE_SEARCH'],
          //     trailing: emptyString),
          const Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.volunteer_activism,
                color: kActiveIconColor(context)),
            title: Text(AppLocalizations.of(context)!.offering,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          OfferingScreen()));
            },
          ),
          // ListWebViewMenu(
          //     myIcon: Icons.add_shopping_cart_outlined,
          //     menuName: "Reimbursement",
          //     url: ApiEndpoint.apiMap['REIMBURSEMENT'],
          //     trailing: emptyString),
          ListTile(
            leading: Icon(Icons.add_shopping_cart_rounded,
                color: ApiEndpoint.apiMap['REIMBURSEMENT'] != null 
                    ? kActiveIconColor(context) 
                    : Colors.grey),
            title: Text(AppLocalizations.of(context)!.reimbursement,
                style: ApiEndpoint.apiMap['REIMBURSEMENT'] != null
                    ? kDrawerMenuTextStyle(context)
                    : kDrawerMenuTextStyle(context).copyWith(color: Colors.grey)),
            onTap: ApiEndpoint.apiMap['REIMBURSEMENT'] != null ? () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ReimbursementScreen(
                          url: ApiEndpoint.apiMap['REIMBURSEMENT']!)));
            } : null,
          ),
          ListTile(
            leading: Icon(Icons.emoji_people, color: kActiveIconColor(context)),
            title: Text(AppLocalizations.of(context)!.opinion,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SubmitOpinionScreen()));
            },
          ),
          // ListWebViewMenu(
          //     myIcon: Icons.share,
          //     menuName: AppLocalizations.of(context)!.opinion,
          //     url: ApiEndpoint.apiMap['FEEDBACK'],
          //     trailing: emptyString),
          const Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.info_outline, color: kActiveIconColor(context)),
            title: Text(AppLocalizations.of(context)!.about,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AboutScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: kActiveIconColor(context)),
            title: Text(AppLocalizations.of(context)!.settings,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SettingsPage()))
                  .then((_) => _initStaffMode());
            },
          ),
          if (_isStaffOpinionMode || _isStaffMessageMode) ...[
            const Divider(),
            ListTile(
              title: Text(AppLocalizations.of(context)!.staff_only_mode,
                  style: kDrawerMenuTextStyle(context)),
            ),
          ],
          if (_isStaffOpinionMode) ...[
            ListTile(
              leading: Icon(Icons.admin_panel_settings,
                  color: kActiveIconColorAdmin(context)),
              title: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.unconfirmed_opinion,
                    style: kDrawerMenuTextStyle(context),
                  ),
                  const SizedBox(width: 6),
                  if (_unconfirmedCount > 0)
                    _buildBadge(_unconfirmedCount),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UnconfirmedOpinionsScreen(),
                  ),
                ).then((_) => _loadUnconfirmedCount());
              },
            ),
          ],
          if (_isStaffMessageMode) ...[
            ListTile(
              leading: Icon(Icons.cloud_upload_rounded,
                  color: kActiveIconColorAdmin(context)),
              title: Text(
                AppLocalizations.of(context)!.uploadMessage,
                style: kDrawerMenuTextStyle(context),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MessageUploadScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.edit_note_rounded,
                  color: kActiveIconColorAdmin(context)),
              title: Text(
                AppLocalizations.of(context)!.manageMessages,
                style: kDrawerMenuTextStyle(context),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MessageManagementScreen(),
                  ),
                );
              },
            ),
          ],
          const Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: kActiveIconColor(context)),
            title: Text(AppLocalizations.of(context)!.exit,
                style: kDrawerMenuTextStyle(context)),
            onTap: () {
              exit(0);
            },
          ),
        ],
        ),
      ),
    );
  }

}

class ListWebViewMenu extends StatelessWidget {
  final dynamic myIcon;
  final String menuName;
  final Uri? url;
  final Widget trailing;

  const ListWebViewMenu(
      {super.key, required this.myIcon,
      required this.menuName,
      required this.url,
      required this.trailing});

  @override
  Widget build(BuildContext context) {
    final bool isUrlAvailable = url != null;
    
    return ListTile(
        //contentPadding: EdgeInsets.only(left: 20.0),
        leading: myIcon is FaIconData
            ? FaIcon(myIcon,
                color: isUrlAvailable ? kActiveIconColor(context) : Colors.grey,
                size: 20)
            : Icon(myIcon,
                color: isUrlAvailable ? kActiveIconColor(context) : Colors.grey,
                size: 20),
        title: Text(menuName, 
            style: isUrlAvailable 
                ? kDrawerMenuTextStyle(context)
                : kDrawerMenuTextStyle(context).copyWith(color: Colors.grey)),
        onTap: isUrlAvailable ? () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                // return WebviewScreen(url: url, title1: menuName, title2: '');
                return WebViewApp(url: url!, title1: menuName, title2: '');
              },
            ),
          );
        } : null,
        trailing: trailing);
  }
}
