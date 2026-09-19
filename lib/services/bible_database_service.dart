import 'dart:io';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class BibleDatabaseService {
  static final BibleDatabaseService _instance = BibleDatabaseService._internal();
  factory BibleDatabaseService() => _instance;
  BibleDatabaseService._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'bible_ko.db');

    final exists = await databaseExists(path);
    if (!exists) {
      await Directory(p.dirname(path)).create(recursive: true);
      final data = await rootBundle.load('assets/bible_ko.db');
      final bytes = data.buffer.asUint8List();
      await File(path).writeAsBytes(bytes, flush: true);
      log('✅ Bible database copied to $path');
    }

    return await openDatabase(path, readOnly: true);
  }

  Future<List<Map<String, dynamic>>> searchByReference({
    required String book,
    required int startChap,
    String? startVerse,
    String? endChap,
    String? endVerse,
  }) async {
    final db = await database;
    final ec = (endChap != null && endChap.isNotEmpty) ? int.parse(endChap) : startChap;

    String sql = "SELECT book, chapter || ':' || verse AS chapterVerse, text_ko AS text FROM bible_verses WHERE book = ?";
    List<dynamic> params = [book];

    final hasStartVerse = startVerse != null && startVerse.isNotEmpty;
    final hasEndVerse = endVerse != null && endVerse.isNotEmpty;
    final hasEndChap = endChap != null && endChap.isNotEmpty;

    if (hasStartVerse && !hasEndVerse && !hasEndChap) {
      // Single verse: e.g. 마가복음 1:1
      sql += " AND chapter = ? AND verse = ?";
      params.addAll([startChap, int.parse(startVerse!)]);
    } else if (hasStartVerse && hasEndVerse && startChap == ec) {
      // Range within same chapter: e.g. 마가복음 1:1-5
      sql += " AND chapter = ? AND verse >= ? AND verse <= ?";
      params.addAll([startChap, int.parse(startVerse!), int.parse(endVerse!)]);
    } else if (hasStartVerse) {
      // Cross-chapter range: e.g. 마가복음 1:1 - 2:5
      sql += " AND ((chapter = ? AND verse >= ?) OR (chapter > ? AND chapter < ?) OR (chapter = ? AND verse <= ?))";
      params.addAll([startChap, int.parse(startVerse!), startChap, ec, ec, hasEndVerse ? int.parse(endVerse!) : 999]);
    } else {
      // Whole chapter(s): e.g. 마가복음 1 or 마가복음 1-3
      sql += " AND chapter >= ? AND chapter <= ?";
      params.addAll([startChap, ec]);
    }

    sql += " ORDER BY chapter, verse";

    final results = await db.rawQuery(sql, params);
    log('✅ Bible reference search: ${results.length} results');
    return results;
  }

  Future<List<Map<String, dynamic>>> searchByKeyword(String keyword) async {
    final db = await database;
    final results = await db.rawQuery(
      "SELECT book, chapter || ':' || verse AS chapterVerse, text_ko AS text "
      "FROM bible_verses "
      "WHERE text_ko LIKE ? ORDER BY book, chapter, verse",
      ['%$keyword%'],
    );
    log('✅ Bible keyword search for "$keyword": ${results.length} results');
    return results;
  }
}
