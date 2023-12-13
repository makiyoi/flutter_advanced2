import 'package:flutter/material.dart';

@immutable
class Book{
  const Book({
    required this.title,
    required this.author,
    required this.explanation,
    //required this.genre,

  });

  Book.fromJson(Map<String, Object?> json)
      : this(
    title: json['title']! as String,
    author: json['author']! as String,
    explanation: json['explanation']! as String,
    // genre: json['genre']! as String,
  );

  final String title;
  final String author;
  final String explanation;
  // final String genre;

  Book copyWith({String? title, String? author,String? explanation,String? genre}) {
    return Book(
      title:  title?? this.title,
      author: author?? this.author,
      explanation:  explanation?? this.explanation,
      // genre:  genre?? this.genre,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'author': author,
      'explanation': explanation,
      // 'genre': genre,
    };
  }

}
