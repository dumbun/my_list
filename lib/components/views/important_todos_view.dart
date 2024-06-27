import 'package:flutter/material.dart';
import 'package:my_list/components/views/responsive%20layouts/desktop_layout.dart';
import 'package:my_list/components/views/responsive%20layouts/mobile_layout.dart';
import 'package:my_list/components/views/responsive%20layouts/tablet_layout.dart';
import 'package:my_list/components/widgets/response_layout_widget.dart';
import 'package:my_list/components/widgets/todo_list_builder.dart';
import 'package:my_list/database/firebase_helper.dart';

class ImportantTodosView extends StatelessWidget {
  const ImportantTodosView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: const Text("Important ToDo's"),
    );

    return ResponseLayoutWidget(
      mobileLayout: MobileLayout(
        appBar: appBar,
        body: Column(
          children: [
            TodoListBuilder(
              stream: Backend.getImportantUserTodos(),
            ),
          ],
        ),
      ),
      tabletLayout: TabletLayout(
        appBar: appBar,
        body: Column(
          children: [
            TodoListBuilder(
              stream: Backend.getImportantUserTodos(),
            ),
          ],
        ),
      ),
      desktoplayout: DesktopLayout(
        body: Column(
          children: [
            const SizedBox(height: 12),
            TodoListBuilder(
              stream: Backend.getImportantUserTodos(),
            ),
          ],
        ),
      ),
    );
  }
}
