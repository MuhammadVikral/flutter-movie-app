import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String summary;
  final String imageUrl;
  const Movie({
    required this.id,
    required this.title,
    required this.summary,
    required this.imageUrl,
  });

  toJson() => {
        'id': id,
        'title': title,
        'summary': summary,
        'imageUrl': imageUrl,
      };

  factory Movie.fromJson(dynamic json) {
    final movie = Movie(
      id: json['id'] as int,
      title: json['title'] as String,
      summary: json['summary'] as String,
      imageUrl: json['imageUrl'] as String,
    );
    return movie;
  }
  @override
  String toString() {
    return '{ $id, $title,$summary,$imageUrl }';
  }

  @override
  List<Object?> get props => [id, title, summary, imageUrl];
}
