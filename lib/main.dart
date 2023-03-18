
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_app/firebase_options.dart';
import 'package:flutter_firebase_app/screen/add_item.dart';
import 'package:flutter_firebase_app/screen/edit_item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Flutter Firebase CRUD'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("item").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final itemSnapshot = snapshot.data?.docs;
          if (itemSnapshot!.isEmpty) {
            return Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "0 Data",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Padding(padding: EdgeInsets.all(20)),
                    Image.network(
                        "https://www.freepnglogos.com/uploads/robot-png/sad-robot-icons-sad-robot-icon-download-iconhotm-0.png")
                  ],
                ),
              ),
            );
          }
          return ListView.builder(
              itemCount: itemSnapshot.length,
              itemBuilder: (context, index) {
                // print(itemSnapshot[index].id);
                return GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Edit_Item(
                            description: itemSnapshot[index]["description"],
                            name: itemSnapshot[index]["name"],
                            docId: itemSnapshot[index].id),
                      ),
                    ),
                  },
                  child: ListTile(
                    title: Text(itemSnapshot[index]["name"]),
                    subtitle: Text(itemSnapshot[index]["description"]),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddItem()));
        },
        tooltip: 'New items',
        child: const Icon(Icons.add),
      ),
    );
  }
}