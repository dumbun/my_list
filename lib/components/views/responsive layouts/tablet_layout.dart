import 'package:flutter/material.dart';
import 'package:my_list/components/widgets/drawer_widget.dart';

class TabletLayout extends StatelessWidget {
  const TabletLayout({super.key, required this.body, this.floatingActionButton, this.appBar});

  final Widget body;
  final Widget? floatingActionButton;
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
