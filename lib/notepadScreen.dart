import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_pad/LoginScreen.dart';
import 'package:get/get.dart';
import 'createnoteScreen.dart';
import 'editnoteScreen.dart';
class NotpadScreen extends StatefulWidget {
  const NotpadScreen({Key? key}) : super(key: key);

  @override
  State<NotpadScreen> createState() => _NotpadScreenState();
}

class _NotpadScreenState extends State<NotpadScreen> {
   User?userid=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.black,
       title: const Text('HomeScreen'),
        actions: [
          GestureDetector(
            onTap: (){
              FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));},
            child: const Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
               child: StreamBuilder(stream: FirebaseFirestore.instance.collection('notes').where('userid', isEqualTo: userid?.uid).snapshots(),
               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                 if(snapshot.hasError){
                   return const Text('Something went wrong');
                 }if (snapshot.connectionState == ConnectionState.waiting) {
                   return const Center(child: CupertinoActivityIndicator());
                 }   if(snapshot.data!.docs.isEmpty){
                   return const Center(child: Text('No Data Found'));
                 }  if(snapshot!= null && snapshot.data != null){
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                        var note=snapshot.data!.docs[index]['note'];
                        var userid=snapshot.data!.docs[index].id;
                    return  Card(
                      child: ListTile( 
                        title: Text(note),
                        subtitle: Text(userid),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children:  [
                         GestureDetector(
                             onTap: (){
                               Get.to(()=>const EditNoteScreen(),
                               arguments: {
                                 'note':note,
                                 'userid':userid,
                               }
                               );
                             },
                             child: const Icon(Icons.edit)),
                            const SizedBox(width: 8,),
                            const Icon(Icons.delete)

                          ],
                        ),
                      ),
                    );

                  });
                 }
                 return Container();
                 } ,

               ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
         Get.to(()=>const CreateNoteSc());
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNoteSc()));
      },
      child:const Icon(Icons.add) ,
      ),
    );
  }
}
