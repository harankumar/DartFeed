// Copyright (c) 2015, Haran Kumar. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library DartFeed.example;

import 'dart:io';

import 'package:http/http.dart';
import 'package:dart_feed/dart_feed.dart';

var webFeeds = [
  "http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml",
  "http://www.rssboard.org/files/sample-rss-2.xml",
  "http://www.reddit.com/r/news.rss"
];

main() {
  FeedParser parser = new FeedParser();
  parser.stream.listen(printFeed);
  parser.fromFile(new File("feed.xml"));
  for (var feed in webFeeds) {
    parser.fromUri(Uri.parse(feed));
  }
}

void printFeed(Feed feed) {
  print(feed.title);
  for (var item in feed.items) {
    stdout.write("\t ${item.title}");
    if (item.title == "") print(item.description);
    else print("");
  }
}
