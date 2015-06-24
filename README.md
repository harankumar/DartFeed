# DartFeed
[![Pub Package](https://img.shields.io/pub/v/xml.svg)](https://pub.dartlang.org/packages/xml)
[![Build Status](https://travis-ci.org/harankumar/DartFeed.svg?branch=master)](https://travis-ci.org/harankumar/DartFeed)

Simple RSS 2.0 feed reader library.

## Example Usage

```dart
Feed.fromUri(Uri.parse("http://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml"))
  .then((Feed feed){print(feed.title);});
```

Please refer to the example or test directory for more information on usage. The API is pretty self explanatory.
