// Copyright (c) 2015, Haran Kumar. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of DartFeed;

class SkipDays {
  List<int> days;

  SkipDays.fromXml(XmlElement element) {
    var weekDays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];
    days = new List<int>();
    if (element == null) return;
    for (var day
        in element.findElements("day")) days.add(weekDays.indexOf(day.text));
  }
}
