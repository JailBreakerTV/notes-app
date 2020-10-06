import 'package:Notes/note.dart';
import 'package:Notes/routes/note-view-route.dart';
import 'package:Notes/utils/noteListViewModel.dart';
import 'package:Notes/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  final Note note;
  final NoteListViewModel viewModel;

  NoteWidget(this.note, this.viewModel);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => {
        Utils.pushWidget(
            context, NoteViewRoute.create(this.viewModel, this.note))
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Card(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0.3,
                ),
              ],
            ),
            child: SizedBox(
              width: width / 2,
              height: (height / 2),
              child: Container(
                child: Center(
                  child: ListTile(
                    title: Text(
                      _cutNoteTopic(this.note),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 30,
                        color: Colors.white,
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
          ),
        ),
      ),
    );
  }
}

Text _createExpireText(Note note) {
  final bool critical = note.expireAt.difference(note.createdAt).inDays > 1;
  return Text(
    Utils.formatTime(note.expireAt),
    textAlign: TextAlign.center,
    style: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20,
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
