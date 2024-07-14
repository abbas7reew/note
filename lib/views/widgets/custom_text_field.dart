import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubits/mode_cubit/mode_cubit.dart';

class CustomFormTextField extends StatelessWidget {
  CustomFormTextField({ this.controller,this.hintText, this.onChanged , this.obscureText =false,  this.icon});
  TextEditingController? controller;
  Function(String)? onChanged;
  String? hintText;
  Widget? icon;

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
        fillColor: BlocProvider
            .of<ModeCubit>(context)
            .isLight ? Colors.white : Colors.black,
        prefixIcon:icon,
        filled: true,
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
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder:OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
