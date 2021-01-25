import 'package:flutter/material.dart';
import 'package:movify/style/styles.dart';

class FormInput extends StatelessWidget {

  final String hintText;
  final Widget prefixIcon;
  final TextInputType keyboardType;
  TextEditingController controller;
  final bool obscureText;

  FormInput({this.hintText, this.prefixIcon, this.keyboardType, this.controller,this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        style: kFormInputText,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: kHintText,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}
