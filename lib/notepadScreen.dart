import 'package:flutter/material.dart';
class NotpadScreen extends StatefulWidget {
  const NotpadScreen({Key? key}) : super(key: key);

  @override
  State<NotpadScreen> createState() => _NotpadScreenState();
}

class _NotpadScreenState extends State<NotpadScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
       title: const Text('NotePad'),
      ),
    );
  }
}
