import 'package:Notes/note.dart';
import 'package:Notes/routes/note-create-route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'routes/note-view-route.dart';

void main() => runApp(NoteApp());

class NoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notizen',
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.greenAccent,
          backgroundColor: Color.fromRGBO(10, 207, 131, 1)),
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
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      body: Center(
        child: printWidgets(context),
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

Widget printWidgets(BuildContext context) {
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
        style: TextStyle(fontSize: 30, fontFamily: 'Poppins'),
      )
    ],
  );
}

List<Widget> _loadWidgets(BuildContext context) {
  List<Note> notes = List<Note>.from(Note.notes);
  notes.sort((first, second) => second.createdAt.compareTo(first.createdAt));
  notes.sort((first, second) => second.expireAt.compareTo(first.expireAt));
  return notes.map((note) => _createCard(context, note)).toList();
}

Widget _createCard(BuildContext context, Note note) {
  double height = MediaQuery.of(context).size.height;
  return GestureDetector(
    onTap: () => {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NoteViewRoute(note)),
      ),
    },
    child: Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.grey, spreadRadius: 0.3),
                ],
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    height: (height / 2) * 0.5,
                    child: Container(
                      child: Center(
                        child: ListTile(
                          title: Text(
                            note.topic.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 35,
                                color: Colors.white,
                                letterSpacing: 2,
                                height: 1.25),
                          ),
                          subtitle: Text(
                            "Fällig am: " +
                                DateFormat('dd.MM.yyyy').format(note.expireAt),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(
                            0.8,
                            0.0,
                          ),
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
