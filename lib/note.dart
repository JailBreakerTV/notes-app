import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Note {
  static final List<Note> notes = new List();

  String topic;
  String value;
  DateTime expireAt;
  DateTime createdAt;

  Note({this.topic, this.value, this.expireAt, this.createdAt});

  Note.fromJson(Map<String, dynamic> json)
      : this.topic = json['topic'],
        this.value = json['value'],
        this.expireAt = DateTime.fromMicrosecondsSinceEpoch(json['expireAt']),
        this.createdAt = DateTime.fromMicrosecondsSinceEpoch(json['createdAt']);

  Map<String, dynamic> toJson() => {
        'topic': this.topic,
        'value': this.value,
        'expireAt': this.expireAt.millisecondsSinceEpoch,
        'createdAt': this.createdAt.millisecondsSinceEpoch
      };
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/notes.json');
}

Future<File> writeNotes() async {
  final file = await _localFile;
  // Write the file.
  return file.writeAsString(json.encode(Note.notes));
}

Future<List<Note>> readNotes() async {
  try {
    final file = await _localFile;
    // Read the file.
    String contents = await file.readAsString();
    return json.decode(contents);
  } catch (e) {
    // If encountering an error, return 0.
    return new List();
  }
}
