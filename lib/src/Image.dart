// Copyright (c) 2015, Haran Kumar. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of DartFeed;

class Image {
  Uri url;
  String title;
  Uri link;
  int width;
  int height;
  String description;

  Image.fromXml(XmlElement element) {
    if (element == null) return;
    var url = element.findElements("url");
    if (url == null || url.length == 0 || url.first.text == "") {
      throw new Exception(
          "Received a feed image without a url or valid image element");
      this.url = null;
    } else this.url = Uri.parse(_escape(url.first.text));
    var title = element.findElements("title");
    if (title == null || title.length == 0 || title.first.text == "") {
      throw new Exception(
          "Received a feed image without a title or valid title element");
      this.title = "No title";
    } else this.title = title.first.text;
    var link = element.findElements("link");
    if (link == null || link.length == 0 || link.first.text == "") {
      throw new Exception(
          "Received a feed image without a link or valid link element");
      this.link = null;
    } else this.link = Uri.parse(_escape(link.first.text));
    width = int.parse(_getValue("width", element, "88"));
    if (width <= 0 || width > 144) {
      throw new Exception(
          "Received a feed image with invalid width dimension $width. The width must be above 0 and less than 144");
      width = 88;
    }
    height = int.parse(_getValue("height", element, "31"));
    if (height <= 0 || height > 400) {
      throw new Exception(
          "Received a feed image with invalid width dimension $height. The width must be above 0 and less than 400");
      height = 144;
    }
    description = element.getAttribute("description");
  }
}
