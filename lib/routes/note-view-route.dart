import 'package:Notes/note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class NoteViewRoute extends StatelessWidget {
  Note note;
  TextEditingController dateTimeController;

  NoteViewRoute(Note note) {
    this.note = note;
    this.dateTimeController =
        new TextEditingController(text: _formatDateTime(note.expireAt));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.note.topic),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 30.0, right: 30.0, left: 30.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    onChanged: (text) => {note.topic = text},
                    textAlign: TextAlign.left,
                    initialValue: this.note.topic,
                    decoration: InputDecoration(
                      labelText: "Titel",
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ),
                  TextFormField(
                    onChanged: (text) => {note.value = text},
                    textAlign: TextAlign.left,
                    initialValue: this.note.value,
                    decoration: InputDecoration(
                      labelText: "Inhalt",
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ),
                  TextFormField(
                    controller: this.dateTimeController,
                    onChanged: (text) => {note.value = text},
                    onTap: () => {
                      FocusScope.of(context).requestFocus(new FocusNode()),
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime(2050, 1, 1), onChanged: (date) {
                        this.dateTimeController.text = _formatDateTime(date);
                        this.note.expireAt = date;
                      }, onConfirm: (date) {
                        this.dateTimeController.text = _formatDateTime(date);
                        this.note.expireAt = date;
                      }, currentTime: DateTime.now(), locale: LocaleType.de)
                    },
                    decoration: InputDecoration(
                      labelText: "Fälligkeitsdatum",
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 50,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      FloatingActionButton(
                        child: Icon(
                          Icons.delete_forever,
                          size: 40,
                        ),
                        backgroundColor: Colors.redAccent,
                        tooltip: "Lösche diesen Eintrag",
                        onPressed: () => {
                          Note.notes.remove(this.note),
                          Navigator.pop(context),
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _formatDateTime(DateTime dateTime) {
  return DateFormat('dd.MM.yyyy').format(dateTime);
}
