import 'package:flutter/material.dart';
import 'package:my_list/components/views/responsive%20layouts/desktop_layout.dart';
import 'package:my_list/components/views/responsive%20layouts/mobile_layout.dart';
import 'package:my_list/components/views/responsive%20layouts/tablet_layout.dart';
import 'package:my_list/components/widgets/add_todo_widget.dart';
import 'package:my_list/components/widgets/response_layout_widget.dart';
import 'package:my_list/components/widgets/todo_list_builder.dart';
import 'package:my_list/database/firebase_helper.dart';

class AllTodosView extends StatelessWidget {
  const AllTodosView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: const Text("Your ToDo's"),
    );
    return ResponseLayoutWidget(
      mobileLayout: MobileLayout(
        appBar: appBar,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TodoListBuilder(
              stream: Backend.getUserTodos(),
            ),
          ],
        ),
      ),
      tabletLayout: TabletLayout(
        appBar: appBar,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TodoListBuilder(
              stream: Backend.getUserTodos(),
            ),
          ],
        ),
      ),
      desktoplayout: DesktopLayout(
        extendedSizedWidget: const AddTodoWidget(),
        body: TodoListBuilder(
          stream: Backend.getUserTodos(),
        ),
      ),
    );
  }
}
