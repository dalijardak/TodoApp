import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Todo with ChangeNotifier {
  int id;
  String title;
  String description;
  String createdOn;
  String dueDate;
  bool isDone;
  Todo({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.createdOn = '',
    this.dueDate = '',
    this.isDone = false,
  });

  void toggleCompleted() {
    isDone = !isDone;
    notifyListeners();
  }

  Todo copyWith({
    int? id,
    String? title,
    String? description,
    String? createdOn,
    String? dueDate,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdOn: createdOn ?? this.createdOn,
      dueDate: dueDate ?? this.dueDate,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdOn': createdOn,
      'dueDate': dueDate,
      'isDone': isDone,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      createdOn: formatCreatedOn(map['createdOn']) ?? '',
      dueDate: formatDueDate(map['dueDate']) ?? '',
      isDone: map['isDone'] == 0 ? false : true,
    );
  }

  static formatDueDate(String date) {
    date = date.substring(6, date.length - 2);
    return date;
  }

  static formatCreatedOn(String date) {
    var dates = date.split("-");
    return "${dates[2]}/${dates[1]}/${dates[0]}";
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, description: $description, createdOn: $createdOn, dudeDate: $dueDate, isDone: $isDone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.createdOn == createdOn &&
        other.dueDate == dueDate &&
        other.isDone == isDone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        createdOn.hashCode ^
        dueDate.hashCode ^
        isDone.hashCode;
  }
}
