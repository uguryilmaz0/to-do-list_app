import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_app/data/entity/task-list.dart';

class TaskListScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(color: Colors.amber),
          
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF010013),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: 320,
            child: Column(children: [
              Expanded(
                child: TextField(
                  textCapitalization: TextCapitalization.words,
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Görev Adı'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  textCapitalization: TextCapitalization.words,
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Tanımı'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: startDateController,
                  decoration:
                      const InputDecoration(labelText: 'Başlangıç Tarihi'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: endDateController,
                  decoration: const InputDecoration(labelText: 'Bitiş Tarihi'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber)
              ),
              onPressed: () {
                var taskList = Provider.of<TaskList>(context, listen: false);
                taskList.addTask(Task(
                  name: nameController.text,
                  description: descriptionController.text,
                  startDate: startDateController.text,
                  endDate: endDateController.text,
                  
                ));
              },
              child: const Text('Görev Ekle',style: TextStyle(color: Colors.black),),
            ),
          ),
          
          const Divider(color: Colors.amber,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(
                "GÖREVLER",
                style: TextStyle(fontSize: 26, color: Colors.amber),
              ),
            ],
          ),
          const Divider(color: Colors.amber,),
          Expanded(
            child: Consumer<TaskList>(
              builder: (context, taskList, child) => ListView.builder(
                itemCount: taskList.tasks.length,
                itemBuilder: (context, index) {
                  var task = taskList.tasks[index];
                  return Dismissible(
                    key: Key(task.name),
                    onDismissed: (direction) {
                      taskList.removeTask(index);
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20.0),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Column(
                      children: [
                        const Divider(
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              task.name,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            subtitle: Text(
                              task.description,
                              style: const TextStyle(
                                  color: Colors.white54, fontSize: 18),
                            ),
                            trailing: Text(
                              'Start: ${task.startDate}\nEnd: ${task.endDate}',
                              style: const TextStyle(
                                  color: Colors.amberAccent, fontSize: 16),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF010013),
    );
  }
}
