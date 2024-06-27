// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TodoItems {
  final bool completed;
  final Timestamp createdDate;
  final String title;

  TodoItems({
    required this.completed,
    required this.createdDate,
    required this.title,
  });

  TodoItems copyWith({
    bool? completed,
    Timestamp? createdDate,
    String? title,
  }) {
    return TodoItems(
      completed: completed ?? this.completed,
      createdDate: createdDate ?? this.createdDate,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'completed': completed,
      'createdDate': createdDate,
      'title': title,
    };
  }

  factory TodoItems.fromMap(Map<String, dynamic> map) {
    return TodoItems(
      completed: map['completed'] as bool,
      createdDate: map['createdDate'] as Timestamp,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  TodoItems.fromJson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          completed: json['completed']! as bool,
          createdDate: json['createdDate']! as Timestamp,
        );

  @override
  String toString() => 'TodoItems(completed: $completed, createdDate: $createdDate, title: $title)';

  @override
  bool operator ==(covariant TodoItems other) {
    if (identical(this, other)) return true;

    return other.completed == completed && other.createdDate == createdDate && other.title == title;
  }

  @override
  int get hashCode => completed.hashCode ^ createdDate.hashCode ^ title.hashCode;
}
