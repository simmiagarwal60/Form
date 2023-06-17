import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vform/screens/userInfo_screen.dart';

import '../api/apis.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String verify = "";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController countryCode = TextEditingController();
  //TextEditingController _phoneController = TextEditingController();
  var phone = "";
  bool _isLoading = false;


  @override
  void initState() {
    countryCode.text = '+91';
    super.initState();
    //checkUserPhoneNumber();
  }

  Future<void> checkUserPhoneNumber() async {
    User? user = APIs.auth.currentUser;
    String phoneNumber = user?.phoneNumber ?? '';
    if(user != null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => UserDetails()
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return
      //onTap: ()=> FocusScope.of(context).unfocus(),
      Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Phone Verification", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),),
                SizedBox(
                  height: 10,
                ),
                Text("We need to register your phone number before getting started!", style: TextStyle(color: Colors.black, fontSize: 16, fontStyle: FontStyle.normal), textAlign: TextAlign.center,),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white38,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: TextField(
                            style: TextStyle(color: Colors.black87),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            controller: countryCode,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '|',
                        style: TextStyle(fontSize: 30, color: Colors.grey),
                      ),
                      Expanded(
                        child: TextField(
                          //controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            phone = value;
                          },
                          decoration: InputDecoration(
                            hintText: ' Enter your number',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade300,
                    disabledBackgroundColor: Colors.white,
                    shadowColor: Colors.grey,
                  ),
                  onPressed: () async {

                    await APIs.auth.verifyPhoneNumber(
                      phoneNumber: '${countryCode.text + phone}',
                      verificationCompleted:
                          (PhoneAuthCredential credential) async{
                        // await APIs.auth.signInWithCredential(credential).then((value) async{
                        //   if(value.user != null){
                        //     Navigator.pushAndRemoveUntil(
                        //         context, MaterialPageRoute(builder: (_) => UserDetails()), (route)=> false);
                        //   }
                        // });
                          },
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        LoginScreen.verify = verificationId;
                        //checkUserPhoneNumber();
                         Navigator.pushReplacement(
                             context, MaterialPageRoute(builder: (_) => OTP()));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                      timeout: Duration(seconds: 60),
                    );
                  },
                  child: Container(
                    child: _isLoading
                        ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                        : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            )
                          ],
                        ),
                      ),
                    ),
                    width: 120,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
