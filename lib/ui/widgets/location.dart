import 'package:flutter/material.dart';

class Location extends StatelessWidget {
  const Location({Key? key, required this.location}) : super(key: key);

  final String location;

  @override
  Widget build(BuildContext context) {
    return Text(
      location,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
