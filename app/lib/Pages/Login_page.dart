import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Pages/Register_page.dart';
import 'package:quickalert/quickalert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController dateInputController = TextEditingController();
  String _selectedRole = 'FPTSite3';

  signInWithEmailAndPassword() async{
    try{
      final user= await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text,
      );
      if(user !=null) {
        Navigator.pushNamed(context, 'Home_Page');
        _usernameController.text='';
        _passwordController.text='';
      }
    } on FirebaseAuthException catch (e){
      _handleLogin();
      if(e.code == "user-not-found"){
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'User not found with this email',
        );
      } else if(e.code == 'wrong-password'){
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'Wrong password with this email',
        );
      }
    }
  }

  void _handleLogin() {
    String username = _usernameController.text;//abc@gmail.com
    String password = _passwordController.text;//abc123

    if(username==null&&password==null || username.isEmpty&&password.isEmpty){
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
        title: const Text('Login'),
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
            const SizedBox(height: 16.0),
            TextField(

              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.password),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: signInWithEmailAndPassword,
              child: const Text('Login',style: TextStyle(fontSize: 20),),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text('Register',style: TextStyle(fontSize: 20),),
            ),
          ],
        ),
      ),
    );
  }
}

