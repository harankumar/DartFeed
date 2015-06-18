#!/bin/bash

set -e

dartanalyzer --fatal-warnings \
  lib/*.dart \
  test/*.dart

dart ../test/DartFeed_test.dart