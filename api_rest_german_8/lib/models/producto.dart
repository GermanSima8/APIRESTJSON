class Producto {
  int id;
  String precio;
  String sabor;
  String tamano;

  Producto({
    required this.id,
    required this.precio,
    required this.sabor,
    required this.tamano,
  });

  factory Producto.fromJson(Map json) {
    return Producto(
      id: json["id"],
      precio: json["precio"],
      sabor: json["sabor"],
      tamano: json["tamano"],
    );
  }
}
