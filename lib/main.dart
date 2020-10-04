import 'package:Notes/db/backend.dart';
import 'package:Notes/note.dart';
import 'package:Notes/routes/note-create-route.dart';
import 'package:Notes/widgets/note-appbar.dart';
import 'package:Notes/widgets/note-widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Backend backend = Backend();

void main() {
  backend.open().whenComplete(() {
    backend.notes().then((value) {
      Note.notes.addAll(value);
      runApp(NoteApp());
    });
  });
}

class NoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notizen',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.greenAccent,
        backgroundColor: Color.fromRGBO(10, 207, 131, 1),
      ),
      home: NoteHomePage(
        title: 'Deine Notizen',
      ),
    );
  }
}

class NoteHomePage extends StatefulWidget {
  NoteHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NoteHomeState createState() => _NoteHomeState();
}

class _NoteHomeState extends State<NoteHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NoteAppBar(super.widget.title),
      body: Center(
        child: printNotes(context),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteCreateRoute()),
          ),
        },
        child: Icon(Icons.add_to_photos),
      ),
    );
  }
}

Widget printNotes(BuildContext context) {
  if (Note.notes.isNotEmpty) {
    return ListView(
      children: _loadWidgets(context),
    );
  }
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
      )
    ],
  );
}

List<Widget> _loadWidgets(BuildContext context) {
  List<Note> notes = List<Note>.from(Note.notes);
  notes.sort((first, second) => first.expireAt.compareTo(second.expireAt));
  return notes.map((note) => NoteWidget(note)).toList();
}
