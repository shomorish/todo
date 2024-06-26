import 'package:todo/models/todo/todo_provider.dart';

class ToDo {
  final int? id;
  final String title;
  final String? details;
  final bool isCompleted;

  const ToDo(
    this.title,
    this.isCompleted, {
    this.id,
    this.details,
  });

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
        isCompleted ?? this.isCompleted,
        id: id ?? this.id,
        details: details ?? this.details,
      );

  @override
  bool operator ==(Object other) =>
      other is ToDo &&
      other.runtimeType == runtimeType &&
      other.id == id &&
      other.title == title &&
      other.details == details &&
      other.isCompleted == isCompleted;

  @override
  int get hashCode => id.hashCode;
}
