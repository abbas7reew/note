import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({ this.controller,this.hintText, this.onChanged , this.obscureText =false});
  TextEditingController? controller;
  Function(String)? onChanged;
  String? hintText;


  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obscureText!,
        keyboardType: TextInputType.emailAddress,
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
