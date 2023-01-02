import 'package:flutter/material.dart';
import 'package:flutter_project/components/task.dart';
import 'package:flutter_project/data/task_dao.dart';

const String _newTaskTitle = 'New Task';

class FormScreen extends StatefulWidget {
  FormScreen({Key? key, required this.taskContext}) : super(key: key);

  final BuildContext taskContext;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  TextEditingController _difficultyController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _valueValidator(String? value) {
    return value != null && value.isEmpty;
  }

  bool _difficultyValidator(String? value) {
    return value!.isEmpty || int.parse(value) < 1 || int.parse(value) > 5;
  }

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_newTaskTitle),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: 500,
            width: 345,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 3),
            ),
            child: Form(
              key: widget._formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      validator: (String? value) {
                        if (widget._valueValidator(value)) {
                          return 'Enter task name';
                        }
                        return null;
                      },
                      controller: widget._nameController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Name',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      validator: (value) {
                        if (widget._difficultyValidator(value)) {
                          return 'Insert a Difficulty between 1 and 5';
                        }
                        return null;
                      },
                      controller: widget._difficultyController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Difficulty',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      onChanged: (text) {
                        setState(() {});
                      },
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Insert an Image URL';
                        }
                        return null;
                      },
                      controller: widget._imageController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Image',
                        fillColor: Colors.white70,
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 72,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Colors.blue),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget._imageController.text,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset('assets/images/no_image_icon.png');
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (widget._formKey.currentState!.validate()) {
                        TaskDao().save(Task(
                          widget._nameController.text,
                          widget._imageController.text,
                          int.parse(widget._difficultyController.text),
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Creating New Task')));
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Add!'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
