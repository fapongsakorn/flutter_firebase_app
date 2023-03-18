import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/services/item_service.dart';

class Edit_Item extends StatefulWidget {
  const Edit_Item(
      {super.key,
      required this.name,
      required this.description,
      required this.docId});
  final String name;
  final String description;
  final String docId;

  @override
  State<Edit_Item> createState() => _Edit_ItemState();
}

class _Edit_ItemState extends State<Edit_Item> {
  final editName = TextEditingController();
  final editDescription = TextEditingController();

  final _service = ItemService();
  @override
  Widget build(BuildContext context) {
    editName.text = widget.name;
    editDescription.text = widget.description;
    final documentId = widget.docId;
    // print(documentId);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Page"),
      ),
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
                      controller: editName,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        label: Text("Item Description"),
                      ),
                      controller: editDescription,
                    ),
                    const Padding(padding: EdgeInsets.all(50)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ElevatedButton.icon(
                            onPressed: () {
                              _save(context, docID: documentId);
                            },
                            icon: const Icon(Icons.save_rounded),
                            label: const Text("Save")),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton.icon(
                            onPressed: () {
                              _delete(context, docID: documentId);
                            },
                            icon: const Icon(Icons.delete_outline_outlined),
                            label: const Text("Delete")),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save(BuildContext context, {required docID}) {
    // print(docID);
    if (editName.text == "" || editDescription.text == "") {
      print("cannot change item($editName, $editDescription)");
    } else {
      _service.SaveItem(
              context,
              {"name": editName.text, "description": editDescription.text},
              docID)
          .then((value) => Navigator.pop(context));
      editDescription.text = "";
      editName.text = "";
    }
  }

  void _delete(BuildContext context, {required docID}) {
    if (editName.text == "" || editDescription.text == "") {
      print("cannot delete item($editName)");
    } else {
      _service.DeleteItem(
              context,
              {"name": editName.text, "description": editDescription.text},
              docID)
          .then((value) => Navigator.pop(context));
      editDescription.text = "";
      editName.text = "";
    }
  }
}
