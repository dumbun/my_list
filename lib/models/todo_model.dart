import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String email;
  final String title;
  final Timestamp date;
  final bool important;
  final String description;
  final Timestamp reminderTime;
  final bool completed;
  Todo({
    required this.email,
    required this.title,
    required this.date,
    required this.important,
    required this.description,
    required this.reminderTime,
    required this.completed,
  });

  Todo copyWith({
    String? email,
    String? title,
    Timestamp? date,
    bool? important,
    String? description,
    Timestamp? reminderTime,
    bool? completed,
  }) {
    return Todo(
      email: email ?? this.email,
      title: title ?? this.title,
      date: date ?? this.date,
      important: important ?? this.important,
      description: description ?? this.description,
      reminderTime: reminderTime ?? this.reminderTime,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'title': title,
      'date': date,
      'important': important,
      'description': description,
      'reminderTime': reminderTime,
      'completed': completed,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      email: map['email'] as String,
      title: map['title'] as String,
      date: map['date'] as Timestamp,
      important: map['important'] as bool,
      description: map['description'] as String,
      reminderTime: map['reminderTime'] as Timestamp,
      completed: map['completed'] as bool,
    );
  }

  Todo.fromJson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          email: json['email']! as String,
          date: json['date']! as Timestamp,
          description: json['description']! as String,
          important: json["important"]! as bool,
          reminderTime: json['reminderTime']! as Timestamp,
          completed: json['completed']! as bool,
        );

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Todo(email: $email, title: $title, date: $date, important: $important, description: $description, reminderTime: $reminderTime, completed: $completed)';
  }

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.title == title &&
        other.date == date &&
        other.important == important &&
        other.description == description &&
        other.reminderTime == reminderTime &&
        other.completed == completed;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        title.hashCode ^
        date.hashCode ^
        important.hashCode ^
        description.hashCode ^
        reminderTime.hashCode ^
        completed.hashCode;
  }
}
