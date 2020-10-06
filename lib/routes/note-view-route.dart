import 'package:Notes/note.dart';
import 'package:Notes/utils/noteListViewModel.dart';
import 'package:Notes/utils/utils.dart';
import 'package:Notes/widgets/note-appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../main.dart';

class NoteViewRoute extends StatelessWidget {
  static NoteViewRoute create(NoteListViewModel viewModel, Note note) {
    return NoteViewRoute(
      note,
      viewModel,
      new TextEditingController(text: Utils.formatTime(note.expireAt)),
    );
  }

  final Note note;
  final NoteListViewModel viewModel;
  final TextEditingController dateTimeController;

  NoteViewRoute(this.note, this.viewModel, this.dateTimeController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NoteAppBar(this.note.topic),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Center(
          child: Container(
            margin: EdgeInsets.all(30),
            child: Form(
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    onChanged: (text) => {
                      if (text.isNotEmpty)
                        {
                          this.note.topic = text,
                          backend.updateNote(this.note),
                        }
                    },
                    textAlign: TextAlign.left,
                    initialValue: this.note.topic,
                    decoration: InputDecoration(
                      labelText: "Titel",
                      labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (text) => {
                      if (text.isNotEmpty)
                        {
                          this.note.value = text,
                          backend.updateNote(this.note),
                        }
                    },
                    maxLines: null,
                    textAlign: TextAlign.left,
                    initialValue: this.note.value,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: "Inhalt",
                      labelStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                        fontSize: 20,
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
                          this.dateTimeController.text = Utils.formatTime(date);
                          this.note.expireAt = date;
                        },
                        onConfirm: (date) {
                          this.dateTimeController.text = Utils.formatTime(date);
                          this.note.expireAt = date;
                          backend.updateNote(this.note);
                        },
                        currentTime: this.note.expireAt,
                        locale: LocaleType.de,
                      ),
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
                        onPressed: () =>
                        {
                          this.viewModel.removeNote(this.note),
                          backend.deleteNote(this.note),
                          Utils.pop(context),
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
