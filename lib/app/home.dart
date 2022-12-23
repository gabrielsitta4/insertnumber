import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insertnumber/app/looknumber.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  var numberinsert = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var snakbar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Insira um numero inteiro:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 100, right: 100),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: numberinsert,
              ),
            ),
            ElevatedButton(
              child: const Text("Inserir valor"),
              onPressed: () => {
                sendData(),
                snakbar = const SnackBar(
                    content:
                        Text('Numero inserido, va para a proxima pagina!')),
                ScaffoldMessenger.of(context).showSnackBar(snakbar)
              },
            ),
            ElevatedButton(
              child: const Text("Olhar numero!"),
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LookPage())),
              },
            ),
          ],
        ),
      ),
    );
  }

  void sendData() {
    String id = const Uuid().v1();
    db.collection("numbers").doc(id).set({"number": numberinsert.text});
    numberinsert.clear();
  }
}
