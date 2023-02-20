// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PostModelClass {
  final int id;
  final String body;
  final String title;
  PostModelClass({
    required this.id,
    required this.body,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'body': body,
      'title': title,
    };
  }

  factory PostModelClass.fromMap(Map<String, dynamic> map) {
    return PostModelClass(
      id: map['id'],
      body: map['body'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModelClass.fromJson(String source) =>
      PostModelClass.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModelClass(id: $id, body: $body, title: $title)';
  }

  @override
  bool operator ==(covariant PostModelClass other) {
    if (identical(this, other)) return true;

    return other.id == id && other.body == body && other.title == title;
  }

  @override
  int get hashCode {
    return id.hashCode ^ body.hashCode ^ title.hashCode;
  }
}
