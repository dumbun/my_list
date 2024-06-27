import 'package:flutter/material.dart';

import 'package:my_list/components/views/responsive%20layouts/desktop_layout.dart';
import 'package:my_list/components/views/responsive%20layouts/mobile_layout.dart';
import 'package:my_list/components/views/responsive%20layouts/tablet_layout.dart';
import 'package:my_list/components/widgets/add_todo_widget.dart';
import 'package:my_list/components/widgets/grid_widget.dart';
import 'package:my_list/components/widgets/response_layout_widget.dart';
import 'package:my_list/components/widgets/todo_list_builder.dart';
import 'package:my_list/constants/constants.dart';
import 'package:my_list/database/firebase_helper.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: const Text("My List"),
    );

    return ResponseLayoutWidget(
      //? M o b i l e  L a y o u t
      mobileLayout: MobileLayout(
        appBar: appBar,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Constants.addNewTodoPage);
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: <Widget>[
            const GridWidget(
              aspectRatio: 1,
              crossAxisCount: 2,
            ),
            TodoListBuilder(
              stream: Backend.getUserTodos(),
            ),
          ],
        ),
      ),

      //? T A B L E T   V I E W
      tabletLayout: TabletLayout(
        appBar: appBar,
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushNamed(Constants.addNewTodoPage),
          child: const Icon(Icons.add),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const GridWidget(
                aspectRatio: 4,
                crossAxisCount: 4,
              ),
              TodoListBuilder(
                stream: Backend.getUserTodos(),
              ),
            ],
          ),
        ),
      ),

      //? D e s k t o p  L a y o u t
      desktoplayout: DesktopLayout(
        extendedSizedWidget: const AddTodoWidget(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const GridWidget(
              aspectRatio: 4,
              crossAxisCount: 4,
            ),
            TodoListBuilder(
              stream: Backend.getUserTodos(),
            ),
          ],
        ),
      ),
    );
  }
}
