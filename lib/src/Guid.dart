// Copyright (c) 2015, Haran Kumar. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of DartFeed;

class Guid {
  String guid;
  bool isPermaLink;

  Guid.fromXml(XmlElement element) {
    if (element == null) return;
    guid = element.text;
    if (element.getAttribute("isPermaLink") == null) isPermaLink = false;
    else isPermaLink = !(element.getAttribute("isPermaLink") == "false");
  }
}
