import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListDocs extends StatefulWidget {
  final String name;
  final List doc;
  const ListDocs({super.key, required this.name, required this.doc});

  @override
  State<ListDocs> createState() => _ListDocsState();
}

class _ListDocsState extends State<ListDocs> {
  final TextEditingController dateInputController = TextEditingController();
  late List<String> list = [];
  String? _selectedRole;
  String? _selectedRole1;
  void DynamictoString() {
    List<String> list1 = [];
    for (int i = 0; i < widget.doc.length; i++) {
      list1.add(widget.doc[i]);
    }
    setState(() {
      list = list1;
    });
  }

  List<String> time = [
    '8:30 - 9:00',
    '9:30 - 10:00',
    '10:30 - 11:00',
    '13:30 - 14:00',
    '14:30 - 15:00',
    '15:30 - 16:00',
    '16:30 - 17:00'
  ];
  void _handleDropdownChange(String? newValue) {
    setState(() {
      _selectedRole = newValue ?? 'Trống';
    });
  }

  void _handleDropdownChange1(String? newValue) {
    setState(() {
      _selectedRole1 = newValue ?? 'Trống';
    });
  }

  filldata() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? name;
    String? uid = auth.currentUser?.uid;
    DatabaseReference ref = FirebaseDatabase.instance.ref("User/$uid");
    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        if (data.containsKey("name")) {
          setState(() {
            name = data["name"];
          });
        }
      }
    });
    DatabaseReference ref1 =
        FirebaseDatabase.instance.ref("User/$uid/Lichkham/${widget.name}");
    await ref1.update({
      "Bac si": _selectedRole,
      "Ngay": dateInputController.text,
      "Gio": _selectedRole1,
    });
    DatabaseReference reference = FirebaseDatabase.instance
        .ref("Khoa/${widget.name}/$_selectedRole1/$_selectedRole");
    await reference.set({
      "Ngay": dateInputController.text,
      "Bac si": _selectedRole,
      "Uid": uid,
      "Name": name,
    });
    Navigator.pushNamed(context, 'Home_Page');
  }

  @override
  Widget build(BuildContext context) {
    DynamictoString();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              Container(
                width: 500,
                padding: const EdgeInsets.only(right: 50),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      value: _selectedRole,
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: _handleDropdownChange,
                    ),
                  ),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Ngày khám', prefixIcon: Icon(Icons.date_range)),
                controller: dateInputController,
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2050));

                  if (pickedDate != null) {
                    dateInputController.text =
                        DateFormat('dd/MM/yyyy').format(pickedDate);
                  }
                },
              ),
              Container(
                width: 500,
                padding: const EdgeInsets.only(right: 50),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                        value: _selectedRole1,
                        items:
                            time.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: _handleDropdownChange1),
                  ),
                ),
              ),
              ElevatedButton(onPressed: filldata, child: const Text('Đặt lịch'))
            ])));
  }
}
