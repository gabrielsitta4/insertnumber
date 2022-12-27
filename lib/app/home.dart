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
  void initState() {
    show();
    super.initState();
  }

  List<String> ids = [];

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
                decoration: const InputDecoration(
                  icon: Icon(Icons.numbers),
                  hintText: "Digite o valor aqui",
                ),
                keyboardType: TextInputType.number,
                controller: numberinsert,
              ),
            ),
            ElevatedButton(
              child: const Text("Inserir valor"),
              onPressed: () => {
                sendData(),
              },
            ),
            ElevatedButton(
              child: const Text("OLHAR NUMERO"),
              onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LookPage())),
              },
            ),
            ElevatedButton(
              child: const Text("Teste"),
              onPressed: () => {show()},
            ),
          ],
        ),
      ),
    );
  }

  Future show() async {
    await FirebaseFirestore.instance
        .collection("numbers")
        .get()
        .then((value) => value.docs.forEach((element) {
              ids.add(element.reference.id);
              print(ids.last);
            }));
  }

  void sendData() {
    if (numberinsert.text.isEmpty) {
      message('Nao foi possivel inserir');
    } else {
      // String id = const Uuid().v1();
      show();
      int idd = int.parse(ids.last) + 1;
      String iddd = idd.toString();
      message('Valor inserido');
      db.collection("numbers").doc(iddd).set({"number": numberinsert.text});
    }
    numberinsert.clear();
  }

  void message(String message) {
    snakbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snakbar);
  }
}
