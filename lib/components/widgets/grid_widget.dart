import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_list/components/widgets/stack_box_widget.dart';
import 'package:my_list/constants/constants.dart';
import 'package:my_list/database/firebase_helper.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({
    super.key,
    required this.crossAxisCount,
    required this.aspectRatio,
  });

  final int crossAxisCount;
  final double aspectRatio;

  GridView _buildCards(
    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
    BuildContext context,
  ) {
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshot.data!.docs;

    final int totalCount = docs.length;

    final int completedTodos = docs.where(
      (DocumentSnapshot<Object?> element) {
        final Map<String, dynamic> d = element.data()! as Map<String, dynamic>;
        return d["completed"];
      },
    ).length;
    final int inCompletedTodos = docs.where(
      (DocumentSnapshot<Object?> element) {
        final Map<String, dynamic> d = element.data()! as Map<String, dynamic>;
        return !d["completed"];
      },
    ).length;

    final int importantTodoCount = docs.where((DocumentSnapshot<Object?> element) {
      final Map<String, dynamic> t = element.data()! as Map<String, dynamic>;
      return t["important"];
    }).length;

    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
      ),
      children: <Widget>[
        StackBoxWidget(
          value: totalCount.toString(),
          mainText: "Total ToDo's",
          onTap: () {
            Navigator.of(context).pushNamed(Constants.allTodosview);
          },
        ),
        StackBoxWidget(
          value: completedTodos.toString(),
          mainText: "Completed",
          onTap: () {
            Navigator.of(context).pushNamed<Object?>(
              Constants.completedTodosView,
            );
          },
        ),
        StackBoxWidget(
          value: inCompletedTodos.toString(),
          mainText: "In Completed",
          onTap: () {
            Navigator.of(context).pushNamed<Object?>(
              Constants.incompletedTodosView,
            );
          },
        ),
        StackBoxWidget(
          value: importantTodoCount.toString(),
          mainText: "Important",
          onTap: () {
            Navigator.of(context).pushNamed<Object?>(
              Constants.importantTodosView,
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: SizedBox(
        width: double.infinity,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: Backend.getUserTodos(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) {
              return Text('error : ${snapshot.error.toString()}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return _buildCards(snapshot, context);
          },
        ),
      ),
    );
  }
}
