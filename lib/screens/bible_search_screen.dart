import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bcsv_flutter_project/components/appbar_header_text.dart';
import 'package:bcsv_flutter_project/utilities/constants.dart';
import 'package:overlay_support/overlay_support.dart';

class BibleSearchScreen extends StatefulWidget {
  @override
  _BibleSearchScreenState createState() => _BibleSearchScreenState();
}

class _BibleSearchScreenState extends State<BibleSearchScreen> {
  bool isLoading = false;
  // Dropdown values
  String selectedTestament = 'new';
  String? selectedBook;
  Set<int> selectedIndexes = {};

  // Text input controllers
  final startChapCtrl = TextEditingController();
  final startVerseCtrl = TextEditingController();
  final endChapCtrl = TextEditingController();
  final endVerseCtrl = TextEditingController();
  double _fontSize = 16.0;
  final oldTestamentBooks = [
    "창세기",
    "출애굽기",
    "레위기",
    "민수기",
    "신명기",
    "여호수아",
    "사사기",
    "룻기",
    "사무엘상",
    "사무엘하",
    "열왕기상",
    "열왕기하",
    "역대상",
    "역대하",
    "에스라",
    "느헤미야",
    "에스더",
    "욥기",
    "시편",
    "잠언",
    "전도서",
    "아가",
    "이사야",
    "예레미야",
    "예레미야 애가",
    "에스겔",
    "다니엘",
    "호세아",
    "요엘",
    "아모스",
    "오바댜",
    "요나",
    "미가",
    "나훔",
    "하박국",
    "스바냐",
    "학개",
    "스가랴",
    "말라기"
  ];

  final newTestamentBooks = [
    "마태복음",
    "마가복음",
    "누가복음",
    "요한복음",
    "사도행전",
    "로마서",
    "고린도전서",
    "고린도후서",
    "갈라디아서",
    "에베소서",
    "빌립보서",
    "골로새서",
    "데살로니가전서",
    "데살로니가후서",
    "디모데전서",
    "디모데후서",
    "디도서",
    "빌레몬서",
    "히브리서",
    "야고보서",
    "베드로전서",
    "베드로후서",
    "요한일서",
    "요한이서",
    "요한삼서",
    "유다서",
    "요한계시록"
  ];

  // Verse results
  List<Map<String, dynamic>> results = [];

