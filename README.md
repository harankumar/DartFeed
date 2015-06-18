# DartFeed
Simple RSS 2.0 feed reader library.

## Example Usage

```dart
FeedParser parser = new FeedParser()
  ..stream.listen((Feed feed){print(feed.title);});
```

Please refer to the example or test directory for more information on usage. The API is pretty self explanatory.