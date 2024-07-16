import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_list/components/widgets/input_text_field_widget.dart';
import 'package:my_list/database/firebase_helper.dart';
import 'package:my_list/main.dart';

class AddTodoWidget extends StatefulWidget {
  const AddTodoWidget({super.key});

  @override
  State<AddTodoWidget> createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _todoTitle = TextEditingController();
  final TextEditingController _subTask = TextEditingController();
  final TextEditingController _todoDescription = TextEditingController();
  final TextEditingController _date = TextEditingController(text: "Today");
  bool _isloding = false;
  DateTime? _selectedDate;
  final List<Map<String, dynamic>> _subTasks = [];

  // Function to combine date and time into a DateTime object
  DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  void _doSaving() async {
    if (_formKey.checkValidation) {
      final String? userEmail = FirebaseAuth.instance.currentUser?.email;
      if (userEmail != null) {
        try {
          setState(() {
            _isloding = true;
          });
          await Backend.addTodo({
            "email": userEmail,
            "title": _todoTitle.text,
            "description": _todoDescription.text,
            "important": false,
            "completed": false,
            "reminderTime": _selectedDate ?? DateTime.now(),
            "date": DateTime.now(),
          }, _subTasks);

          _date.clear();
          _subTask.clear();
          _subTasks.clear();
          _todoTitle.clear();
          _todoDescription.clear();
          _selectedDate = null;

          setState(() {
            _isloding = false;
          });
        } catch (e) {
          setState(() {
            _isloding = false;
          });
          showError(e);
        }
      }
    }
  }

  void showError(e) {
    return showAboutDialog(
      context: context,
      children: [
        Text(
          e.toString(),
        ),
      ],
    );
  }

  void _addSubTask() {
    if (_subTask.text.isNotEmpty) {
      setState(() {
        _subTasks.add(
          {
            "title": _subTask.text,
            "createdDate": DateTime.now(),
            "completed": false,
          },
        );
      });
      _subTask.clear();
    }
  }

  @override
  void dispose() {
    _date.dispose();
    _subTask.dispose();
    _todoTitle.dispose();
    _todoDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InputTextField(
                      border: true,
                      controller: _todoTitle,
                      hintText: "Title",
                      validator: (String? value) {
                        if (value == null || value.isEmpty || value == "") {
                          return 'Please enter Title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    InputTextField(
                      border: true,
                      controller: _todoDescription,
                      hintText: "Please type a Discreption",
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            // Show the date picker and wait for the user to select a date
                            final DateTime? date = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(9999),
                              initialDate: DateTime.now(),
                              initialDatePickerMode: DatePickerMode.day,
                            );

                            if (date != null) {
                              // Show the time picker and wait for the user to select a time
                              final TimeOfDay? time = await showTimePicker(
                                // ignore: use_build_context_synchronously
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );

                              if (time != null) {
                                // Combine the date and time into a DateTime object
                                final DateTime dateTime = combineDateAndTime(date, time);
                                // Use the combined DateTime object as needed
                                setState(() {
                                  _date.text = dateTime.toString();
                                  _selectedDate = dateTime;
                                });
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(),
                              color: Colors.purple[100],
                            ),
                            child: Text(
                              _date.text.isEmpty ? "Today" : _date.text,
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Text("${_subTasks.length} sub tasks")
                      ],
                    ),
                    const SizedBox(height: 26),
                    Visibility(
                      visible: _subTasks.isEmpty,
                      replacement: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _subTasks.map(
                          (Map<String, dynamic> e) {
                            return Text(e['title']);
                          },
                        ).toList(),
                      ),
                      child: const Text("No Sub Tasks Added"),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: (String value) => _addSubTask(),
                    controller: _subTask,
                    decoration: const InputDecoration(
                      label: Text("Sub task"),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: _addSubTask,
                  icon: const Icon(Icons.add),
                  label: const Text("Add sub Task"),
                ),
              ],
            ),
            const SizedBox(height: 26),
            _isloding
                ? const LinearProgressIndicator()
                : ElevatedButton(
                    onPressed: _doSaving,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.purple[100],
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
