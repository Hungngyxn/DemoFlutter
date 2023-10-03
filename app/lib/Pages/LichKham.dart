import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LichKham extends StatefulWidget {
  LichKham({super.key, required this.name});
  String name;
  @override
  State<LichKham> createState() => _LichKhamState();
}

class _LichKhamState extends State<LichKham> {
  String? bacsi,gio,ngay;
  void getdata() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? uid = auth.currentUser?.uid;
    DatabaseReference ref = FirebaseDatabase.instance.ref('User/$uid/Lichkham/${widget.name}');
    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        if (data.containsKey("Bac si")) {
          setState(() {
            bacsi = data["Bac si"];
            gio = data["Gio"];
            ngay = data["Ngay"].toString();
          });
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    getdata();
    return  Scaffold(
        appBar: AppBar(
          title: const Text("Lịch khám bệnh "),
        ),
        body:Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 100,),
              Text("Ngày khám: $ngay",style: const TextStyle(fontSize: 20),),
              const SizedBox(height: 30,),
              Text("Bác sĩ phụ trách: $bacsi",style: const TextStyle(fontSize: 20),),
              const SizedBox(height: 30,),
              Text("Giờ: $gio",style: const TextStyle(fontSize: 20),),
              const SizedBox(height: 30,),
              const Center(
                child: ElevatedButton(onPressed: null, child: Text("okay")),
              )
            ],
          ),)
    );
  }
}
