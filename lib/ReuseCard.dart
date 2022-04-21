import 'package:flutter/material.dart';

class ReuseCard extends StatefulWidget {
  String title;
  String value;
  ReuseCard ({Key? key ,required this.title, required this.value}) : super(key: key);

  @override
  _ReuseCardState createState() => _ReuseCardState();
}

class _ReuseCardState extends State<ReuseCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(widget.title),
          Text(widget.value)
        ],
      ),
    );
  }
}
