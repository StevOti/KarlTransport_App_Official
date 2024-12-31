import 'package:flutter/material.dart';
import 'package:karltransportapp/screens/login.dart';
import 'package:karltransportapp/screens/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool a = true;
  void to() {
    setState(() {
      a = !a;
    });
  }

  @override
  Widget build(BuildContext context) { 
    if(a) {
      return Login(to);
    } else {
      return Signup(to);
    }
   }
}