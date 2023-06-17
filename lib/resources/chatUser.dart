import 'package:cloud_firestore/cloud_firestore.dart';

class ChatUser{
  late  String name;
  late  String address;
  late  String dob;
  late String uid;

  ChatUser({
    required this.name,
    required this.address,
    required this.dob,
    required this.uid,

  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name']= name;
    data['address'] =address;
    data['dob']= dob;
    data['uid']= uid;

    return data;
  }
  ChatUser.fromJson(Map<String, dynamic> json){
    name = json['name'] ?? '';
    address = json['address'] ?? '';
    dob = json['dob'] ?? '';
    uid = json['uid'] ?? '';

  }

  static ChatUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ChatUser(
      name: snapshot['name'],
      address: snapshot['address'],
      dob: snapshot['dob'],
      uid: snapshot['uid'],

    );
  }
}