import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
                child: const TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.email_sharp),
                    hintText: 'Email',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: (){
              }, child: const Text('Forgot Password',style: TextStyle(color: Colors.black),),),

            ],
          ),]
      ),
    );
  }
}
