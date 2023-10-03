
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/Pages/Add_infor.dart';
import 'package:quickalert/quickalert.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();

  String _selectedRole = 'FPTSite3';

  signInWithEmailAndPassword() async{
      String username = _usernameController.text;//abc@gmail.com
      String password = _passwordController.text;
      String confirmpassword = _confirmpasswordController.text;//abc123
      if(username.isEmpty&&password.isEmpty){
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Email and Password is empty',
        );
      }
      else if(username.isEmpty){
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Email is empty',
        );
      }
      else if(password.isEmpty){
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Password is empty',
        );
      }
      else if(password!=confirmpassword){
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Password is not correct',
        );
      }
      else{
        FirebaseAuth.instance.createUserWithEmailAndPassword(email: username, password: password);
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Success',
        );
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AddInfor()),(Route<dynamic> route) => false,
        );

      }

  }
  void _handleDropdownChange(String? newValue) {
    setState(() {
      _selectedRole = newValue ?? 'FPTSite3';
    });
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
            Align(
              alignment: Alignment.topRight, // Đặt dropdown menu ở góc phải
              child: DropdownButton<String>(
                value: _selectedRole,
                onChanged: _handleDropdownChange,
                items: <String>['FPTSite3', 'FPTSite4','site5']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),

            TextField(

              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.password),
              ),
              obscureText: true,
            ),
            TextField(

              controller: _confirmpasswordController,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: Icon(Icons.password),
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed:signInWithEmailAndPassword,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

