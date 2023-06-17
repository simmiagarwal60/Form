import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../api/apis.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  @override
  Widget build(BuildContext context) {
    String uid = APIs.auth.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient:
            LinearGradient(colors: [Colors.grey, Color(0xffBBDABB)])),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text('User Info',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30, fontFamily: 'bodoni'
                    )),
                SizedBox(
                    height: 30
                ),
                FutureBuilder<DocumentSnapshot>(
                  future: users.doc(uid).get(),
                  builder:
                      (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.hasData) {
                        Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            //mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text('Name: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  Text('${data['name']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Color(0xff006400))),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text('Address: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  Text('${data['address']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Color(0xff006400))),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text('DOB: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  Text('${data['dob']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, color: Color(0xff006400))),
                                ],
                              ),

                            ],
                          ),
                        );
                      }
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
