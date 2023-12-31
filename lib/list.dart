import 'package:flutter/material.dart';
import 'package:flutter_advanced_2/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_advanced_2/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_advanced_2/models.dart';

class List extends ConsumerWidget {
   List({super.key});

  final CollectionReference<Book> userRef = FirebaseFirestore.instance.collection('selectsBook')
  .withConverter<Book>(
      fromFirestore: (snapshots, _ ) => Book.fromJson(snapshots.data()! ),
      toFirestore: (book, _ )=> book.toJson());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(bookStream);
    return  Scaffold(
      appBar: AppBar(
        title: Text('蔵書一覧',style: TextStyle(color:Colors.brown[200],fontSize: 20,),),
        centerTitle: false,
        actions: [
          IconButton(onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Search())),
              icon: Icon(Icons.search,color: Colors.brown[200],size: 40,))
        ],
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: [
          asyncValue.when(data: (data) => Text(data.toString()),
            error: (err, _) => Text(err.toString()),
            loading: () => const CircularProgressIndicator(), ),
          //StreamBuilder<QuerySnapshot<Book>>(
           // stream: userRef.snapshots(),
           // builder: (context, snapshot) {
             // if(snapshot.hasData) {
               // final data = snapshot.data!;
             //   return Expanded(
               //   child: ListView.builder(
                 //     itemCount: data.docs.length,
                   //   itemBuilder: (context, index) {
                   //     return BookCard(book: data.docs[index].data());
                    //  }
             //     ),
             //   );
            //  }
           //   return const  Center(child: CircularProgressIndicator(),);
          //  }
         // ),
    ],
    ),
    );
  }
}

class BookCard extends StatelessWidget {
  const BookCard({Key? key,required this.book}) : super(key: key);
final Book book;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                children: [
                  Text(book.title,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Text(book.author,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
              Text(book.explanation,style: const TextStyle(fontSize: 16,color: Color(0xff555555)),),
            ],
          ),
        ),
      ),
    );
  }
}
