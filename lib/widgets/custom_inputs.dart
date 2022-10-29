import 'package:flutter/material.dart';
import 'package:marketplace/utils/colors.dart';

class CustomInputs {
  static InputDecoration loginInputDecoration(
      {required String hint,
      IconData? icon,
      bool isPrefixIcon = true,
      bool borderside = false,
      double borderRadius = 10,
      Color fillcolor = grey}) {
    return InputDecoration(
      filled: true,
      fillColor: fillcolor,
      border: OutlineInputBorder(
          borderSide: borderside ? BorderSide(color: grey) : BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius)),
      enabledBorder: OutlineInputBorder(
          borderSide: borderside ? BorderSide(color: grey) : BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius)),
      hintText: hint,
      prefixIcon: isPrefixIcon ? Icon(icon) : null,
      labelStyle: TextStyle(color: black),
      hintStyle: TextStyle(color: black.withOpacity(0.5)),
    );
  }

  static InputDecoration dropdownDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: grey),
          borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: grey),
          borderRadius: BorderRadius.circular(10)),
      hintText: 'categoria',
      labelStyle: TextStyle(color: black),
      hintStyle: TextStyle(color: black.withOpacity(0.5)),
    );
  }
}
