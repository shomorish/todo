import 'package:todo/models/note/todo_provider.dart';

class ToDo {
  final int? id;
  final String title;
  final String details;
  final bool isCompleted;

  const ToDo(
    this.title,
    this.details,
    this.isCompleted, [
    this.id,
  ]);

  Map<String, Object?> toMap() {
    final map = <String, Object?>{
      columnTitle: title,
      columnDetails: details,
      columnIsCompleted: isCompleted ? 1 : 0,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  ToDo.fromMap(Map<String, Object?> map)
      : id = map[columnId] as int,
        title = map[columnTitle] as String,
        details = map[columnDetails] as String,
        isCompleted = (map[columnIsCompleted] as int) == 1;

  ToDo copy({
    int? id,
    String? title,
    String? details,
    bool? isCompleted,
  }) =>
      ToDo(
        title ?? this.title,
        details ?? this.details,
        isCompleted ?? this.isCompleted,
        id ?? this.id,
      );
}
