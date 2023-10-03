import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Pages/Home_page.dart';
import 'package:intl/intl.dart';
class AddInfor extends StatefulWidget {
  const AddInfor({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddInfor createState() => _AddInfor();
}

class _AddInfor extends State<AddInfor> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController dateInputController = TextEditingController();

  adduser() async{
    String name = _nameController.text;
    String date = dateInputController.text;
    String address = _addressController.text;
    String phone = _phoneController.text;
    FirebaseAuth auth = FirebaseAuth.instance;
    String? uid = auth.currentUser?.uid;
    DatabaseReference ref = FirebaseDatabase.instance.ref("User/$uid");
    ref.set(
    {
      "name": name,
      "Chua": date,
      "address": address,
      "phone": phone,
      "Lichkham":'',
    });
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),(Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Họ tên',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Ngày sinh',
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
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Địa chỉ',
                prefixIcon: Icon(Icons.person),
              ),
            ),

            TextField(

              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Số điện thoại',
                prefixIcon: Icon(Icons.password),
              ),
            ),
            ElevatedButton(
              onPressed:adduser,
              child: const Text('Xác nhận'),
            ),
          ],
        ),
      ),
    );
  }
}

