import 'package:Notes/note.dart';
import 'package:Notes/routes/note-view-route.dart';
import 'package:Notes/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  final Note note;

  NoteWidget(this.note);

  @override
  Widget build(BuildContext context) {
    final double width = double.infinity;
    final double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => {Utils.pushWidget(context, NoteViewRoute.create(this.note))},
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Card(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0.3,
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: width,
                      height: (height / 2) * 0.5,
                      child: Container(
                        child: Center(
                          child: ListTile(
                            title: Text(
                              _cutNoteTopic(this.note),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 35,
                                color: Colors.white,
                                letterSpacing: 2,
                                height: 1.25,
                              ),
                            ),
                            subtitle: _createExpireText(this.note),
                          ),
                        ),
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
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Text _createExpireText(Note note) {
  final bool critical = note.expireAt.difference(note.createdAt).inDays > 1;
  return Text(
    "Fällig am: " + Utils.formatTime(note.expireAt),
    textAlign: TextAlign.center,
    style: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      color: critical ? Colors.white : Colors.redAccent,
    ),
  );
}

String _cutNoteTopic(Note note) {
  final String topic = note.topic.toUpperCase();
  final int length = note.topic.length;
  if (length >= 20) {
    return topic.substring(0, 20) + "...";
  }
  return topic;
}
