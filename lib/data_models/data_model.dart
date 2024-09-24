
class Endpoint {
  final String endpoint;
  final String url;

  Endpoint({required this.endpoint, required this.url});

  factory Endpoint.fromJson(dynamic json) {
    return Endpoint(
      endpoint: json['endpoint'],
      url: json['url'],
    );
  }
}

class Announcement {
  final String date;
  final String announcement;
  final String preacher;
  final String prayer;
  final String tuesday_pray_meeting;
  final String babysitter;
  final String offering;
  final String File_url;

  Announcement({
    required this.date,
    required this.announcement,
    required this.preacher,
    required this.prayer,
    required this.tuesday_pray_meeting,
    required this.babysitter,
    required this.offering,
    required this.File_url,
  });

  factory Announcement.fromJson(dynamic json) {
    return Announcement(
      date: json['date'],
      announcement: json['announcement'],
      preacher: json['preacher'],
      prayer: json['prayer'],
      tuesday_pray_meeting: json['tuesday_pray_meeting'],
      babysitter: json['babysitter'],
      offering: json['offering'],
      File_url: json['File_url'],
    );
  }
}

class BibleText {
  final String date;
  final String title;
  final String category;
  final String bibleChapter;
  final String bibleText;
  final String fileUrl;

  BibleText({
    required this.date,
    required this.title,
    required this.category,
    required this.bibleChapter,
    required this.bibleText,
    required this.fileUrl,
  });

  factory BibleText.fromJson(dynamic json) {
    return BibleText(
      date: json['Date'],
      title: json['Title'],
      category: json['Category'],
      bibleChapter: json['Bible_chapter'],
      bibleText: json['Bible_text'],
      fileUrl: json['File_url'],
    );
  }
}

class ServingTurn {
  final String date;
  final String prayer;
  final String joycorner;
  final String food;
  final String tuesdayPrayMeeting;
  final String babysitter;

  ServingTurn(
      {required this.date,
      required this.prayer,
      required this.joycorner,
      required this.food,
      required this.tuesdayPrayMeeting,
      required this.babysitter});

  factory ServingTurn.fromJson(dynamic json) {
    return ServingTurn(
        date: json['date'],
        prayer: json['prayer'],
        joycorner: json['joycorner'],
        food: json['food'],
        tuesdayPrayMeeting: json['tuesday_pray_meeting'],
        babysitter: json['babysitter']);
  }
}

class SermonReview {
  final String date;
  final String title;
  final String chapter;
  final String review;
  final String application;
  final String in_depth;

  SermonReview(
      {required this.date,
      required this.title,
      required this.chapter,
      required this.review,
      required this.application,
      required this.in_depth});

  factory SermonReview.fromJson(dynamic json) {
    return SermonReview(
        date: json['date'],
        title: json['title'],
        chapter: json['chapter'],
        review: json['review'],
        application: json['application'],
        in_depth: json['in_depth']);
  }
}

class MessageList {
  final String expireDate;
  final String category;
  final String title;
  final String message;
  final String imageLink;
  final String externalLink;
  final int messageID;

  MessageList(
      {required this.expireDate,
      required this.category,
      required this.title,
      required this.message,
      required this.imageLink,
      required this.externalLink,
      required this.messageID});

  factory MessageList.fromJson(dynamic json) {
    return MessageList(
        expireDate: json['ExpireDate'],
        category: json['Category'],
        title: json['Title'],
        message: json['Message'],
        imageLink: json['ImageLink'] ?? "https://tinyurl.com/yc8rdbr4",
        externalLink: json['ExternalLink'] ?? "",
        messageID: json['MessageID'] ?? "");
  }
}
