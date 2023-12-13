import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models.dart';

const List<Book> initialBooks = [
  Book(title: '概念記法', author: 'ゴットローブ・フレーゲ', explanation: '本書はアリストテレス以来の論理学を根本的に革新し、現代論理学と現代哲学への道を切いた記念碑的著作である。'
      'フレーゲの目的は算術を基礎づけることのあり、そのために新しい論理学を作り出した。'),
  Book(title: 'スレイマーンの戴冠', author: 'アメリカンショートヘア', explanation: '昼'),
  Book(title: 'むぎ', author: 'ジャン・シャルダン', explanation: 'フランスの宝石商が、１７世紀ペルシアの王位継承の顛末に関する宮廷史家の記録を、自らの見聞も交えて伝える。さまざまな思惑、'
      '渦巻く権謀を生き生きと描く、興味津々たる貴重な史料。'),
  Book(title: '蝸牛考', author: '柳田　國男', explanation: '蝸牛を表す方言は、京都を中心としてデデムシ→マイマイ→カタツムリ→ツブリ→ナメクジのように日本列島を同心円状に分布する。それは'
  'この語が歴史的に同心円の外側から内部にむかっって順次変化してきたからだ、と柳田國男は推定した。'),
  Book(title: '個と宇宙', author: 'エルンスト・カッシーラー', explanation: '『省庁形式の哲学』や『人間』等で著名な20世紀哲学の巨匠が、『自然-認識』を基底に捉えて個性的続一体としてのルネサンス哲学の'
      '全体像を描き出した名著。多様で複雑なルネサンス哲学の構造と展開が、時代の精神史的・文化的文脈に位置づけ浮き彫りにされている。')
];

enum Genre{any, thought,history,science,literature,art}


final genreProvider = StateProvider<Genre>((ref) => Genre.any);

final bookStream = StreamProvider<QuerySnapshot>((ref) {
  return FirebaseFirestore.instance.collection('selectsBook').snapshots();});
