// Copyright (c) 2015, Haran Kumar. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of DartFeed;

class Category {
  String name;
  Uri domain;

  Category.fromXml(XmlElement element) {
    if (element == null) return;
    name = element.text;
    String domainUri = element.getAttribute("domain");
    if (domainUri != null) domain = Uri.parse(domainUri);
  }
}
