import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

class LookPage extends StatefulWidget {
  const LookPage({super.key});

  @override
  State<LookPage> createState() => _LookPageState();
}

class _LookPageState extends State<LookPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    show();
    super.initState();
  }

  List<String> listNumbers = [];
  late String _value = listNumbers.last;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Numeros anteriores"),
            SizedBox(
              height: 50,
              width: 60,
              child: DropdownButtonFormField(
                value: _value,
                items: listNumbers.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _value = val as String;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            (listNumbers.isEmpty)
                ? const Text("Nenhum numero registrado")
                : Text(
                    _value,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 100,
                    ),
                  ),
            Text(
              NumberToWordsEnglish.convert(
                int.parse(_value),
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('RETORNAR'),
            ),
          ],
        ),
      ),
    );
  }

  void show() async {
    QuerySnapshot query = await db.collection("numbers").get();

    listNumbers = [];

    for (var doc in query.docs) {
      String number = doc.get("number");
      setState(() {
        listNumbers.add(number);
        print(number);
      });
    }
  }
}
