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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // (listNumbers.isEmpty)
            //     ? const Text("Nenhum numero registrado")
            //     : Column(
            //         children: [
            //           for (String s in listNumbers) Text(s),
            //         ],
            //       ),

            (listNumbers.isEmpty)
                ? const Text("Nenhum numero registrado")
                : Text(
                    listNumbers.last,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 100,
                    ),
                  ),
            Text(
              NumberToWordsEnglish.convert(
                int.parse(listNumbers.last),
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

  Future show() async {
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
