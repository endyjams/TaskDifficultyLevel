import 'package:flutter/material.dart';
import 'package:flutter_project/components/task.dart';
import 'package:flutter_project/data/task_dao.dart';
import 'package:flutter_project/screens/form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.task_alt_rounded),
        leadingWidth: 100,
        elevation: 15,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(onPressed: () {
            setState(() {});
          }, icon: const Icon(Icons.refresh,))
        ],
        title: const Text('Tasks Rating'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
            future: TaskDao().findAll(),
            builder: (context, snapshot) {
              List<Task>? tasks = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: Column(
                      children: const [CircularProgressIndicator(), Text('Loading')],
                    ),
                  );
                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      children: const [CircularProgressIndicator(), Text('Loading')],
                    ),
                  );
                case ConnectionState.active:
                  return Center(
                    child: Column(
                      children: const [CircularProgressIndicator(), Text('Loading')],
                    ),
                  );
                case ConnectionState.done:
                  if (snapshot.hasData && tasks != null) {
                    if (tasks.isNotEmpty) {
                      return ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Task task = tasks[index];
                            return task;
                          });
                    }
                    return Center(
                      child: Column(
                        children: const [
                          Icon(Icons.error_outline, size: 128),
                          Text(
                            'No Tasks Found',
                            style: TextStyle(fontSize: 32),
                          )
                        ],
                      ),
                    );
                  }
                  return const Text(' Error while loading Tasks ');
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (newContext) =>
                  FormScreen(
                    taskContext: context,
                  ),
            ),
          ).then((value) =>
              setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
