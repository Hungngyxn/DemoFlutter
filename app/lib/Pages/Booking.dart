import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final TextEditingController dateInputController = TextEditingController();
  String? _selectedRole;
  String? _selectedRole1;
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


  var db = FirebaseFirestore.instance;
  late List<Map<String, dynamic>> items ;
  late List<Map<String, dynamic>> items1 ;
  late List<String> khoa=[];
  late List<String> bac=[];
  late int index;
  void getbook() async {
    List<Map<String, dynamic>> tempList =[];
    var data = await db.collection("Khoa").get();
    for (var element in data.docs) {
      tempList.add(element.data());
    }
    setState(() {
      items = tempList;
    });
    List<String> array=[];
    for(int i=0;i<items.length;i++){
      array.add(items[i]["Name"]);
    }
    setState(() {
      khoa=array;
    });
  }

  @override
  Widget build(BuildContext context) {
    getbook();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Đặt lịch'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: 500,
              padding: EdgeInsets.only(right: 50),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    value: _selectedRole,
                    items: khoa
                          .map<DropdownMenuItem<String>>((String value) {
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
            Container(
              width: 500,
              padding: EdgeInsets.only(right: 50),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    value: _selectedRole1,
                    items: khoa
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: _handleDropdownChange1,
                  ),
                ),
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Ngày khám',
                  prefixIcon: Icon(Icons.date_range)
              ),
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
          ],
        ),

      ),
    );
  }
}
