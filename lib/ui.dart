import 'dart:math';

import 'package:flutter/material.dart';

abstract class UI {
  double width = 0.0;
  double height = 0.0;
  double wScale = 1.0;
  double hScale = 1.0;

  (double, double) computeLayout();
}

class Frame extends UI {
  double padding;
  double space;
  double border;
  bool vertical;
  List<(double, UI)> children;

  Frame(
      {this.padding = 3,
      this.space = 5,
      this.border = 0.5,
      this.vertical = true,
      required this.children});

  static Frame single(UI child) => Frame(children: [(1, child)]);

  @override
  (double, double) computeLayout() {
    if (vertical) {
      var height = (padding + border) * 2;
      var width = 0.0;

      if (children.isNotEmpty) {
        for (final (span, child) in children) {
          var (iW, iH) = child.computeLayout();
          child.hScale *= span;
          iH *= span;

          height += iH + space;
          width = max(width, iW);
        }
        height -= space; //最后一个框不用space
      }  

      width += (padding + border) * 2;

      this.width = width;
      this.height = height;
    } else {
      var height = 0.0;
      var width = (padding + border) * 2;

      if (children.isNotEmpty) {
        for (final (span, child) in children) {
          var (iW, iH) = child.computeLayout();
          child.wScale *= span;
          iW *= span;

          width += iW + space;
          height = max(height, iH);
        }
        width -= space;
      }

      height += (padding + border) * 2;

      this.width = width;
      this.height = height;
    }

    return (width, height);
  }
}

class Label extends UI {
  String text;
  double fontSize;
  Label({
    required this.text,
    this.fontSize = 14,
  });

  @override
  (double, double) computeLayout() {
    final style = TextStyle(fontSize: fontSize);
    final size = computetextSize(text, style);
    width = size.width;
    height = size.height;
    return (width, height);
  }
}

Size computetextSize(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}

class Click{
  final UI child;
  final void Function() onClick;

  Click({required this.child, required this.onClick});  
}
 