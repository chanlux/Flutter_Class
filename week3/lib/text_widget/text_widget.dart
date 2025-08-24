import 'package:flutter/material.dart';
void main(List<String> args) {
  runApp(
    MaterialApp(
      home: TextWidget(),
    ),
  );
}

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text"),
        backgroundColor: Color.fromARGB(255, 234, 224, 32),
      ),
      body: Center(
        child: Text("Text Widget Basic"),
      ),
    );
  }
}