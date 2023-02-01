import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';
import 'notepadScreen.dart';
class CreateNoteSc extends StatefulWidget {
  const CreateNoteSc({Key? key}) : super(key: key);

  @override
  State<CreateNoteSc> createState() => _CreateNoteScState();
}

class _CreateNoteScState extends State<CreateNoteSc> {
 TextEditingController createcontroller=TextEditingController();
 User ?userid=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Create Notes'),
      ),
       body: ListView(
         children:[Column(
           children: [
             Container(
               margin: const EdgeInsets.symmetric(horizontal: 10),
               child: TextFormField(
                 controller: createcontroller,
                 maxLines: null,
                 decoration: const InputDecoration(
                        hintText: 'Add Notes'
                 ),
               ),
             ),
             ElevatedButton(onPressed: () async{
               usernote();
              //     var note=createcontroller.text;
              //     if(note != ''){
              //       try{
              // await  FirebaseFirestore.instance.collection('notes').doc().set({
              //     'created':DateTime.now,
              //     'note':note,
              //     'userid':userid!.uid,
              //
              //   });
              //       }catch (e){
              //         print('Error $e');
              //       }
              //     }

             }, child: const Text('Add Note'))
           ],
         ),
    ],
       )
    );
  }
   void usernote()async{
       saverUserData();
       Navigator.push(context, MaterialPageRoute(builder: (context)=> const NotpadScreen()));
     }

 saverUserData(){
   FirebaseFirestore firestore = FirebaseFirestore.instance;
   firestore.collection('notes').doc().set({
     'createdate':DateTime.now(),
     'userid':userid!.uid,
     'note':createcontroller.text,
   });
 }
}
