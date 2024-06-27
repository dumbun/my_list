import 'package:flutter/material.dart';
import 'package:my_list/components/widgets/drawer_widget.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({
    super.key,
    required this.body,
    this.extendedSizedWidget,
    this.floatingActionButton,
    this.appBar,
  });
  final Widget body;
  final Widget? extendedSizedWidget;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DrawerWidget(),
              Expanded(flex: 2, child: body),
              Expanded(flex: 1, child: _getExtendedSideWidget()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getExtendedSideWidget() {
    if (extendedSizedWidget != null) {
      return extendedSizedWidget!;
    } else {
      return const SizedBox.shrink();
    }
  }
}
