import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final String title;
  final Widget? widget;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.focusNode,
    required this.title,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
           padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87, // Customize the color as needed
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Add padding to the left and right of the Text Field Container
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16), // Left and right padding
            child: Container(
              padding: const EdgeInsets.only(left: 14),
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  // Expanded TextField
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      cursorColor: Colors.grey[700],
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none, // Remove default border
                      ),
                    ),
                  ),

                  // Optional Widget (icon, button, etc.)
                  widget ?? Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
