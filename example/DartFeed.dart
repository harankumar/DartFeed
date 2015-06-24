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
  Feed.fromString(new File("feed.xml").readAsStringSync()).then(printFeed);
  for (var feed in webFeeds) {
    Feed.fromUri(Uri.parse(feed)).then(printFeed);
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
