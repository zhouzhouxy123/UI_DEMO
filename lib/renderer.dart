import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ui_works/ui.dart';

class SizedContainer {
  double width;
  double height;
  Widget child;

  SizedContainer(
      {required this.width, required this.height, required this.child});
}

class MV extends StatelessWidget {
  final UI viewObject;

  const MV({Key? key, required this.viewObject}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final parentSize = constraints.biggest; 
      final (width, height) = viewObject.computeLayout();
      final wScale = parentSize.width / width; 
      final hScale = parentSize.height / height;
      final container = viewImpl(viewObject, wScale, hScale);
      return container.child;
    });
  }
}

SizedContainer viewImpl(UI viewObject, double wScale, double hScale) {
  wScale *= viewObject.wScale; 
  hScale *= viewObject.hScale;
  final mWidth = viewObject.width * wScale;
  final mHeight = viewObject.height * hScale;

  switch (viewObject) {
    case Label label:
      {
        final text = Text(
          label.text,
          style: TextStyle(
            fontSize: label.fontSize,
          ),
        );
        final container = SizedBox(
          width: mWidth,
          height: mHeight,
          child: FittedBox( //布局
            fit: BoxFit.contain,
            child: text,
          ),
        );
        return SizedContainer(
          width: mWidth,
          height: mHeight,
          child: container,
        );
      }
    case Frame frame:
      {
        final List<Widget> elements = [];
        final hPadding = frame.padding * wScale;
        final vPadding = frame.padding * hScale;
        final hBorder = frame.border * wScale;
        final vBorder = frame.border * hScale;

        final border = Container(
          width: mWidth,
          height: mHeight,
          padding:
              EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: min(hBorder, vBorder),
            ),
          )
        );

        elements.add(Positioned(
          left: 0,
          top: 0,
          height: mHeight,
          width: mWidth,
          child: border,
        ));

        if (frame.vertical) {
          var y = viewObject.padding * hScale; 
          final space = viewObject.space * hScale; 

          for (final (_, childView) in viewObject.children) {
            final container = viewImpl(childView, wScale, hScale); 
            final x = (mWidth - container.width) / 2; 
            elements.add(Positioned( 
              left: x,
              top: y,
              child: container.child,
            ));
            y += container.height + space;
          }
        } else {
          var x = viewObject.padding * wScale;
          final space = viewObject.space * wScale;

          for (final (_, childView) in viewObject.children) {
            final container = viewImpl(childView, wScale, hScale);
            final y = (mHeight - container.height) / 2;
            elements.add(Positioned(
              left: x,
              top: y,
              child: container.child,
            ));
            x += container.width + space;
          }
        }

        final c = SizedBox(
          width: mWidth,
          height: mHeight,
          child: Stack(
            children: elements,
          ),
        );

        return SizedContainer(
          width: mWidth,
          height: mHeight,
          child: c,
        );
      }
    default:
      {
        throw Exception('Unknown view type');
      }
  }
}
