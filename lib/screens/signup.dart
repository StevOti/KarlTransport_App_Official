import 'package:flutter/material.dart';
import 'package:karltransportapp/data/auth_data.dart';
import 'package:karltransportapp/themes/colors.dart';
import 'package:lottie/lottie.dart';

class Signup extends StatefulWidget {
  final VoidCallback show;
  const Signup(this.show, {super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
    _focusNode3.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    email.dispose();
    password.dispose();
    passwordConfirm.dispose();
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
                      height: isSmallScreen ? size.height * 0.25 : 250,
                      child: Lottie.asset(
                        'images/signup.json',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    
                    // Form fields
                    textfield(email, _focusNode1, 'Email', Icons.email),
                    const SizedBox(height: 16),
                    textfield(password, _focusNode2, 'Password', Icons.password),
                    const SizedBox(height: 16),
                    textfield(passwordConfirm, _focusNode3, 'Confirm Password', Icons.password),
                    const SizedBox(height: 16),
                    
                    // Sign in text
                    sign_in(),
                    SizedBox(height: size.height * 0.03),
                    
                    // Sign up button
                    signup_button(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget sign_in() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'Have an account?',
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
            'Login Here',
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

  Widget signup_button() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          AuthenticationRemote().register(
            email.text,
            password.text,
            passwordConfirm.text,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: custom_green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          'Sign Up',
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
      obscureText: typeName.toLowerCase().contains('password'),
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