import 'package:flutter/material.dart';

MediaQueryData useMediaQuery(BuildContext context) {
  return MediaQuery.of(context);
}

ThemeData useTheme(BuildContext context) => Theme.of(context);
EdgeInsetsGeometry useEdgeNoOnly({
  double width = 0.0,
  double height = 0.0,
}) =>
    EdgeInsets.only(
      left: width,
      right: width,
      top: height,
      bottom: height,
    );
