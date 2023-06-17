import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../api/apis.dart';
import 'Login_screen.dart';
import 'form_screen.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  Widget build(BuildContext context) {
    final phoneNumber;
    var otpCode = "";
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: _appBar(),
        //automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.grey, Color(0xffBBDABB)]),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Verify your Phone Number', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,), textAlign: TextAlign.start,),
                SizedBox(
                  height: 50,
                ),
                Pinput(
                  length: 6,
                  showCursor: true,
                  onChanged: (value){
                    otpCode = value;

                  },
                ),
                SizedBox(
                  height: 18,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade300,
                    disabledBackgroundColor: Colors.white,
                    shadowColor: Colors.grey,),
                  onPressed: () async{
                    try{
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: LoginScreen.verify, smsCode: otpCode);
                      // Sign the user in (or link) with the credential
                      await APIs.auth.signInWithCredential(credential);
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => FormScreen()));
                    }
                    catch(e){
                      print("wrong otp");
                    }
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text('Verify', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),)
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

                // Flexible(
                //   child: Container(),
                //   flex: 2,
                // ),
              ],
            ),
          ),
        ),
      ),
    );

  }
  Widget _appBar(){
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.black,)),
        ],
      ),
    );
  }
}
