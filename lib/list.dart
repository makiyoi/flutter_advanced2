import 'package:flutter/material.dart';
import 'package:flutter_advanced_2/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_advanced_2/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class List extends ConsumerWidget {
     List({super.key});

 final CollectionReference<Book> userRef = FirebaseFirestore.instance.collection('selectsBook')
  .withConverter<Book>(
      fromFirestore: (snapshots, _ ) => Book.fromJson(snapshots.data()! ),
      toFirestore: (book, _ )=> book.toJson());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue <QuerySnapshot> booksStream = ref.watch(bookStreamProvider);
    return  Scaffold(
      appBar: AppBar(
        title: Text('蔵書一覧',style: TextStyle(color:Colors.brown[200],fontSize: 20)
        ),
        centerTitle: false,
        actions: [
          IconButton(onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Search())),
              icon: Icon(Icons.search,color: Colors.brown[200],size: 40)
          ),
        ],
        backgroundColor: Colors.brown,
      ),
      body: Consumer(
        builder: (context, ref, _) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  booksStream.when(
                    error: (err, _) => Text(err.toString()
                    ),
                    loading: () => const CircularProgressIndicator(),
                    data:(selectBooks) { //QuerySnapshotはdocumentSnapshotの集まり
                        final data = selectBooks.docs; //documentSnapshotのリストを取得する
                        final filter = ref.watch(listFilterProvider);//フィルターを監視する
                        final keywordBook = data.where((book) =>  book['explanation'].contains(filter)).toList();
                       //リストの中の本の内容(explanation)にfilterが含まれるものを取得する。変数に代入
                        return Expanded(
                            child: ListView.builder(
                                itemCount: keywordBook.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      leading: const Icon(Icons.book),
                                      title: Text('${keywordBook[index]['title']}  -  ${keywordBook[index]['author']}',
                                          style: const TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      subtitle: Text(keywordBook[index]['explanation']),
                                    ),
                                  );
                                },
                                ),
                        );
                        },
                  ),
                ],
              ),
            );
          },
      ),
    );
  }
}




