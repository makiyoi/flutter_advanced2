import 'package:flutter_advanced_2/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_advanced_2/models.dart';


class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {

  final CollectionReference<Book> userRef = FirebaseFirestore.instance.collection('selectsBook')
      .withConverter<Book>(
      fromFirestore: (snapshots, _ ) => Book.fromJson(snapshots.data()! ),
      toFirestore: (book, _ )=> book.toJson());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('検索条件',style: TextStyle(color:Colors.brown[200],fontSize: 20,),),
        iconTheme: IconThemeData(color: Colors.brown[200]),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('検索条件',style: TextStyle(fontSize: 30,color: Colors.brown),),
              const SizedBox(height: 30,),
              Text('ジャンル',style: TextStyle(fontSize: 15,color: Colors.brown[200]),),
              const SizedBox(height: 10,),
              Consumer(
                  builder: (context,ref, _) {
                    return DropdownButton<Genre>(
                      value: ref.watch(genreProvider),
                      onChanged: (value) {
                       ref.read(genreProvider.notifier).state = value!;
                      },
                      iconEnabledColor: Colors.brown,
                      iconSize: 30,
                      icon: const Icon(Icons.arrow_downward),
                      underline: Container(
                        height: 2,
                        color: Colors.brown,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: Genre.any,
                          child: Text('指定なし'),
                        ),
                        DropdownMenuItem(
                          value: Genre.thought,
                          child: Text('人文・思想'),
                        ),
                        DropdownMenuItem(
                          value: Genre.history,
                          child: Text('歴史・地理'),
                        ),
                        DropdownMenuItem(
                          value: Genre.science,
                          child: Text('科学・工学'),
                        ),
                        DropdownMenuItem(
                          value: Genre.literature,
                          child: Text('文学・評論'),
                        ),
                        DropdownMenuItem(
                          value: Genre.art,
                          child: Text('アート・建築'),
                        ),
                      ],

                    );
                  }
              ),
              //    ),
              //   }
              // ),
              const SizedBox(height: 50,),
              const Text('フィルター',style: TextStyle(fontSize: 15,color: Colors.brown),),
              const SizedBox(height: 20,),
               SizedBox(
                width: 200,
                child: TextField(
                  onChanged: (value){
                    ref.read(listFilterProvider.notifier).state = value;
                    },
                  decoration: const InputDecoration(
                    labelText: 'キーワード',
                    border: OutlineInputBorder(
                        borderSide: BorderSide()),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}