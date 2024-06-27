import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_list/components/widgets/linear_loding_widget.dart';
import 'package:my_list/database/firebase_helper.dart';
import 'package:my_list/models/todo_items_model.dart';

class SubtaskListBuilderWidget extends ConsumerWidget {
  const SubtaskListBuilderWidget({
    super.key,
    required this.stream,
    required this.todoID,
  });
  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  final String todoID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void updateSubTaskCompleted(String documentID, bool completed) async {
      ref.read(loadingProvider.notifier).update(
            (state) => true,
          );
      await Backend.updateSubTaskCompleted(todoID, documentID, completed);
      ref.read(loadingProvider.notifier).update(
            (state) => false,
          );
    }

    void delete(String documentID) async {
      ref.read(loadingProvider.notifier).update(
            (state) => true,
          );
      await Backend.deleteSubTaskCompleted(todoID, documentID);
      ref.read(loadingProvider.notifier).update(
            (state) => false,
          );
    }

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Text("Error : ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator.adaptive();
        }
        return ListView(
          children: snapshot.data!.docs.map(
            (DocumentSnapshot document) {
              final TodoItems todoItem = TodoItems.fromJson(
                document.data()! as Map<String, dynamic>,
              );
              return Card(
                elevation: 0.5,
                child: ListTile(
                  style: ListTileStyle.list,
                  leading: IconButton(
                    tooltip: "press to make this task completed",
                    icon: todoItem.completed
                        ? Icon(
                            color: Colors.purple[400],
                            Icons.circle,
                          )
                        : const Icon(
                            Icons.circle_outlined,
                          ),
                    onPressed: () => updateSubTaskCompleted(document.id, !todoItem.completed),
                  ),
                  title: Text(todoItem.title),
                  trailing: IconButton(
                    onPressed: () => delete(document.id),
                    icon: const Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.red,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}


/*

 Container(
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: todoItem.completed
                            ? Icon(
                                color: Colors.purple[400],
                                Icons.circle,
                              )
                            : const Icon(
                                Icons.circle_outlined,
                              ),
                      ),
                    ],
                  ),
                );


 */