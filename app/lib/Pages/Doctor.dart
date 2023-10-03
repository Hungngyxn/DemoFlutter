import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/Pages/Listdocs.dart';
class Doctor extends StatefulWidget {
  const Doctor({super.key});

  @override
  State<Doctor> createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  var db = FirebaseFirestore.instance;
  bool isLoaded = true;
  late List<Map<String, dynamic>> items=[] ;
  late List<List<dynamic>> bac=[];
  void getbook() async {
    List<Map<String, dynamic>> tempList =[];
    var data = await db.collection("Khoa").get();
    for (var element in data.docs) {
      tempList.add(element.data());
    }
    setState(() {
      items = tempList;
      isLoaded = true;
    });
    List<List<dynamic>> array=[];
    for(int i=0;i<items.length;i++){
      array.add(items[i]["Bác sĩ"]);
    }
    setState(() {
      bac=array;
    });
  }

  @override
  Widget build(BuildContext context) {
    getbook();
    return Scaffold(
      appBar: AppBar(
        title: const Text('abc'),
      ),
      body: Center(
          child: isLoaded?ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(1),
                  child: ListTile(
                    title:
                        Text(items[index]["Name"]??"Not given",),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  ListDocs(doc: bac[index], name: items[index]["Name"]),
                          ));
                    },),
                  );
              }
          ):const Text("Đang tải .... ")
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
