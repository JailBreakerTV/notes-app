import 'package:Notes/db/backend.dart';
import 'package:Notes/routes/note-create-route.dart';
import 'package:Notes/utils/noteListPage.dart';
import 'package:Notes/utils/noteListViewModel.dart';
import 'package:Notes/widgets/note-appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final Backend backend = Backend();

void main() async {
  await backend.open();
  runApp(NoteApp());
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
      home: ChangeNotifierProvider(
        create: (_) => new NoteListViewModel(),
        child: NoteHomePage(
          title: 'Deine Notizen',
        ),
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
    final viewModel = Provider.of<NoteListViewModel>(context, listen: true);

    return Scaffold(
      appBar: NoteAppBar(super.widget.title),
      body: Center(
        child: NoteListPage(viewModel),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteCreateRoute(viewModel)),
          ),
        },
        child: Icon(Icons.add_to_photos),
      ),
    );
  }
}
