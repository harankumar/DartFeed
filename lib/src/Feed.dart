// Copyright (c) 2015, Haran Kumar. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of DartFeed;

class Feed {
  String version;
  String title;
  Uri link;
  String description;
  String language;
  String copyright;
  String managingEditor;
  String webMaster;
  DateTime pubDate;
  DateTime lastBuildDate;
  List<Category> categories;
  String generator;
  Uri docs;
  Cloud cloud;
  int ttl;
  Image image;
  String rating;
  TextInput textInput;
  SkipHours skipHours;
  SkipDays skipDays;
  List<Item> items;

  Feed();

  String toString() {
    return "Feed {version: $version, channel: $title}";
  }
}
