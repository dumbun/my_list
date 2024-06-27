import 'package:flutter/material.dart';

class ResponseLayoutWidget extends StatelessWidget {
  const ResponseLayoutWidget({
    super.key,
    required this.mobileLayout,
    required this.tabletLayout,
    required this.desktoplayout,
  });
  final Widget mobileLayout;
  final Widget tabletLayout;
  final Widget desktoplayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 550) {
          return mobileLayout;
        } else if (constraints.maxWidth < 1100) {
          return tabletLayout;
        } else {
          return desktoplayout;
        }
      },
    );
  }
}
