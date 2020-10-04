class Note {
  static final List<Note> notes = new List();

  int noteId = 0;
  String topic;
  String value;
  DateTime expireAt;
  DateTime createdAt;

  Note({this.topic, this.value, this.expireAt, this.createdAt});

  Note.fromJson(Map<String, dynamic> json)
      : this.noteId = json['note_id'],
        this.topic = json['topic'],
        this.value = json['value'],
        this.expireAt = DateTime.fromMillisecondsSinceEpoch(json['expire_at']),
        this.createdAt =
            DateTime.fromMillisecondsSinceEpoch(json['created_at']);

  Map<String, dynamic> toMap() =>
      {
        'topic': this.topic,
        'value': this.value,
        'expire_at': this.expireAt.millisecondsSinceEpoch,
        'created_at': this.createdAt.millisecondsSinceEpoch,
      };
}
