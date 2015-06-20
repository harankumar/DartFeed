// Copyright (c) 2015, Haran Kumar. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library DartFeed.test;

import 'dart:io';

import 'package:test/test.dart';
import '../lib/dart_feed.dart';

String completeFeed = "feeds/valid/completefeed.xml";

void main() {
  testConstructors();
  testCompleteFeed();
  testExceptionHandling();
}

List<String> webFeeds = [
  "http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml",
  "http://www.rssboard.org/files/sample-rss-2.xml",
  "http://www.reddit.com/r/news.rss",
  "http://www.reddit.com/search.rss?q=my+query",
  "https://news.google.com/news?pz=1&cf=all&ned=us&hl=en&q=dart+language&output=rss",
  "https://kat.cr/tv/?rss=1"
];

List<String> localFeeds = [
  "feeds/valid/validfeed.xml",
  "feeds/valid/completefeed.xml",
  "feeds/valid/notitle.xml"
];

String stringFeed = """<?xml version="1.0" encoding="utf-8"?>
  <rss version="2.0">
      <channel>
          <title>My Cool Blog</title>
          <link>http://www.yourwebsite.com/</link>
          <description>My latest cool articles</description>
          <item>
              <title>Article 3</title>
              <link>example.com/3</link>
              <guid>example.com/3</guid>
              <pubDate>Wed, 27 Nov 2013 13:20:00 GMT</pubDate>
              <description>My newest article.</description>
          </item>
          <item>
              <title>Article 2</title>
              <link>example.com/2</link>
              <guid>example.com/2</guid>
              <pubDate>Tue, 26 Nov 2013 12:15:12 GMT</pubDate>
              <description>My second article.</description>
          </item>
          <item>
              <title>Article 1</title>
              <link>example.com/1</link>
              <guid>example.com/1</guid>
              <pubDate>Mon, 25 Nov 2013 15:10:45 GMT</pubDate>
              <description>My first article.</description>
          </item>
      </channel>
  </rss>
""";

void testConstructors() {
  bool error = false;

  void onError(e) {
    error = true;
  }

  void onComplete(Feed feed) {
    expect(error, isFalse);
    error = false;
  }

  void testFeed(Feed feed) {
    expect(feed, isNotNull, reason: "FeedParser.onLoad produces a Feed Object");
  }

  void testRequiredItemElements(Item item) {
    expect(item, isNotNull);
    expect(item.title, isNotNull);
    expect(item.link, isNotNull);
    expect(item.description, isNotNull);
  }

  void testRequiredFeedElements(Feed feed) {
    expect(feed.version, equals("2.0"),
        reason: "Feed must contain a version, and the only supported version is 2.0.");
    expect(feed.title, isNotNull, reason: "Feed must contain a title.");
    expect(feed.link, isNotNull,
        reason: "Feed must contain a link to the site.");
    expect(feed.description, isNotNull,
        reason: "Feed must contain a description.");
    for (var item in feed.items) testRequiredItemElements(item);
  }

  test("FeedParser.fromUri Constructor", () async {
    for (String feed in webFeeds) {
      Uri uri = Uri.parse(feed);
      FeedParser feedParser = new FeedParser()
        ..stream.listen(testFeed)
        ..stream.listen(testRequiredFeedElements)
        ..stream.listen(onComplete, onError: onError);
      await feedParser.fromUri(uri);
      expect(feedParser, isNotNull,
          reason: "FeedParser.fromUri constructor produces a valid object.");
    }
  });

  test("FeedParser.fromFile Constructor", () async {
    for (String feed in localFeeds) {
      File file = new File(feed);
      FeedParser feedParser = new FeedParser()
        ..stream.listen(testFeed)
        ..stream.listen(testRequiredFeedElements)
        ..stream.listen(onComplete, onError: onError);
      await feedParser.fromFile(file);
      expect(feedParser, isNotNull,
          reason: "FeedParser.fromFile constructor produces a valid object.");
    }
  });

  test("FeedParser.fromString Constructor", () async {
    FeedParser feedParser = new FeedParser()
      ..stream.listen(testFeed)
      ..stream.listen(testRequiredFeedElements)
      ..stream.listen(onComplete, onError: onError);
    await feedParser.fromString(stringFeed);
    expect(feedParser, isNotNull,
        reason: "FeedParser.fromString constructor produces a valid object.");
  });
}

