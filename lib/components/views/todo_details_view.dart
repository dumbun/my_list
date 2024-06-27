import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list/components/views/responsive%20layouts/desktop_layout.dart';
import 'package:my_list/components/views/responsive%20layouts/mobile_layout.dart';
import 'package:my_list/components/views/responsive%20layouts/tablet_layout.dart';
import 'package:my_list/components/widgets/circular_loading_widget.dart';
import 'package:my_list/components/widgets/input_text_field_widget.dart';
import 'package:my_list/components/widgets/linear_loding_widget.dart';
import 'package:my_list/components/widgets/response_layout_widget.dart';
import 'package:my_list/components/widgets/subtask_list_builder_widget.dart';
import 'package:my_list/database/firebase_helper.dart';
import 'package:my_list/date_utile.dart';
import 'package:my_list/models/todo_model.dart';
import 'package:my_list/routes/routes.dart';

class TodoDetailsView extends StatefulWidget {
  final String id;
  final Todo todo;
  const TodoDetailsView({
    super.key,
    required this.todo,
    required this.id,
  });

  @override
  State<TodoDetailsView> createState() => _TodoDetailsViewState();
}

class _TodoDetailsViewState extends State<TodoDetailsView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _discriptionController = TextEditingController();
  final TextEditingController _subTaskController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.todo.title;
    _discriptionController.text = widget.todo.description;
    super.initState();
  }

  @override
  void dispose() {
    _subTaskController.dispose();
    _discriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      actions: [
        _buildLodingWidget(),
      ],
      title: Text(DateConvertUtils.formate(widget.todo.reminderTime)),
    );

    //? M O B I L E   L A Y O U T
    return ResponseLayoutWidget(
      mobileLayout: MobileLayout(
        appBar: appBar,
        body: _buildBothMobileAndTabletLayout(),
      ),

      //? T A B L E T   L A Y O U T
      tabletLayout: TabletLayout(
        appBar: appBar,
        body: _buildBothMobileAndTabletLayout(),
      ),

      //? D E S K T O P   L A Y O U T
      desktoplayout: DesktopLayout(
        extendedSizedWidget: Column(
          children: [
            _buildDeleteTodoButton(),
            const SizedBox(height: 16.0),
            _buildAddNewTask(),
          ],
        ),
        appBar: AppBar(
          actions: [
            _buildLodingWidget(),
          ],
          title: Text(DateConvertUtils.formate(widget.todo.reminderTime)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _buildStremBuilder(),
              _buildSubTasksWidget(),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView _buildBothMobileAndTabletLayout() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildStremBuilder(),
            _buildSubTasksWidget(),
            _buildAddNewTask(),
            _buildDeleteTodoButton(),
          ],
        ),
      ),
    );
  }

  InkWell _buildDeleteTodoButton() {
    return InkWell(
      onTap: () async {
        Backend.deleteTodoDocument(widget.id).then(
          (void value) => Routes.navigateToHomeScreen(
            buildContext: context,
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.red[300],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(),
        ),
        child: const Text("Delete todo"),
      ),
    );
  }

  Padding _buildLodingWidget() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return const CircularLoadingWidget();
        },
      ),
    );
  }

  void _updateTodoTitle(String? newTitle, WidgetRef ref) async {
    if (newTitle != null) {
      ref.read(loadingProvider.notifier).state = true;
      await Backend.updateDocumentTitle(newTitle, widget.id);
      ref.read(loadingProvider.notifier).state = false;
    }
  }

  void _updateTodoDescription(String? newDescription, WidgetRef ref) async {
    if (newDescription != null) {
      ref.read(loadingProvider.notifier).state = true;
      await Backend.updateDocumentDescription(newDescription, widget.id);
      ref.read(loadingProvider.notifier).state = false;
    }
  }

  void _addNewSubTask(WidgetRef ref) async {
    if (_subTaskController.text.isNotEmpty) {
      ref.read(loadingProvider.notifier).state = true;
      await Backend.addSubTask(
        widget.id,
        {
          "completed": false,
          "createdDate": Timestamp.now(),
          "title": _subTaskController.text,
        },
      ).then(
        (value) => _subTaskController.clear(),
      );
      ref.read(loadingProvider.notifier).state = false;
    }
  }

  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>> _buildStremBuilder() {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: Backend.fetchTodoDetails(widget.id),
      builder: (
        BuildContext context,
        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
      ) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Title
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  minLines: 1,
                  controller: _titleController,
                  style: const TextStyle(
                    fontSize: 32,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (String? value) => _updateTodoTitle(value, ref),
                ),

                // Discription
                const Text(
                  "Description :",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w100),
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1, //Normal textInputField will be displayed
                  maxLines: kIsWeb ? 10 : 5, // when user presses enter it will adapt to it
                  controller: _discriptionController,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (String? value) => _updateTodoDescription(value, ref),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Sub Tasks : ",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Column _buildSubTasksWidget() {
    return Column(
      children: [
        const SizedBox(height: 12),
        SizedBox(
          height: 300,
          child: SubtaskListBuilderWidget(
            todoID: widget.id,
            stream: Backend.fetchTodoSubTasks(widget.id),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Consumer _buildAddNewTask() {
    return Consumer(
      builder: (context, ref, child) {
        return Column(
          children: [
            InputTextField(
              controller: _subTaskController,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _addNewSubTask(ref),
              child: const Text(
                "Add new Sub Tasks",
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
