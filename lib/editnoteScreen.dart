import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'notepadScreen.dart';
class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({Key? key}) : super(key: key);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController notecontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.black,
       title:  const Text('Edit notes'),
     ),
      body: Column(
        children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
           controller: notecontroller
                ..text ="${Get.arguments['note'].toString()}"
                ,
           ),
            ),
          ElevatedButton(onPressed: ()async{
            Get.to(()=>const NotpadScreen());
            updateProfile();
        // await FirebaseFirestore.instance.collection('notes').doc(Get.arguments['userid'].toString()).update({
        //   'note':notecontroller.text,
        // }).then((value) => {log('Data updated')});
          }, child: const Text('Update')),
        ],
      ),
    );
  }
  updateProfile() async{
    FirebaseFirestore firestore= await FirebaseFirestore.instance;
    firestore.collection('notes').doc('userid').update({
      'note':notecontroller.text,
    });
  }

}
