import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_pad/LoginScreen.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController forgotpasswordcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const  Text('Forgot Password'),
      ),
      body: ListView(
          children: [Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 300,
                child: Lottie.asset('assets/login.json'),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child:  TextField(
                  controller: forgotpasswordcontroller,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.email_sharp),
                    hintText: 'Email',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
              var forgotEmail=forgotpasswordcontroller.text.trim();
              try{
                await FirebaseAuth.instance.sendPasswordResetEmail(email: forgotEmail).then((value) => {print('Email send')});
              } on FirebaseAuthException catch(e){
                print('error$e');
                  }
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
              },
                child: const Text('Forgot Password',style: TextStyle(color: Colors.black),),),

            ],
          ),]
      ),
    );
  }
}
