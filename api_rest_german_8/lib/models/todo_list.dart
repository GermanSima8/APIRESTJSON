import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_rest_german_8/models/producto.dart';
import 'add_page.dart';
import 'delete.dart';
import 'add_page.dart';
import 'update.dart';
import 'producto.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final url = Uri.parse("https://jspastelapi.fly.dev/postre");
  late Future<List<Producto>> productos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API REST'),
      ),
      //MENÚ
      drawer: Container(
          child: Container(
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text(
                  '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.add_outlined),
                title: Text('POST'),
                iconColor: Color.fromARGB(255, 0, 0, 0),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddTodoPage()));
                },
              ),
              Divider(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              ListTile(
                leading: Icon(Icons.delete_outline),
                title: Text('DELETE'),
                iconColor: Color.fromARGB(255, 0, 0, 0),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => deleteTodoPage()));
                },
              ),
              Divider(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              ListTile(
                leading: Icon(Icons.update_outlined),
                title: Text('UPDATE'),
                iconColor: Color.fromARGB(255, 0, 0, 0),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => updateTodoPage()));
                },
              ),
              Divider(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
        ),
      )), //AQUI FINALIZA MENÚ
      body: FutureBuilder<List<Producto>>(
          future: productos,
          builder: (context, snap) {
            if (snap.hasData) {
              return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(snap.data![i].sabor,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(snap.data![i].tamano.toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                          trailing: Text(snap.data![i].precio,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const Divider()
                      ],
                    );
                  });
            }
            if (snap.hasError) {
              return const Center(
                child: Text("Ocurrió un problema"),
              );
            }

            return const CircularProgressIndicator();
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    productos = getProductos();
  }

  Future<List<Producto>> getProductos() async {
    final res = await http.get(url); //respuesta en texto
    //final lista = List.from(jsonDecode(res.body));
    final lista = jsonDecode(res.body);

    print(lista["postre"]);

    List<Producto> productos = [];
    lista["postre"].forEach((element) {
      final Producto product = Producto.fromJson(element);
      productos.add(product);
    });
    return productos;
  }
}
