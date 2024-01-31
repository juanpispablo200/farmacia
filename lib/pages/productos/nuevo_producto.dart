import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mongo_dart/mongo_dart.dart' as md;

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/productos.dart';

class NuevoProducto extends StatefulWidget {
  const NuevoProducto({Key? key}) : super(key: key);

  @override
  State<NuevoProducto> createState() => _NuevoProductoState();
}

class _NuevoProductoState extends State<NuevoProducto> {
  static const edicion = 1;
  static const insercion = 2;
  String? _selectedCategoria;

  @override
  void initState() {
    super.initState();
    _getCategorias();
  }

  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController imgController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController categoriaController = TextEditingController();

  List<Map<String, dynamic>> _categorias = [];

  @override
  Widget build(BuildContext context) {
    var textoWidget = "Añadir Producto";
    int operacion = insercion;
    Producto? producto;

    if (ModalRoute.of(context)?.settings.arguments != null) {
      operacion = edicion;
      producto = ModalRoute.of(context)?.settings.arguments as Producto;
      nombreController.text = producto.nombre;
      descripcionController.text = producto.descripcion;
      imgController.text = producto.img;
      precioController.text = producto.precio.toString();
      stockController.text = producto.stock;
      categoriaController.text = producto.categoria;
      textoWidget = "Editar Producto";
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo Producto"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 150.0,
                    child: Lottie.asset('assets/json/productos.json'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40.0),
                  )
                ],
              ),
              Transform.translate(
                offset: const Offset(0.0, -20.0),
                child: Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  width: double.infinity,
                  height: 630.0,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Text(
                          "Crea un nuevo producto",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          ),
                        ),
                        _nombreInput(),
                        _descripcionInput(),
                        _mostrarcategorias(context),
                        _imgInput(),
                        _stockInput(),
                        _precioInput(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: ElevatedButton(
                              child: Text(textoWidget),
                              onPressed: () {
                                if (operacion == edicion) {
                                  // editar el objeto
                                  _actualizarProducto(producto!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Producto actualizado Correctamente')),
                                  );
                                } else {
                                  //Insertar el componente
                                  _insetarProducto();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Nuevo producto con exito')),
                                  );
                                }
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _insetarProducto() async {
    final producto = Producto(
      id: md.ObjectId(),
      nombre: nombreController.text,
      descripcion: descripcionController.text,
      categoria: _selectedCategoria ?? 'default',
      stock: stockController.text,
      img: imgController.text,
      precio: double.parse(precioController.text),
    );
    await MongoDB.insertarP(producto);
  }

  _actualizarProducto(Producto producto) async {
    final productoActualizado = Producto(
      id: producto.id,
      nombre: nombreController.text,
      descripcion: descripcionController.text,
      categoria: _selectedCategoria ?? 'default',
      stock: stockController.text,
      img: imgController.text,
      precio: double.parse(precioController.text),
    );

    await MongoDB.actualizarP(productoActualizado);
  }

  //widget para los datos
  Widget _nombreInput() {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: nombreController,
        decoration: const InputDecoration(
          hintText: "Nombre del producto",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.production_quantity_limits,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget _descripcionInput() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: descripcionController,
        decoration: const InputDecoration(
          hintText: "Descripcion del producto",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.description,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }

  Widget _imgInput() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: imgController,
        decoration: const InputDecoration(
          hintText: "Imagen",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.image,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }

  // desplegable
  Future<void> _getCategorias() async {
    final categorias = await MongoDB.getCategorias();
    setState(() {
      _categorias = categorias;
      _selectedCategoria =
          _categorias.isNotEmpty ? _categorias[0]['_id'].toString() : null;
    });
  }

  Widget _mostrarcategorias(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(20.0)),
      child: InputDecorator(
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.category, color: Colors.pink),
            border: InputBorder.none),
        child: DropdownButtonHideUnderline(
          // This hides the default underline of DropdownButton
          child: DropdownButton<String>(
            isExpanded: true,
            value: _selectedCategoria,
            items: _categorias.map((categoria) {
              return DropdownMenuItem<String>(
                value: categoria['_id'].toString(),
                child: Text(categoria['nombre']),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategoria = newValue;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _stockInput() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: stockController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: "Stock",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.numbers_sharp,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }

  Widget _precioInput() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: precioController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: "Precio",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.money,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}
