// Copyright (c) 2015, Haran Kumar. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of DartFeed;

class Source {
  Uri url;
  String name;

  Source.fromXml(XmlElement element) {
    if (element == null) return;
    url = Uri.parse(element.getAttribute("url"));
    name = element.text;
  }
}
