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
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 600, // Maximum width for larger screens
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 15 : size.width * 0.05,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Responsive Lottie animation
                    SizedBox(
                      height: isSmallScreen ? size.height * 0.2 : 200,
                      child: Lottie.asset(
                        'images/login.json',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    
                    // Form fields
                    textfield(email, _focusNode1, 'Email', Icons.email),
                    const SizedBox(height: 16),
                    textfield(password, _focusNode2, 'Password', Icons.password),
                    const SizedBox(height: 16),
                    
                    // Sign up text
                    sign_up(),
                    SizedBox(height: size.height * 0.05),
                    
                    // Login button
                    login_button(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget sign_up() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'Don\'t have an account?',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.bold,
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
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget login_button() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          AuthenticationRemote().login(email.text, password.text);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: custom_green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget textfield(TextEditingController controller, FocusNode focusNode, String typeName, IconData iconss) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      style: const TextStyle(fontSize: 16, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(
          iconss,
          color: focusNode.hasFocus ? custom_green : Colors.grey,
        ),
        hintText: typeName,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: custom_green,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}