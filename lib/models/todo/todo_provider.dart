import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/models/todo/todo.dart';

const tableToDo = 'todos';
const columnId = '_id';
const columnTitle = 'title';
const columnDetails = 'details';
const columnIsCompleted = 'is_completed';

class ToDoProvider {
  late Database _db;

  Future openDb() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final path = join(appDocDir.path, 'databases', 'todo.db');
    _db = await openDatabase(
      kDebugMode ? inMemoryDatabasePath : path,
      version: 1,
      onCreate: (db, version) {
        // Create a todo table.
        db.execute('''
CREATE TABLE $tableToDo (
  $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
  $columnTitle TEXT NOT NULL,
  $columnDetails TEXT,
  $columnIsCompleted INTEGER NOT NULL)
''');

        // Creates default two todos.
        _createDefaultToDo(db);
      },
      onUpgrade: (db, oldVersion, newVersion) {},
    );
  }

  Future _createDefaultToDo(Database db) async {
    await db.insert(
      tableToDo,
      const ToDo(
        'Add a todo',
        false,
        details: '''
1.Press the "+" button.
2.Enter the title.
3.Press the back button or press the save button.
''',
      ).toMap(),
    );

    await db.insert(
      tableToDo,
      const ToDo(
        'Remove a todo',
        false,
        details: '''
1.Press the trash button.
2.Tap "YES" in the dialog.
''',
      ).toMap(),
    );
  }

  Future<List<ToDo>> getAllToDos() async {
    final List<Map<String, Object?>> maps = await _db.query(
      tableToDo,
      columns: [columnId, columnTitle, columnDetails, columnIsCompleted],
      orderBy: '"$columnId" ASC',
    );
    return maps.map((m) => ToDo.fromMap(m)).toList();
  }

  Stream<List<ToDo>> observeToDos() {
    late final Timer timer;
    late final StreamController<List<ToDo>> controller;
    controller = StreamController<List<ToDo>>(
      onListen: () {
        timer = Timer.periodic(const Duration(milliseconds: 33), (timer) async {
          final toDoList = await getAllToDos();
          controller.sink.add(toDoList);
        });
      },
      onCancel: () {
        timer.cancel();
      },
    );
    return controller.stream;
  }

  Future<ToDo> insertToDo(ToDo toDo) async {
    final id = await _db.insert(
      tableToDo,
      toDo.toMap(),
    );
    return toDo.copy(id: id);
  }

  Future<int> updateToDo(ToDo toDo) async {
    return await _db.update(
      tableToDo,
      toDo.toMap(),
      where: '"$columnId" = ?',
      whereArgs: [toDo.id],
    );
  }

  Future<int> deleteToDo(int id) async {
    return await _db.delete(
      tableToDo,
      where: '"$columnId" = ?',
      whereArgs: [id],
    );
  }
}
