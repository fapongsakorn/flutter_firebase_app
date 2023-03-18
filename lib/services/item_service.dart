import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';

class ItemService {
  Future<void> addItem(
      BuildContext context, Map<String, String> data, String docid) {
    print(data["id"]);
    return FirebaseFirestore.instance
        .collection('item')
        .doc()
        .set(data)
        .then((value) => {
              showMessageBox(
                context,
                "success",
                "Added item to firestore",
              )
            });
  }

  Future<void> SaveItem(
      BuildContext context, Map<String, String> data, String docid) {
    return FirebaseFirestore.instance
        .collection('item')
        .doc(docid)
        .update(data)
        .then((value) => {
              showMessageBox(
                context,
                "success",
                "Save item($docid) to firestore",
              )
            })
        .catchError((error) => {error.toString()});
  }

  Future<void> DeleteItem(
      BuildContext context, Map<String, String> data, String docid) {
    return FirebaseFirestore.instance
        .collection('item')
        .doc(docid)
        .delete()
        .then((value) => {
              showMessageBox(
                context,
                "success",
                "Delete item($docid)",
              )
            });
  }

  showMessageBox(BuildContext context, String s, String t) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(s),
        content: Text(t),
      ),
    );
  }
}
