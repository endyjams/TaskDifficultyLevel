import 'package:flutter/cupertino.dart';
import 'package:flutter_project/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
    Task('Ride Bike', 'assets/images/rideBike.jpg', 2),
    Task('Learn Flutter', 'assets/images/flutterMascot.png', 2),
    Task('Meditate', 'assets/images/meditate.jpg', 5),
    Task('Study', 'assets/images/study.jpg', 3),
    Task('Flying', 'assets/images/plane.webp', 4),
    Task('Read', 'assets/images/read.webp', 1),
  ];

  void newTask(String name, String image, int difficulty) {
    taskList.add(Task(name, image, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited old) {
    return old.taskList.length != old.taskList.length;
  }
}
