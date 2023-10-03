import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Pages/Add_infor.dart';
import 'package:myapp/Pages/Doctor.dart';
import 'package:myapp/Pages/Register_page.dart';
import 'package:myapp/Pages/AppInfor.dart';
import 'Pages/Home_page.dart';
import 'Pages/Login_page.dart';
import 'Pages/DanhsachKham.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LoginFormApp());
}

class LoginFormApp extends StatelessWidget {
  const LoginFormApp({super.key});
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return MaterialApp(initialRoute: 'Home_Page', routes: {
        'Login_Page': (context) => const LoginPage(),
        'Home_Page': (context) => const HomePage(),
        'Register_Page': (context) => const RegisterPage(),
        'Add_infor': (context) => const AddInfor(),
        'book': (context) => const Doctor(),
        'Lich': (context) => const TUTU(),
        'Thongtin': (context) => const Thongtin(),
      });
    } else {
      return MaterialApp(initialRoute: 'Login_Page', routes: {
        'Login_Page': (context) => const LoginPage(),
        'Home_Page': (context) => const HomePage(),
        'Register_Page': (context) => const RegisterPage(),
        'Add_infor': (context) => const AddInfor(),
        'book': (context) => const Doctor(),
        'Lich': (context) => const TUTU(),
      });
    }
  }
}
