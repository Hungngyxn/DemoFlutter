import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

String? name,phone,address,date;
class UserInfor extends StatefulWidget {
  const UserInfor({super.key});
  @override
  _UserInforState createState() => _UserInforState();
}

class _UserInforState extends State<UserInfor> {
  @override
  Widget build(BuildContext context) {
    getdata();
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin cá nhân"),
      ),
      body:Padding( 
        padding: EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 100,),
          Text("Họ tên: $name",style: const TextStyle(fontSize: 20),),
          const SizedBox(height: 30,),
          Text("Số điện thoại: $phone",style: const TextStyle(fontSize: 20),),
          const SizedBox(height: 30,),
          Text("Địa chỉ: $address",style: const TextStyle(fontSize: 20),),
          const SizedBox(height: 30,),
          Text("Ngày sinh: $date",style: const TextStyle(fontSize: 20),),
          const SizedBox(height: 30,),
          const Center(
            child: ElevatedButton(onPressed: null, child: Text("  aaaa    ")),
          )
        ],
      ),)
    );
  }
  void getdata() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String? uid = auth.currentUser?.uid;
    DatabaseReference ref = FirebaseDatabase.instance.ref('User/$uid');
    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        // Kiểm tra xem dữ liệu có tồn tại và có đúng định dạng không
        if (data.containsKey("name")) {
          setState(() {
            name = data["name"];
            phone = data["phone"];
            address = data["address"];
            date = data["Chua"].toString();
          });
        } else {
          print("Không tìm thấy giá trị 'name' trong dữ liệu.");
        }
      } else {
        print("Dữ liệu không hợp lệ hoặc không tồn tại.");
      }
    });
  }
}
