import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class deleteTodoPage extends StatefulWidget {
  const deleteTodoPage({super.key});

  @override
  State<deleteTodoPage> createState() => _deleteTodoPageState();
}

class _deleteTodoPageState extends State<deleteTodoPage> {
  TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeleteTodo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: idController,
            decoration: InputDecoration(hintText: 'id'),
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: submitDataJesus, child: Text('Delete'))
        ],
      ),
    );
  }

  Future<void> submitDataJesus() async {
    // Get the data from form
    final id = idController.text;
    final body = {
      "id": id,
    };

    // Submit data to the server
    final url = 'https://jspastelapi.fly.dev/eliminar?id=$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    // Show success or fail message based on status
    if (response.statusCode == 200) {
      idController.text = '';
      showSuccessMessage('Postre Borrado');
    } else {
      showErroMessage('Delete Success');
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      backgroundColor: Color.fromARGB(255, 27, 75, 206),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErroMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
