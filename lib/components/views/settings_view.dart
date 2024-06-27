import 'package:flutter/material.dart';
import 'package:my_list/components/views/responsive%20layouts/desktop_layout.dart';
import 'package:my_list/components/views/responsive%20layouts/mobile_layout.dart';
import 'package:my_list/components/views/responsive%20layouts/tablet_layout.dart';
import 'package:my_list/components/widgets/response_layout_widget.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: const Text("SETTINGS"),
    );

    return ResponseLayoutWidget(
      mobileLayout: MobileLayout(
        appBar: appBar,
        body: const Text("settings_view"),
      ),
      tabletLayout: TabletLayout(
          appBar: appBar,
          body: const Center(
            child: Text("TabletView"),
          )),
      desktoplayout: const DesktopLayout(
        body: Center(
          child: Text("DesktopLayout"),
        ),
      ),
    );
  }
}
