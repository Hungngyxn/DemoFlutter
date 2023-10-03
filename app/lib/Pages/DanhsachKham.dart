import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Pages/LichKham.dart';
class TUTU extends StatefulWidget {
  const TUTU({super.key});

  @override
  State<TUTU> createState() => _TUTUState();
}

class _TUTUState extends State<TUTU> {
  List<String> items=[];
  void getdata() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? uid = auth.currentUser?.uid;
    DatabaseReference ref = FirebaseDatabase.instance.ref('User/$uid/Lichkham');
    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        List<String> kaka= [];
        for(var i in data.keys.toList()){
          kaka.add(i);}
        setState(() {
          items=kaka;
          }
        );
      }
    }
    );}

  @override
  Widget build(BuildContext context) {
    getdata();
    return Scaffold(
      appBar: AppBar(
        title: const Text('abc'),
      ),
      body: Center(
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(1),
                  child: ListTile(
                    title:
                    Text(items[index]),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  LichKham(name: items[index]),
                          ));
                    },),
                );
              }
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
