import 'package:flutter/material.dart';

class ToDoDetailsPage extends StatelessWidget {
  const ToDoDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          TextField(),
          TextField(),
        ],
      ),
    );
  }
}
