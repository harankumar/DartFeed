#!/bin/bash

set -e

dartanalyzer --fatal-warnings \
  lib/*.dart \
  test/*.dart

pub run test