import 'package:Notes/utils/noteListViewModel.dart';
import 'package:Notes/widgets/note-widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../note.dart';

class NoteListPage extends StatefulWidget {
  final NoteListViewModel viewModel;

  NoteListPage(this.viewModel);

  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteListViewModel>(context, listen: false).loadAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    if (super.widget.viewModel.notes == null) {
      return Align(
        child: CircularProgressIndicator(),
      );
    } else if (super.widget.viewModel.notes.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.hourglass_empty,
            color: Colors.redAccent,
            size: 120,
          ),
          Text(
            "Keine Notizen vorhanden!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 30,
            ),
          ),
        ],
      );
    } else {
      return ListView(
        children:
            _loadWidgets(super.widget.viewModel, super.widget.viewModel.notes),
      );
    }
  }

  List<Widget> _loadWidgets(NoteListViewModel viewModel, List<Note> notes) {
    notes.sort((first, second) => first.expireAt.compareTo(second.expireAt));
    return notes.map((note) => NoteWidget(note, viewModel)).toList();
  }
}
