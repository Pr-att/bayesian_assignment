import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/api.dart';
import '../main.dart';

class AddComment with ChangeNotifier {
  final List<Widget> kTask = [
    SearchBar(
      side: MaterialStateProperty.all(
        const BorderSide(
          color: Colors.black26,
        ),
      ),
      elevation: MaterialStateProperty.all(0),
      leading: const Padding(
        padding: EdgeInsets.all(10),
        child: Icon(Icons.search),
      ),
      hintText: 'Search',
    ),
    Builder(builder: (BuildContext context) {
      return AddTile(
        context: context,
        controller: TextEditingController(),
        kTask: AddComment().kTask,
      );
    }),
  ];

  getTaskList() {
    return kTask;
  }

  getTaskListLength() {
    return kTask.length;
  }

  add(Widget task) {
    kTask.add(task);
    notifyListeners();
  }

  addAtIndex(Widget task) {
    kTask.insert(1, task);
    notifyListeners();
  }
}

class AddTile extends StatelessWidget {
  final BuildContext context;
  final TextEditingController controller;
  final List<Widget> kTask;
  const AddTile(
      {super.key,
      required this.context,
      required this.controller,
      required this.kTask});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListTile(
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.black26,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        leading: CircleAvatar(
          backgroundImage: Image.network(
            'https://www.google.com/s2/favicons?sz=64&domain_url=yahoo.com',
            fit: BoxFit.contain,
          ).image,
        ),
        title: Text(
            'This is the ${Provider.of<AddComment>(context, listen: false).kTask.length - 1} comment.'),
        trailing: GestureDetector(
          child: const Icon(Icons.add),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                backgroundColor: Colors.white,
                title: const Text(
                  'Type Below',
                  style: TextStyle(fontSize: 20),
                ),
                content: TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Type Here',
                  ),
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                    onPressed: () async {
                      var data = await Api().post(
                        Provider.of<AddComment>(context, listen: false)
                            .getTaskListLength(),
                        controller.text,
                        'https://www.google.com/s2/favicons?sz=64&domain_url=yahoo.com',
                        "https://via.placeholder.com/150/771796",
                      );
                      Navigator.of(context).pop();
                      controller.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          margin: const EdgeInsets.all(10),
                          content: const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'New Comment was added!',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              Icon(
                                Icons.check_circle_outline,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          backgroundColor: const Color(0xffe2e3f7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          behavior: SnackBarBehavior.floating,
                          elevation: 0,
                        ),
                      );
                      Provider.of<AddComment>(context, listen: false)
                          .addAtIndex(
                        NewComment(comment: data['title']),
                      );
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
