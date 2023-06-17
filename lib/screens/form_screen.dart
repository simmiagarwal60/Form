import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vform/screens/userInfo_screen.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController dob = TextEditingController();


  CollectionReference phone = FirebaseFirestore.instance.collection('users');
  void createUserinFirestore() async{
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await phone
        .doc(uid)
        .set({
      'name': name.text.trim(),
      'address': address.text.trim(),
      'dob': dob.text.trim(),
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetails()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient:
              LinearGradient(colors: [Colors.grey, Color(0xffBBDABB)])),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text('Form',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30, fontFamily: 'bodoni'
                      )),
                  SizedBox(
                      height: 30
                  ),
                  Text(
                    'Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: name,
                    decoration: InputDecoration(
                      hintText: "Your name",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Address',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: address,
                    decoration: InputDecoration(hintText: "Your address"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'DOB',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: dob,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText: "23/03/2002"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff264741),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                        onPressed: () async {
                          createUserinFirestore();
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ),
                          width: 250,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
