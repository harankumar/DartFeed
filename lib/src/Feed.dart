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

  static Future<Feed> fromUri(Uri uri) async {
    return fromString(await http.read(uri));
  }

  static Future<Feed> fromString(String rssString) {
    var xmlDocument = parse(rssString);
    return fromXml(xmlDocument);
  }

  static Future<Feed> fromXml(XmlDocument document) {
    var feed = new Feed();
    var rss = document.findElements("rss").first;
    feed.version = rss.getAttribute("version");
    if (feed.version == null || feed.version == "") {
      throw new Exception(
          "Received a feed that does not specify its version or is not formatted properly");
      feed.version = "No Version";
    } else if (!feed.version.contains("2.0")) throw new Exception(
        "Received an RSS ${feed.version} feed. Versions other than 2.0 are not yet supported.");
    XmlElement channel = rss.findElements("channel").first;
    var title = channel.findElements("title");
    if (title == null || title.length == 0) {
      throw new Exception(
          "Received a feed without a title or valid title element.");
      feed.title = "No Title";
    } else feed.title = title.first.text;
    feed.link = Uri.parse(_escape(channel.findElements("link").first.text));
    var description = channel.findElements("description");
    if (description == null || description.length == 0) {
      throw new Exception(
          "Received a feed without a description or valid description element.");
      feed.description = "No Description";
    } else feed.description = description.first.text;
    feed.language = _getValue("language", channel);
    feed.copyright = _getValue("copyright", channel);
    feed.managingEditor = _getValue("managingEditor", channel);
    feed.webMaster = _getValue("webMaster", channel);
    feed.pubDate = _parseDate(_getValue("pubDate", channel));
    feed.lastBuildDate = _parseDate(_getValue("lastBuildDate", channel));
    feed.categories = new List<Category>();
    for (var category in channel.findElements("category")) feed.categories
        .add(new Category.fromXml(category));
    feed.generator = _getValue("generator", channel);
    feed.docs = Uri.parse(_escape(_getValue("docs", channel)));
    feed.cloud = new Cloud.fromXml(_get("cloud", channel));
    feed.ttl = int.parse("0" + _getValue("ttl", channel));
    feed.image = new Image.fromXml(_get("image", channel));
    feed.rating = _getValue("rating", channel);
    feed.textInput = new TextInput.fromXml(_get("textInput", channel));
    feed.skipHours = new SkipHours.fromXml(_get("skipHours", channel));
    feed.skipDays = new SkipDays.fromXml(_get("skipDays", channel));
    feed.items = new List<Item>();
    for (var item in channel.findAllElements("item")) feed.items
        .add(new Item.fromXml(item));
    return new Future((){return feed;});
  }

  String toString() {
    return "Feed {version: $version, channel: $title}";
  }
}
