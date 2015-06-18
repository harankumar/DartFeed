#!/bin/bash

set -e

dartanalyzer --fatal-warnings \
  lib/*.dart \
  test/*.dart

# Run Test

cd test
dart DartFeed_test.dart

pub global activate dart_coveralls
dart_coveralls report --token=$coveralls_token DartFeed_test.dart
