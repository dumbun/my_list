import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Backend {
  static FirebaseFirestore _db() {
    return FirebaseFirestore.instance;
  }

  User? get currentUser => FirebaseAuth.instance.currentUser;

  static Future<void> addTodo(Map<String, dynamic> todoData,
      List<Map<String, dynamic>> todoSubListItems) async {
    if (FirebaseAuth.instance.currentUser != null) {
      final DocumentReference<Map<String, dynamic>> response =
          await Backend._db().collection('todo').add(todoData);
      for (var element in todoSubListItems) {
        await FirebaseFirestore.instance
            .collection("${response.path}/subTasks")
            .add(
              element,
            );
      }
    }
  }

  static Future<void> addSubTask(
      String todoID, Map<String, dynamic> todoItem) async {
    await FirebaseFirestore.instance
        .collection("todo")
        .doc(todoID)
        .collection("subTasks")
        .add(todoItem);
  }

  static Future<void> addNewUser(String email) async {
    await FirebaseFirestore.instance.collection('users').get().then<Null>(
      (QuerySnapshot<Map<dynamic, dynamic>> querySnapshot) {
        final List<QueryDocumentSnapshot<Map<dynamic, dynamic>>> data =
            querySnapshot.docs;
        final d = data.where(
            (QueryDocumentSnapshot<Map<dynamic, dynamic>> element) =>
                element["email"] == email);
        if (d.isEmpty) {
          FirebaseFirestore.instance.collection('users').add({"email": email});
        }
      },
    );
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchTodoSubTasks(
      String documentID) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> todoStream =
        FirebaseFirestore.instance
            .collection('todo')
            .doc(documentID)
            .collection('subTasks')
            .snapshots(includeMetadataChanges: true);
    return todoStream;
  }

  static Future<void> updateSubTaskCompleted(
      String documentID, String subTaskID, bool completed) async {
    await FirebaseFirestore.instance
        .collection('todo/')
        .doc(documentID)
        .collection('subTasks/')
        .doc(subTaskID)
        .update({'completed': completed});
  }

  static Future<void> deleteSubTaskCompleted(
      String documentID, String subTaskID) async {
    await FirebaseFirestore.instance
        .collection('todo/')
        .doc(documentID)
        .collection('subTasks/')
        .doc(subTaskID)
        .delete();
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> fetchTodoDetails(
      String id) {
    final Stream<DocumentSnapshot<Map<String, dynamic>>> todoStream =
        FirebaseFirestore.instance
            .collection('todo/')
            .doc(id)
            .snapshots(includeMetadataChanges: true);
    return todoStream;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserTodos() {
    Stream<QuerySnapshot<Map<String, dynamic>>> collectionStream =
        FirebaseFirestore.instance
            .collection('todo')
            .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .snapshots(includeMetadataChanges: true);
    return collectionStream;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCompletedUserTodos() {
    Stream<QuerySnapshot<Map<String, dynamic>>> collectionStream =
        FirebaseFirestore.instance
            .collection('todo')
            .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .where("completed", isEqualTo: true)
            .snapshots(includeMetadataChanges: true);
    return collectionStream;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getInCompletedUserTodos() {
    Stream<QuerySnapshot<Map<String, dynamic>>> collectionStream =
        FirebaseFirestore.instance
            .collection('todo')
            .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .where("completed", isEqualTo: false)
            .snapshots(includeMetadataChanges: true);
    return collectionStream;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getImportantUserTodos() {
    Stream<QuerySnapshot<Map<String, dynamic>>> collectionStream =
        FirebaseFirestore.instance
            .collection('todo')
            .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .where("important", isEqualTo: true)
            .snapshots(includeMetadataChanges: true);
    return collectionStream;
  }

  static Future<void> updateDocumentTitle(
    String newTitle,
    String documentID,
  ) async {
    await FirebaseFirestore.instance
        .collection('todo')
        .doc(documentID)
        .update({'title': newTitle});
  }

  static Future<void> updateDocumentDescription(
    String newDiscription,
    String documentID,
  ) async {
    await FirebaseFirestore.instance
        .collection(
          'todo',
        )
        .doc(
          documentID,
        )
        .update(
      {'description': newDiscription},
    );
  }

  static Future<void> updateDocumentImportant(
      bool important, DocumentSnapshot document) async {
    return await FirebaseFirestore.instance
        .collection('todo')
        .doc(document.id)
        .update(
      {'important': important},
    );
  }

  static Future<void> deleteTodoDocument(String documentID) async {
    if (FirebaseAuth.instance.currentUser != null) {
      return await FirebaseFirestore.instance
          .collection('todo')
          .doc(documentID)
          .delete();
    }
  }

  static Future<void> updateDocumentTodoCompleted(
      bool completed, DocumentSnapshot document) async {
    if (FirebaseAuth.instance.currentUser != null) {
      return await FirebaseFirestore.instance
          .collection('todo')
          .doc(document.id)
          .update(
        {'completed': completed},
      );
    }
  }

  static Future<int> fetchCompletedTodosCount() async {
    int count = 0;

    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('todo')
          .where(
            "email",
            isEqualTo: currentUser.email,
          )
          .get()
          .then<Null>(
        (QuerySnapshot<Map<dynamic, dynamic>> querySnapshot) {
          for (var doc in querySnapshot.docs) {
            if (doc["completed"] == true) {
              count = count + 1;
            }
          }
        },
      );
    }
    return count;
  }
}
