import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final double width;
  final double height;

  const CustomAvatar({this.width = 50, this.height = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: width,
      height: height,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3aDHlzgAfDG4_gGi4P2MKfwY-dqaqLwH-kPuyfU240-BZd32D5NsX_NSbdj6l1gg0OQU&usqp=CAU'),
          )),
    );
  }
}
