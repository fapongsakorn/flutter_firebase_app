import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/services/item_service.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final itemNameController = TextEditingController();
  final itemDescriptionController = TextEditingController();

  // call service method
  final ItemService _service = ItemService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: const InputDecoration(
                        label: Text("Item Name"),
                      ),
                      controller: itemNameController,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        label: Text("Item Description"),
                      ),
                      controller: itemDescriptionController,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (itemNameController.text == "" ||
                            itemNameController.text == "") {
                          showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  title: Text(
                                      "Name and Description not null after adding"),
                                  content: Text(
                                      "Please fill the name and description"),
                                );
                              });
                        } else {
                          _service.addItem(
                              context,
                              {
                                "name": itemNameController.text,
                                "description": itemDescriptionController.text,
                              },
                              itemNameController.text);
                          itemDescriptionController.text = "";
                          itemNameController.text = "";
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Create New item"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar bar() => AppBar(
        title: const Text("Add Item"),
      );
}
