import 'package:flutter/material.dart';
import 'package:marketplace/utils/colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isFilled, loading;
  final Color color, textColor, loadingColor;

  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = secondary,
    this.isFilled = false,
    this.loading = false,
    this.textColor = primary,
    this.loadingColor = primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          side: MaterialStateProperty.all(BorderSide(color: color)),
          backgroundColor:
              MaterialStateProperty.all(isFilled ? color : Colors.transparent),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
          child: loading
              ? Container(
                  height: 20, width: 20, child: CircularProgressIndicator())
              : Text(text, style: TextStyle(fontSize: 16, color: textColor)),
        ));
  }
}