  @override
  Widget build(BuildContext context) {
    final books =
        selectedTestament == 'new' ? newTestamentBooks : oldTestamentBooks;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent.withAlpha(50),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: kNavBackButtonColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AppBarHeaderText(
          text1: AppLocalizations.of(context)!.bible_search,
          text2: '',
        ),
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
      body: Stack(
        children: [
          // 🔹 Main content (always visible)
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Testament toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: Text(
                          AppLocalizations.of(context)!.bible_new_testament),
                      selected: selectedTestament == 'new',
                      onSelected: (_) {
                        setState(() {
                          selectedTestament = 'new';
                          selectedBook = newTestamentBooks.first;
                          clearInputs();
                        });
                      },
                    ),
                    SizedBox(width: 8),
                    ChoiceChip(
                      label: Text(
                          AppLocalizations.of(context)!.bible_old_testament),
                      selected: selectedTestament == 'old',
                      onSelected: (_) {
                        setState(() {
                          selectedTestament = 'old';
                          selectedBook = oldTestamentBooks.first;
                          clearInputs();
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Book dropdown
                DropdownButton<String>(
                  value: selectedBook,
                  hint: Text("Select Book", style: kBodyTextStyle(context)),
                  style: kBodyTextStyle(context),
                  isExpanded: true,
                  items: books
                      .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                      .toList(),
                  onChanged: (val) => setState(() {
                    selectedBook = val;
                    clearInputs();
                  }),
                ),

                SizedBox(height: 16),

                // Input fields
                Row(children: [
                  Expanded(
                      child: _numberField(
                          AppLocalizations.of(context)!.start_chapter,
                          startChapCtrl)),
                  SizedBox(width: 8),
                  Expanded(
                      child: _numberField(
                          AppLocalizations.of(context)!.start_verse,
                          startVerseCtrl)),
                ]),
                Row(children: [
                  SizedBox(height: 8),
                ]),
                Row(children: [
                  Expanded(
                      child: _numberField(
                          AppLocalizations.of(context)!.end_chapter,
                          endChapCtrl)),
                  SizedBox(width: 8),
                  Expanded(
                      child: _numberField(
                          AppLocalizations.of(context)!.end_verse,
                          endVerseCtrl)),
                ]),

                SizedBox(height: 16),

                Center(
                  child: ElevatedButton(
                    onPressed: isLoading ? null : fetchVerses,
                    child: Text(AppLocalizations.of(context)!.search),
                  ),
                ),

                SizedBox(height: 24),

                // Search Results
                if (results.isEmpty)
                  Center(
                    child: Text(
                      'No results',
                      style: kBodyTextStyle(context, fontSize: _fontSize),
                    ),
                  )
                else
                  ...results.asMap().entries.map((entry) {
                    final i = entry.key;
                    final verse = entry.value;
                    final isSelected = selectedIndexes.contains(i);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedIndexes.remove(i);
                          } else {
                            selectedIndexes.add(i);
                          }
                        });
                      },
                      onLongPress: () {
                        setState(() {
                          selectedIndexes.add(i);
                        });
                      },
                      child: Container(
                        color: isSelected
                            ? Colors.blue.withAlpha(50)
                            : Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${verse['chapterVerse']} ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: _fontSize, // 🔹 make dynamic
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                verse['text'],
                                style: TextStyle(
                                  fontSize: _fontSize, // 🔹 make dynamic
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),

                if (selectedIndexes.isNotEmpty) ...[
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: ElevatedButton.icon(
                          onPressed: copySelectedVerses,
                          icon: Icon(Icons.copy),
                          label: Text(
                            'Copy Selected (${selectedIndexes.length})',
                            style: TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            setState(() {
                              selectedIndexes.clear();
                            });
                          },
                          icon: Icon(Icons.clear),
                          label: Text(
                            'Clear Selection',
                            style: TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.onSurface,
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (results.isNotEmpty) ...[
                  SizedBox(height: 8),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: copyAllResults,
                      icon: Icon(Icons.copy),
                      label: Text('Copy All'),
                    ),
                  ),
                ],
                SizedBox(height: 24),
              ],
            ),
          ),

          // 🔺 Loading overlay
          if (isLoading)
            IgnorePointer(
              ignoring: false,
              child: Container(
                color: Colors.black.withValues(alpha:0.3),
                child: Center(
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
                ),
              ),
            ),
        ],
      ),
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

  void copyAllResults() {
    if (results.isEmpty) return;

    final buffer = StringBuffer();
    for (var verse in results) {
      buffer.writeln(
          '${verse['book']} ${verse['chapterVerse']} — ${verse['text']}');
    }

    Clipboard.setData(ClipboardData(text: buffer.toString())).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('📋 Copied ${results.length} verses')),
      );
    });

    //showMessage("Bible Text");
  }

  void copySelectedVerses() {
    final buffer = StringBuffer();
    final sortedIndexes = selectedIndexes.toList()..sort();
    final selected_verse_count = selectedIndexes.length;
    for (var i in sortedIndexes) {
      final verse = results[i];
      buffer.writeln(
          '${verse['book']} ${verse['chapterVerse']} — ${verse['text']}');
    }

    Clipboard.setData(ClipboardData(text: buffer.toString())).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('📋 Copied ${selected_verse_count} verse(s)')),
      );
    });

    setState(() => selectedIndexes.clear());
  }

  Widget _numberField(String label, TextEditingController controller) {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: kBodyTextStyle(context),
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurface, fontSize: 12),
      ),
    );
  }

  void clearInputs() {
    startChapCtrl.clear();
    startVerseCtrl.clear();
    endChapCtrl.clear();
    endVerseCtrl.clear();
    results.clear();
  }

  Future<void> fetchVerses() async {
    FocusScope.of(context).unfocus(); // ✅ Hide the keyboard
    final book = selectedBook;
    final startChap = startChapCtrl.text;
    final startVerse = startVerseCtrl.text;
    final endChap = endChapCtrl.text;
    final endVerse = endVerseCtrl.text;

    if (book == null || startChap.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('📘 책 이름과 시작 장을 입력해주세요.')),
      );
      return;
    }

    if (startVerse.isEmpty && (endChap.isNotEmpty || endVerse.isNotEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('시작 절이 없으면 범위 입력이 올바르지 않습니다.')),
      );
      return;
    }

    // 🔄 Start loading
    setState(() {
      isLoading = true;
      results.clear(); // Optionally clear old results
    });

    final query = {
      'book': book,
      'startChap': startChap,
      if (startVerse.isNotEmpty) 'startVerse': startVerse,
      if (endChap.isNotEmpty) 'endChap': endChap,
      if (endVerse.isNotEmpty) 'endVerse': endVerse,
    };

    final uri =
        Uri.https('www.bridgeway.online', '/_functions/bibleSearch', query);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          results = List<Map<String, dynamic>>.from(json['result']);
        });
      } else {
        print("❌ Failed: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('검색 중 오류가 발생했습니다.')),
        );
      }
    } catch (e) {
      print("❌ Exception: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('네트워크 오류 또는 서버 문제입니다.')),
      );
    } finally {
      // ✅ Stop loading in all cases
      setState(() {
        isLoading = false;
      });
    }
  }
}
