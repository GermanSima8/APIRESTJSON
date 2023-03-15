import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class updateTodoPage extends StatefulWidget {
  const updateTodoPage({super.key});

  @override
  State<updateTodoPage> createState() => _updateTodoPageState();
}

class _updateTodoPageState extends State<updateTodoPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController saborController = TextEditingController();
  TextEditingController tamanoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UpdateTodo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: idController,
            decoration: InputDecoration(hintText: 'id'),
          ),
          TextField(
            controller: precioController,
            decoration: InputDecoration(hintText: 'precio'),
          ),
          TextField(
            controller: saborController,
            decoration: InputDecoration(hintText: 'sabor'),
          ),
          TextField(
            controller: tamanoController,
            decoration: InputDecoration(hintText: 'tamaño'),
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: submitDataJesus, child: Text('Update'))
        ],
      ),
    );
  }

  Future<void> submitDataJesus() async {
    // Get the data from form
    final id = idController.text;
    final precio = precioController.text;
    final sabor = saborController.text;
    final tamano = tamanoController.text;
    final body = {
      "id": id,
      "precio": precio,
      "sabor": sabor,
      "tamano": tamano,
    };

    // Submit data to the server
    final url =
        'https://jspastelapi.fly.dev/actualizar?id=$id&precio=$precio&sabor=$sabor&tamano=$tamano';
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    // Show success or fail message based on status
    if (response.statusCode == 200) {
      idController.text = '';
      precioController.text = '';
      saborController.text = '';
      tamanoController.text = '';
      showSuccessMessage('Eliminado');
    } else {
      showErroMessage('Update Failed');
    }
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(255, 41, 65, 196),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErroMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
