// Copyright (c) 2015, Haran Kumar. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of DartFeed;

class TextInput {
  String title;
  String description;
  String name;
  Uri link;

  TextInput.fromXml(XmlElement element) {
    if (element == null) return;
    title = element.findElements("title").first.text;
    description = element.findElements("description").first.text;
    name = element.findElements("name").first.text;
    link = Uri.parse(element.findElements("link").first.text);
  }
}
