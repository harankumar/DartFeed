// Copyright (c) 2015, Haran Kumar. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of DartFeed;

XmlElement _get(String name, XmlElement element) {
  try {
    return element.findElements(name).first;
  } catch (Exception) {
    return null;
  }
}

String _getValue(String name, XmlElement element, [String value = ""]) {
  try {
    var elements = element.findElements(name);
    assert(elements.length == 1);
    return elements.first.text;
  } catch (Exception) {
    return value;
  }
}

final _months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];
final _days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

DateTime _parseDate(String formattedString) {
  if (formattedString == null || formattedString == "") return null;
  int ind = 0;
  List<String> components = formattedString.split(" ");
  try {
    String x = components[0].substring(0, 3);
    if (_days.contains(x)) {
      ind = 1;
    }
  } catch (RangeError) {}
  ;

  int day = int.parse(components[ind]);
  ind++;

  int month = _months.indexOf(components[ind]) + 1;
  ind++;

  int year = int.parse(components[ind]);
  ind++;

  String time = components[ind];
  var timeComponents = time.split(":");
  int hour = int.parse(timeComponents[0]);
  int minute = int.parse(timeComponents[1]);
  int second = 0;
  if (timeComponents.length == 3) second = int.parse(timeComponents[2]);
  ind++;

  //TODO: Use Timezones
  String timezone = components[ind];

  return new DateTime(year, month, day, hour, minute, second);
}
