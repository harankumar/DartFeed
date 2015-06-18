// Copyright (c) 2015, Haran Kumar. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of DartFeed;

class SkipHours {
  List<int> hours;

  SkipHours.fromXml(XmlElement element) {
    hours = new List<int>();
    if (element == null) return;
    for (var hour
        in element.findElements("hour")) hours.add(int.parse(hour.text));
  }
}
