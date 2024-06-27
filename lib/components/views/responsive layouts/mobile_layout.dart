import 'package:flutter/material.dart';
import 'package:my_list/components/widgets/drawer_widget.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({
    super.key,
    required this.body,
    this.floatingActionButton,
    this.appBar,
  });
  final Widget? floatingActionButton;
  final Widget body;
  final AppBar? appBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: appBar ?? AppBar(),
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: body,
      ),
    );
  }
}
