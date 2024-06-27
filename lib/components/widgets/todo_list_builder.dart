import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_list/database/firebase_helper.dart';
import 'package:my_list/date_utile.dart';
import 'package:my_list/models/todo_model.dart';
import 'package:my_list/routes/routes.dart';

class TodoListBuilder extends StatelessWidget {
  const TodoListBuilder({super.key, required this.stream});
  final Stream<QuerySnapshot<Map<String, dynamic>>>? stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Expanded(
          child: ListView(
            children: snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                final Todo todo = Todo.fromJson(document.data()! as Map<String, dynamic>);
                return Card(
                  elevation: 1,
                  child: ListTile(
                    subtitleTextStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(todo.description),
                        Card(
                          elevation: 0,
                          color: Colors.grey[300],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              DateConvertUtils.formate(todo.reminderTime),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      Routes.navigateToTodoDetailsView(
                        buildContext: context,
                        id: document.id,
                        todo: todo,
                      );
                    },
                    leading: IconButton(
                      onPressed: () => Backend.updateDocumentTodoCompleted(!todo.completed, document),
                      icon: todo.completed
                          ? Icon(
                              color: Colors.purple[400],
                              Icons.circle,
                            )
                          : const Icon(
                              Icons.circle_outlined,
                            ),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Backend.updateDocumentImportant(!todo.important, document);
                            },
                            icon: Icon(
                              color: todo.important ? Colors.purple : Colors.black,
                              todo.important ? Icons.star_rate_rounded : Icons.star_outline_rounded,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await Backend.deleteTodoDocument(document.id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple[500]),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
