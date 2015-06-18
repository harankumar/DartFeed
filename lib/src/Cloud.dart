// Copyright (c) 2015, Haran Kumar. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of DartFeed;

class Cloud {
  Uri domain;
  int port;
  String path;
  String registerProcedure;
  String protocol;

  Cloud.fromXml(XmlElement element) {
    if (element == null) return;
    domain = Uri.parse(element.getAttribute("domain"));
    port = int.parse(element.getAttribute("port"));
    path = element.getAttribute("path");
    registerProcedure = element.getAttribute("registerProcedure");
    protocol = element.getAttribute("protocol");
  }
}
