// Copyright (c) 2015, Haran Kumar. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of DartFeed;

class Enclosure {
  Uri url;
  int length;
  String type;

  Enclosure.fromXml(XmlElement element) {
    if (element == null) return;
    url = Uri.parse(_escape(element.getAttribute("url")));
    length = int.parse(element.getAttribute("length"));
    type = element.getAttribute("type");
  }
}
