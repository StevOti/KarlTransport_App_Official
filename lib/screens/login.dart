import 'package:flutter/material.dart';
import 'package:karltransportapp/data/auth_data.dart';
import 'package:karltransportapp/themes/colors.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  final VoidCallback show;
  const Login(this.show, {super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {setState(() {
      
    });
    });

    super.initState();
    _focusNode2.addListener(() {setState(() {
      
    });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              lottie(),
              const SizedBox(height: 50),
              textfield(email , _focusNode1, 'Email', Icons.email),
              const SizedBox(height: 10),
              textfield(password, _focusNode2, 'Password', Icons.password),
              const SizedBox(height: 10),
              sign_up(),
              const SizedBox(height: 50),
              login_button()
            ],
          ),
        ),
      ),
    );
  }

  Widget sign_up() {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: widget.show,
                    child: Text(
                      'Sign Up Here',
                      style: TextStyle(
                      color: custom_green,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            );
  }

  Widget login_button() {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GestureDetector(
                onTap: () {
                  AuthenticationRemote().login(email.text, password.text);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: custom_green,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            );
  }

  Widget textfield(TextEditingController controller, FocusNode focusNode, String typeName, IconData iconss) {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                    prefixIcon: Icon(iconss , color: focusNode.hasFocus? custom_green : Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15, 
                      vertical: 15
                    ),
                    hintText: 'typeName',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.white, width: 2.0
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: custom_green, width: 2.0
                    ),
                  ),
                ),
              ),
              )
            );
  }

  Widget lottie() {
    return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Lottie.asset(
                  'images/login.json',
                  fit: BoxFit.cover,
                ),
              ),
            );
  }
}