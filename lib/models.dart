import 'package:flutter/material.dart';

@immutable
class Book{
  const Book({
    required this.title,   //本のタイトル
    required this.author,  //本の著者
    required this.explanation,  //本の内容
    required this.genre,     //本のジャンル
    // this.contain =false,    //含むか含まないか
  });

  Book.fromJson(Map<String, Object?> json)
      : this(
    title: json['title']! as String,
    author: json['author']! as String,
    explanation: json['explanation']! as String,
    genre: json['genre']! as String,
   // contain: json['contain']! as bool,
  );

  final String title;
  final String author;
  final String explanation;
   final String genre;
 //  final bool contain;

  Book copyWith({String? title, String? author,String? explanation,String? genre}) {
    return Book(
      title:  title?? this.title,
      author: author?? this.author,
      explanation:  explanation?? this.explanation,
      genre:  genre?? this.genre,
    //  contain: contain?? this.contain,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'author': author,
      'explanation': explanation,
      'genre': genre,
   //   'contain': contain,
    };
  }

}
