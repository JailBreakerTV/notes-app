import 'package:Notes/note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NoteCreateRoute extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  DateTime dateTime = DateTime.now();

  final TextEditingController topicController = new TextEditingController();
  final TextEditingController valueController = new TextEditingController();
  final TextEditingController dateTimeController = new TextEditingController(
      text: _formatDateTime(DateTime.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch + 86400000)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notiz erstellen"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Die Überschrift darf nicht leer sein!';
                        }
                        return null;
                      },
                      controller: this.topicController,
                      decoration: InputDecoration(
                        labelText: 'Überschrift',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Der Inhalt darf nicht leer sein!';
                        }
                        return null;
                      },
                      controller: this.valueController,
                      decoration: InputDecoration(
                        labelText: 'Inhalt',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: this.dateTimeController,
                      onTap: () => {
                        FocusScope.of(context).requestFocus(new FocusNode()),
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            maxTime: DateTime(2050, 1, 1), onChanged: (date) {
                          this.dateTimeController.text = _formatDateTime(date);
                          this.dateTime = date;
                        }, onConfirm: (date) {
                          this.dateTimeController.text = _formatDateTime(date);
                          this.dateTime = date;
                        }, currentTime: DateTime.now(), locale: LocaleType.de)
                      },
                      decoration: InputDecoration(
                        labelText: "Fälligkeitsdatum",
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: SizedBox(
                        width: double.infinity,
                        child: CupertinoButton(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          child: Text(
                            "Speichern",
                            style: TextStyle(letterSpacing: 1.2, fontSize: 20),
                          ),
                          onPressed: () => {
                            if (_formKey.currentState.validate())
                              {
                                _addNote(
                                  context,
                                  Note(
                                    createdAt: DateTime.now(),
                                    expireAt: this.dateTime,
                                    topic: this.topicController.text,
                                    value: this.valueController.text,
                                  ),
                                )
                              }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_addNote(BuildContext context, Note note) {
  Note.notes.add(note);
  writeNotes();
  Navigator.pop(context);
}

String _formatDateTime(DateTime dateTime) {
  return DateFormat('dd.MM.yyyy').format(dateTime);
}
