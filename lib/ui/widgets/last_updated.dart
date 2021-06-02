import 'package:flutter/material.dart';

class LastUpdated extends StatelessWidget {
  const LastUpdated({Key? key, required this.dateTime}) : super(key: key);

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Updated: ${TimeOfDay.fromDateTime(dateTime).format(context)}',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w200,
        color: Colors.white,
      ),
    );
  }
}
