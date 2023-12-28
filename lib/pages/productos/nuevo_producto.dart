import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mongo_dart/mongo_dart.dart' as MD;

import 'package:farmacia/bd/mongodb.dart';
import 'package:farmacia/modelos/productos.dart';
import 'package:farmacia/widgets/boton_atras.dart';

class NuevoProducto extends StatefulWidget {
  const NuevoProducto({Key? key}) : super(key: key);

  @override
  State<NuevoProducto> createState() => _NuevoProductoState();
}

class _NuevoProductoState extends State<NuevoProducto> {
  static const EDICION = 1;
  static const INSERCION = 2;

  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController cantidadController = TextEditingController();
  TextEditingController imgController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController categoriaController = TextEditingController();

  List<Map<String, dynamic>> _categorias = [];

  @override
  Widget build(BuildContext context) {
    var textoWidget = "Añadir Producto";
    int operacion = INSERCION;
    Producto? producto;

    if (ModalRoute.of(context)?.settings.arguments != null) {
      operacion = EDICION;
      producto = ModalRoute.of(context)?.settings.arguments as Producto;
      nombreController.text = producto.nombre;
      descripcionController.text = producto.descripcion;
      cantidadController.text = producto.cantidad;
      imgController.text = producto.img;
      precioController.text = producto.precio;
      stockController.text = producto.stock;
      categoriaController.text = producto.categoria;
      textoWidget = "Editar Producto";
    }
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150.0,
                    child: Lottie.asset('assets/json/productos.json'),
                  ),
                  /*Container(
                    margin: EdgeInsets.only(top: 40.0),
                    child: Image(
                        width: double.infinity,
                        height: 350.0,
                        fit: BoxFit.cover,
                        image:  AssetImage ('assets/img/Restaurante.png')
                    ),
                  ),*/
                  Container(
                    margin: const EdgeInsets.only(top: 40.0),
                    child: backButton(context, Colors.black),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40.0),
                  )
                ],
              ),
              // agregar un componente que permita
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

                        // vamos agregar widgets propios para el proyecto
                        _nombreInput(),
                        _descripcionInput(),
                        _cantidadInput(),
                        _categoriaInput(),
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
                                if (operacion == EDICION) {
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
      id: MD.ObjectId(),
      nombre: nombreController.text,
      descripcion: descripcionController.text,
      categoria: categoriaController.text,
      cantidad: cantidadController.text,
      stock: stockController.text,
      img: imgController.text,
      precio: precioController.text,
    );
    await MongoDB.insertarP(producto);
  }

  _actualizarProducto(Producto producto) async {
    final u = Producto(
      id: producto.id,
      nombre: nombreController.text,
      descripcion: descripcionController.text,
      categoria: categoriaController.text,
      cantidad: cantidadController.text,
      stock: stockController.text,
      img: imgController.text,
      precio: precioController.text,
    );
  }

  //widget para los datos
  Widget _nombreInput() {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 194, 0, 0.8),
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
          color: const Color.fromRGBO(255, 194, 0, 0.8),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: descripcionController,
        decoration: const InputDecoration(
          hintText: "Descripcion del producto",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.text_decrease,
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
          color: const Color.fromRGBO(255, 194, 0, 0.8),
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

  Widget _cantidadInput() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 194, 0, 0.8),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: cantidadController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: "Cantidad",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.numbers,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }

  Widget _categoriaInput() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 194, 0, 0.8),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        controller: categoriaController,
        decoration: const InputDecoration(
          hintText: "Categoría",
          border: OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: Icon(
            Icons.list,
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
    });
  }

  Widget _mostrarcategorias(BuildContext context) {
    return DropdownButton(
      items: _categorias
          .map(
            (categoria) => DropdownMenuItem(
              value: categoria['_id'],
              child: Text(categoria['nombre']),
            ),
          )
          .toList(),
      onChanged: (value) {
        // Aquí puedes manejar el cambio de valor seleccionado
      },
    );
  }

  Widget _stockInput() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 194, 0, 0.8),
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
          color: const Color.fromRGBO(255, 194, 0, 0.8),
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
