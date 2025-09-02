class KeyVerse {
  final int year;
  final String title;
  final String book;
  final int chapter;
  final int verseFrom;
  final int verseEnd;
  final String verse;

  KeyVerse({
    required this.year,
    required this.title,
    required this.book,
    required this.chapter,
    required this.verseFrom,
    required this.verseEnd,
    required this.verse,
  });

  /// Create KeyVerse from JSON data
  factory KeyVerse.fromJson(Map<String, dynamic> json) {
    return KeyVerse(
      year: json['year'] ?? 0,
      title: json['title'] ?? '',
      book: json['book'] ?? '',
      chapter: json['chapter'] ?? 0,
      verseFrom: json['verse_from'] ?? 0,
      verseEnd: json['verse_end'] ?? 0,
      verse: json['verse'] ?? '',
    );
  }

  /// Convert KeyVerse to JSON data
  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'title': title,
      'book': book,
      'chapter': chapter,
      'verse_from': verseFrom,
      'verse_end': verseEnd,
      'verse': verse,
    };
  }

  /// Get formatted chapter-verse range
  String get chapterVerseRange {
    if (verseFrom == verseEnd) {
      return '$book $chapter:$verseFrom';
    } else {
      return '$book $chapter:$verseFrom-$verseEnd';
    }
  }

  /// Get short reference (e.g., "딤전 6:11-12")
  String get shortReference {
    final shortBook = _getShortBookName(book);
    if (verseFrom == verseEnd) {
      return '$shortBook $chapter:$verseFrom';
    } else {
      return '$shortBook $chapter:$verseFrom-$verseEnd';
    }
  }

  /// Get short book names for display
  String _getShortBookName(String fullBookName) {
    const shortNames = {
      '창세기': '창',
      '출애굽기': '출',
      '레위기': '레',
      '민수기': '민',
      '신명기': '신',
      '여호수아': '수',
      '사사기': '삿',
      '룻기': '룻',
      '사무엘상': '삼상',
      '사무엘하': '삼하',
      '열왕기상': '왕상',
      '열왕기하': '왕하',
      '역대상': '대상',
      '역대하': '대하',
      '에스라': '스',
      '느헤미야': '느',
      '에스더': '에',
      '욥기': '욥',
      '시편': '시',
      '잠언': '잠',
      '전도서': '전',
      '아가': '아',
      '이사야': '사',
      '예레미야': '렘',
      '예레미야 애가': '애',
      '에스겔': '겔',
      '다니엘': '단',
      '호세아': '호',
      '요엘': '욜',
      '아모스': '암',
      '오바댜': '옵',
      '요나': '욘',
      '미가': '미',
      '나훔': '나',
      '하박국': '합',
      '스바냐': '습',
      '학개': '학',
      '스가랴': '슥',
      '말라기': '말',
      '마태복음': '마',
      '마가복음': '막',
      '누가복음': '눅',
      '요한복음': '요',
      '사도행전': '행',
      '로마서': '롬',
      '고린도전서': '고전',
      '고린도후서': '고후',
      '갈라디아서': '갈',
      '에베소서': '엡',
      '빌립보서': '빌',
      '골로새서': '골',
      '데살로니가전서': '살전',
      '데살로니가후서': '살후',
      '디모데전서': '딤전',
      '디모데후서': '딤후',
      '디도서': '딛',
      '빌레몬서': '몬',
      '히브리서': '히',
      '야고보서': '약',
      '베드로전서': '벧전',
      '베드로후서': '벧후',
      '요한일서': '요일',
      '요한이서': '요이',
      '요한삼서': '요삼',
      '유다서': '유',
      '요한계시록': '계',
    };

    return shortNames[fullBookName] ?? fullBookName;
  }

  @override
  String toString() {
    return 'KeyVerse(year: $year, title: $title, book: $book, chapter: $chapter, verseFrom: $verseFrom, verseEnd: $verseEnd, verse: $verse)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is KeyVerse &&
        other.year == year &&
        other.title == title &&
        other.book == book &&
        other.chapter == chapter &&
        other.verseFrom == verseFrom &&
        other.verseEnd == verseEnd &&
        other.verse == verse;
  }

  @override
  int get hashCode {
    return year.hashCode ^
        title.hashCode ^
        book.hashCode ^
        chapter.hashCode ^
        verseFrom.hashCode ^
        verseEnd.hashCode ^
        verse.hashCode;
  }
}

class KeyVerseResponse {
  final List<KeyVerse> results;

  KeyVerseResponse({required this.results});

  /// Create KeyVerseResponse from JSON data
  factory KeyVerseResponse.fromJson(Map<String, dynamic> json) {
    final resultsList = json['results'] as List?;
    final results = resultsList?.map((item) => KeyVerse.fromJson(item)).toList() ?? [];
    
    return KeyVerseResponse(results: results);
  }

  /// Convert KeyVerseResponse to JSON data
  Map<String, dynamic> toJson() {
    return {
      'results': results.map((item) => item.toJson()).toList(),
    };
  }

  /// Get the first (and usually only) keyverse
  KeyVerse? get firstKeyVerse => results.isNotEmpty ? results.first : null;

  @override
  String toString() {
    return 'KeyVerseResponse(results: $results)';
  }
}
