import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/data_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dataBox = Hive.box<DataModel>('data');

  @override
  void dispose() {
    Hive.box('data').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive DB"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: Colors.blueGrey[100],
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      decoration: const InputDecoration(hintText: "Title"),
                      controller: titleController,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration:
                          const InputDecoration(hintText: "Description"),
                      controller: descriptionController,
                    ),
                    const SizedBox(height: 8),
                    IconButton(
                      icon: const Icon(Icons.done),
                      onPressed: () {
                        final String title = titleController.text;
                        final String description = descriptionController.text;
                        titleController.clear();
                        descriptionController.clear();
                        DataModel data = DataModel(
                          title: title,
                          description: description,
                          complete: true,
                        );
                        dataBox.add(data);
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<DataModel>('data').listenable(),
        builder: (context, Box<DataModel> items, _) {
          List<int> keys = items.keys.cast<int>().toList();
          return ListView.separated(
            separatorBuilder: (_, index) => const Divider(),
            itemCount: keys.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              final int key = keys[index];
              final DataModel? data = items.get(key);
              return ListTile(
                title: Text(
                  data!.title ?? "",
                  style: const TextStyle(fontSize: 22, color: Colors.black),
                ),
                subtitle: Text(data.description ?? "",
                    style:
                        const TextStyle(fontSize: 20, color: Colors.black38)),
                leading: Text(
                  "$key",
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
