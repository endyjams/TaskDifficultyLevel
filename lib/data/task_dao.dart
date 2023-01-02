import 'package:flutter_project/data/database.dart';
import 'package:sqflite/sqflite.dart';

import '../components/task.dart';

class TaskDao {
  static const String table = 'CREATE TABLE $_tablename ('
      '$_name TEXT,'
      ' $_difficulty INTEGER,'
      ' $_image TEXT)';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task task) async {
    print('Initializing save: ');
    final Database database = await getDatabase();
    var taskExists = await find(task.name);
    Map<String, dynamic> taskMap = toMap(task);
    if (taskExists.isEmpty) {
      print('task didnt exist.');
      return await database.insert(_tablename, taskMap);
    } else {
      print('task already exist.');
      return await database.update(
        _tablename,
        taskMap,
        where: '$_name = ?',
        whereArgs: [task.name],
      );
    }
  }

  Map<String, dynamic> toMap(Task task) {
    print('Converting Task to Map: ');
    final Map<String, dynamic> taskMap = Map();
    taskMap[_name] = task.name;
    taskMap[_difficulty] = task.difficulty;
    taskMap[_image] = task.photo;
    print('Task Map: $taskMap');
    return taskMap;
  }

  Future<List<Task>> findAll() async {
    print('Acessing findAll: ');
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(_tablename);
    print('Finding data on database... found: $result');
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> tasksMap) {
    print('Converting to List:');
    final List<Task> tasks = [];
    for (Map<String, dynamic> line in tasksMap) {
      final Task task = Task(line[_name], line[_image], line[_difficulty]);
      tasks.add(task);
    }

    print('Task List $tasks');

    return tasks;
  }

  Future<List<Task>> find(String taskName) async {
    print('Acessing find: ');
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(
      _tablename,
      where: '$_name = ?',
      whereArgs: [taskName],
    );

    print('Found task: ${toList(result)}');
    return toList(result);
  }

  delete(String taskName) async {
    print('Deleting Task: $taskName');
    Database database = await getDatabase();
    return database.delete(
      _tablename,
      where: '$_name = ?',
      whereArgs: [taskName],
    );
  }
}
