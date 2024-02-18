import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


enum Genre{any, thought,history,science,literature,art}
final genreProvider = StateProvider<Genre>((ref) => Genre.any); //本のジャンル

final bookStreamProvider = StreamProvider<QuerySnapshot>((ref) { //本のジャンルを指定
final genres = ref.watch(genreProvider); //本のジャンル
  switch (genres) {
    case Genre.any:
      return FirebaseFirestore.instance.collection('selectsBook').snapshots();
    case Genre.thought:
      return FirebaseFirestore.instance.collection('selectsBook').where(
          'genre', isEqualTo: '人文・思想').snapshots();
    case Genre.history:
      return FirebaseFirestore.instance.collection('selectsBook').where(
          'genre', isEqualTo: '歴史・地理').snapshots();
    case Genre.science :
      return FirebaseFirestore.instance.collection('selectsBook').where(
          'genre', isEqualTo: '科学・工学').snapshots();
    case Genre.literature :
      return FirebaseFirestore.instance.collection('selectsBook').where(
          'genre', isEqualTo: '文学・評論').snapshots();
    case Genre.art :
      return FirebaseFirestore.instance.collection('selectsBook').where(
          'genre', isEqualTo: 'アート・建築').snapshots();
   // default:
     // return FirebaseFirestore.instance.collection('selectsBook').snapshots();
  }
});

final listFilterProvider = StateProvider<String>((ref) => '');//フィルター

