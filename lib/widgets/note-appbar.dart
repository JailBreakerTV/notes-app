import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;

  NoteAppBar(
    this.title, {
    Key key,
  })  : this.preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 0.0),
            colors: [
              const Color.fromRGBO(15, 245, 157, 1),
              const Color.fromRGBO(10, 207, 131, 1)
            ],
          ),
        ),
      ),
      title: Text(
        this.title,
        style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.black, blurRadius: 0.5)]),
      ),
    );
  }
}
