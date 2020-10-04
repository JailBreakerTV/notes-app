import 'package:Notes/main.dart';
import 'package:Notes/note.dart';
import 'package:Notes/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// ignore: must_be_immutable
class NoteCreateRoute extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  DateTime dateTime = DateTime.now();

  final TextEditingController topicController = new TextEditingController();
  final TextEditingController valueController = new TextEditingController();
  final TextEditingController dateTimeController = new TextEditingController(
    text: Utils.formatTime(
      DateTime.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch +
            Duration(days: 1).inMilliseconds,
      ),
    ),
  );

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
                key: this._formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: _createValidator(
                        'Die Überschrift darf nicht leer sein!',
                      ),
                      controller: this.topicController,
                      decoration: InputDecoration(
                        labelText: 'Überschrift',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                    ),
                    TextFormField(
                      validator: _createValidator(
                        'Der Inhalt darf nicht leer sein!',
                      ),
                      controller: this.valueController,
                      decoration: InputDecoration(
                        labelText: 'Inhalt',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: this.dateTimeController,
                      onTap: () =>
                      {
                        FocusScope.of(context).requestFocus(new FocusNode()),
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime(2050, 1, 1),
                          onChanged: (date) {
                            this.dateTimeController.text =
                                Utils.formatTime(date);
                            this.dateTime = date;
                          },
                          onConfirm: (date) {
                            this.dateTimeController.text =
                                Utils.formatTime(date);
                            this.dateTime = date;
                          },
                          currentTime: DateTime.now(),
                          locale: LocaleType.de,
                        )
                      },
                      decoration: InputDecoration(
                        labelText: "Fälligkeitsdatum",
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontSize: 20,
                        ),
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
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              letterSpacing: 1.2,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () => {
                            if (this._formKey.currentState.validate())
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
  backend.insertNote(note);
  Utils.pop(context);
}

FormFieldValidator _createValidator(String promptText) {
  return (value) {
    if (value.isEmpty) {
      return promptText;
    }
    return null;
  };
}
