import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:note_pad/signupScreen.dart';
import 'package:note_pad/user.dart';
import 'forget_paasword.dart';
import 'notepadScreen.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController emailcontroler=TextEditingController();
  TextEditingController passwordcontroler=TextEditingController();

 bool isvisible=true;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const  Text('Login Page'),
      ),
      body: ListView(
        children: [
          Column(
          children: [
            Container(
              alignment: Alignment.center,
             height: 300,
             child: Lottie.asset('assets/login.json'),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child:   TextField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: emailcontroler,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.email_sharp),
                  hintText: 'Email',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child:  TextField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: passwordcontroler,
                obscureText: isvisible,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: GestureDetector(
                      onTap: (){
                        isvisible=!isvisible;
                        setState(() {

                        });
                      },
                      child: Icon( isvisible ? Icons.visibility : Icons.visibility_off)),
                  hintText: 'Password',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton( onPressed: () async {
              try {
                UserCredential userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                  email: emailcontroler.text,
                  password: passwordcontroler.text,
                );
                var user = userCredential.user;
                if (user != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NotpadScreen()));
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>  const NotpadScreen()));
                  user_id = user.uid;
                  print(user.uid);
                  email_id = emailcontroler.text;
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  showErrorDialog(
                      errorMsg: 'No user found for that email.');
                  print('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  showErrorDialog(
                      errorMsg:
                      'Wrong password provided for that user.');
                  print('Wrong password provided for that user.');
                }
              }
              // _showLoading(false);
            }, child: const Text('Login',style: TextStyle(color: Colors.black),),),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgotPassword()));
                },
                child: const Text('Forgot Password',style: TextStyle(color: Colors.black),)),
            const SizedBox(
              height: 10,
            ),
             MaterialButton(
               onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignupScreen()));
               },
               child: const Card(
                   child: Padding(
                     padding: EdgeInsets.all(10),
                     child: Text('Don"t have an account?',style: TextStyle(color: Colors.black),),
                   )),
             ),
          ],
        ),
          // Visibility(
          //   visible: _loginPageLoading,
          //   child: Container(
          //     height: MediaQuery.of(context).size.height,
          //     width: MediaQuery.of(context).size.width,
          //     color: Colors.black45,
          //     child:  const Center(
          //       child: CircularProgressIndicator(),
          //     ),
          //   ),
          // ),
        ]
      ),
    );
  }
  showErrorDialog({required String errorMsg}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'warning'.toUpperCase(),
              style: const TextStyle(color: Colors.red),
            ),
            content: Text(errorMsg),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok',),
              )
            ],
          );
        });
  }

  //Show or Hide loading circle
  // void _showLoading(bool doLoading) {
  //   setState(() {
  //     _loginPageLoading = doLoading;
  //   });
  // }
}
