import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'input_section.dart';
import 'task_widget.dart';
import 'task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Task>> futureTasks;

  @override
  void initState() {
    super.initState();
    futureTasks = getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "TODO",
        home: Scaffold(
          backgroundColor: const Color(0xFFEBEBEB),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
            child: Stack(
              children: <Widget>[
                Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Your tasks',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: FutureBuilder<List<Task>>(
                        future: futureTasks,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Task> data = snapshot.requireData;
                            return ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return TaskWidget(
                                    text: data[index].title,
                                    id: data[index].id,
                                    onPressed: () {
                                      deleteTask(data[index].id);
                                    },
                                  );
                                });
                          }

                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                  ],
                ),
                InputSection(
                  onAddClicked: ((taskText) => addTask(taskText)),
                ),
              ],
            ),
          ),
        ));
  }

  Future<List<Task>> getTasks() async {
    final response = await http.get(
        Uri.parse('http://62766064bc9e46be1a160ec4.mockapi.io/api/v1/tasks'));

    if (response.statusCode != 200) {
      throw Exception('Couldn\'t get tasks');
    }

    var tasksJson = jsonDecode(response.body) as List;
    return tasksJson.map((taskJson) => Task.fromJson(taskJson)).toList();
  }

  void deleteTask(String id) async {
    final response = await http.delete(Uri.parse(
        'http://62766064bc9e46be1a160ec4.mockapi.io/api/v1/tasks/$id'));

    if (response.statusCode != 200) {
      return;
    }

    setState(() {
      futureTasks.then((value) => value.removeWhere((item) => item.id == id));
    });
  }

  void addTask(String taskText) async {
    final response = await http.post(
      Uri.parse('http://62766064bc9e46be1a160ec4.mockapi.io/api/v1/tasks'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'task': taskText,
      }),
    );

    if (response.statusCode != 201) {
      return;
    }

    setState(() {
      futureTasks = getTasks();
    });
  }
}
