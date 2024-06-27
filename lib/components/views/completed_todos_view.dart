import 'package:flutter/material.dart';
import 'package:my_list/components/views/responsive%20layouts/desktop_layout.dart';
import 'package:my_list/components/views/responsive%20layouts/mobile_layout.dart';
import 'package:my_list/components/views/responsive%20layouts/tablet_layout.dart';
import 'package:my_list/components/widgets/response_layout_widget.dart';
import 'package:my_list/components/widgets/todo_list_builder.dart';
import 'package:my_list/database/firebase_helper.dart';

class CompletedTodosView extends StatelessWidget {
  const CompletedTodosView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppBar appbar = AppBar(
      title: const Text("Completed Todo's"),
    );

    return ResponseLayoutWidget(
      mobileLayout: MobileLayout(
          appBar: appbar,
          body: Column(
            children: [
              TodoListBuilder(stream: Backend.getCompletedUserTodos()),
            ],
          )),
      tabletLayout: TabletLayout(
        appBar: appbar,
        body: Column(
          children: [
            TodoListBuilder(stream: Backend.getCompletedUserTodos()),
          ],
        ),
      ),
      desktoplayout: DesktopLayout(
        body: Column(
          children: [
            const SizedBox(height: 12),
            TodoListBuilder(stream: Backend.getCompletedUserTodos()),
          ],
        ),
      ),
    );
  }
}