void testCompleteFeed() {
  bool error = false;

  void onError(e) {
    error = true;
  }

  void onComplete(Feed feed) {
    expect(error, isFalse);
    error = false;
  }

  void testFeed(Feed feed) {
    expect(feed, isNotNull);
    expect(feed.version, equals("2.0"));
    expect(feed.title, equals("My RSS Feed"));
    expect(feed.description, equals(
        "This RSS feed includes all the required and optional elements of the RSS 2.0 Specification. You may find it useful for testing purposes."));
    expect(
        feed.managingEditor, equals("zaphod@example.com (Zaphod Beeblebrox)"));
    expect(feed.webMaster, equals("hans@example.com (Hans Solo)"));
    expect(feed.pubDate, equals(new DateTime(2002, 9, 7, 0, 0, 1)));
    expect(feed.lastBuildDate, equals(new DateTime(2002, 9, 7, 9, 42, 31)));
    expect(feed.categories.length, equals(2));
    expect(feed.categories[0].domain,
        equals(Uri.parse("http://www.example.com/examples")));
    expect(feed.categories[0].name, equals("Examples"));
    expect(feed.categories[1].name, equals("Cool Examples"));
    expect(feed.generator, equals("Galactic CMS 1.7"));
    expect(feed.docs,
        equals(Uri.parse("http://www.rssboard.org/rss-specification")));
    expect(feed.cloud.domain, equals(Uri.parse("sys.example.com")));
    expect(feed.cloud.port, equals(79));
    expect(feed.cloud.path, equals("/RSS"));
    expect(feed.cloud.registerProcedure, equals("example.rssNotify"));
    expect(feed.ttl, 75);
    expect(feed.image.url, equals(Uri.parse("http://rss.example.com/img.png")));
    expect(feed.image.title, equals("My RSS Feed"));
    expect(
        feed.image.link, equals(Uri.parse("http://www.example.com/img.gif")));
    expect(feed.image.width, equals(144));
    expect(feed.image.height, equals(400));
    expect(feed.textInput.title, equals("Submit"));
    expect(feed.textInput.description, equals("Rarely used RSS Element"));
    expect(feed.textInput.name, equals("Name"));
    expect(feed.textInput.link,
        equals(Uri.parse("http://www.example.com/clickbait.php")));
    expect(feed.skipHours.hours, equals([0, 1, 4, 22]));
    expect(feed.skipDays.days, equals([0]));
    expect(feed.items.length, equals(3));
    expect(feed.items[0].title, equals("My Story"));
    expect(feed.items[0].link,
        equals(Uri.parse("http://www.example.com/article.html")));
    expect(feed.items[0].description, equals("A cool story. Click the link!"));
    expect(feed.items[0].guid.isPermaLink, isTrue);
    expect(feed.items[0].guid.guid, equals("http://www.example.com/item12234"));
    expect(feed.items[1].title, equals("Another cool Story"));
    expect(feed.items[1].link,
        equals(Uri.parse("http://www.example.com/cool.html")));
    expect(feed.items[1].description, equals("Another cool story."));
    expect(feed.items[1].author, equals("jlp@example.com (Jean-Luc Picard)"));
    expect(feed.items[1].categories.length, equals(2));
    expect(feed.items[1].categories[0].name, equals("Cool Stories"));
    expect(feed.items[1].categories[1].domain,
        equals(Uri.parse("http://www.example.com/cool.html")));
    expect(feed.items[1].categories[1].name, equals("Cool Stuff"));
    expect(feed.items[1].comments,
        equals(Uri.parse("http://www.example.com/comments.php")));
    expect(feed.items[1].enclosure.url,
        equals(Uri.parse("http://www.example.com/mp3.mp3")));
    expect(feed.items[1].enclosure.length, equals(1222121212));
    expect(feed.items[1].enclosure.type, equals("audio/mpeg"));
    expect(feed.items[1].guid.isPermaLink, isFalse);
    expect(feed.items[1].guid.guid, equals("Th!\$ C@n Be @NYTH1NG!"));
    expect(feed.items[1].pubDate, equals(new DateTime(2012, 8, 7, 0, 23, 1)));
    expect(feed.items[1].source.url,
        equals(Uri.parse("http://www.example.com/other.xml")));
    expect(feed.items[1].source.name, equals("Another Cool Feed"));
    expect(feed.items[2].title, equals("Title"));
    expect(feed.items[2].link, equals(Uri.parse("http://www.link.link")));
    expect(feed.items[2].description, equals("Description"));
    expect(feed.items[2].guid.isPermaLink, isFalse);
    expect(feed.items[2].guid.guid, equals("Guid"));
  }

  test("Test of Complete Feed", () async {
    File file = new File(completeFeed);
    FeedParser feedParser = new FeedParser()
      ..stream.listen((Feed feed) {
        testFeed(feed);
      })
      ..stream.listen(onComplete, onError: onError);
    await feedParser.fromFile(file);
  });
}

List<String> badFeeds = [
  "feeds/invalid/oldrss.xml",
  "feeds/invalid/missingversion.xml",
  "feeds/invalid/missingtitle.xml",
  "feeds/invalid/missingdescription.xml",
  "feeds/invalid/badimage1.xml",
  "feeds/invalid/badimage2.xml",
  "feeds/invalid/badimage3.xml",
  "feeds/invalid/badimage4.xml",
  "feeds/invalid/badimage5.xml",
  "feeds/invalid/badimage6.xml",
  "feeds/invalid/badimage7.xml",
  "feeds/invalid/badimage8.xml",
  "feeds/invalid/badimage9.xml",
  "feeds/invalid/badimage10.xml",
  "feeds/invalid/baditem.xml"
];

void testExceptionHandling() {
  test("Malformed Feed Sends Exception to Stream", () async {
    bool e;
    var feedParser = new FeedParser()
      ..stream.listen((_) {
        expect(e, isTrue);
        e = false;
      }, onError: (_) {
        e = true;
      });
    for (var feed in badFeeds) {
      var f = new File(feed);
      await feedParser.fromFile(f);
    }
  });
}
