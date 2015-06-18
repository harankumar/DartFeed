#!/bin/bash

set -e

dartanalyzer --fatal-warnings \
  lib/*.dart \
  test/*.dart

cd test
dart DartFeed_test.dart