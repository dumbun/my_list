import 'package:flutter/material.dart';
import 'package:my_list/components/views/responsive%20layouts/desktop_layout.dart';
import 'package:my_list/components/views/responsive%20layouts/mobile_layout.dart';
import 'package:my_list/components/views/responsive%20layouts/tablet_layout.dart';
import 'package:my_list/components/widgets/add_todo_widget.dart';
import 'package:my_list/components/widgets/response_layout_widget.dart';

class AddNewTodoView extends StatelessWidget {
  const AddNewTodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponseLayoutWidget(
      mobileLayout: MobileLayout(
        body: AddTodoWidget(),
      ),
      tabletLayout: TabletLayout(
        body: AddTodoWidget(),
      ),
      desktoplayout: DesktopLayout(
        body: AddTodoWidget(),
      ),
    );
  }
}
