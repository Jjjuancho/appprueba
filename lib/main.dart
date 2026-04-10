// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';

void main() {
  // Main: primer función que se ejecuta al abrir la app
  runApp(const MyApp());
}

// MyApp: configuración general de la app. Título, tema, home, etc.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      //Título: lo que se muestra, por ejemplo, en la pestaña de Google Chrome
      title: 'Flutter Demo',

      //Tema: se define el esquema de colores de la app
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blueGrey),
      ),

      // Home: primer widget que se muestra en la app. El home de la "página".
      home: ListaProductos(),

      debugShowCheckedModeBanner: false,
    );
  }
}

// Clase que muestra la lista de productos
class ListaProductos extends StatefulWidget {
  const ListaProductos({super.key});

  @override
  State<ListaProductos> createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {
  
  final TextEditingController controladorNombre = TextEditingController();
  final TextEditingController controladorPrecio = TextEditingController();
  final TextEditingController controladorStock = TextEditingController();

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventario"), 
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          
          const SizedBox(height: 20),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),

            child: Row(
              children: [

                Expanded(

                  child: TextField(
                    controller: controladorNombre,
                    decoration: const InputDecoration(
                      labelText: 'Nombre del producto',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                
                const SizedBox(width: 15),
                
                Expanded(
                  child: TextField(
                    controller: controladorPrecio,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Precio',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                
                const SizedBox(width: 15),
                
                Expanded(
                  child: TextField(
                    controller: controladorStock,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Stock',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                
                const SizedBox(width: 15),
                
                SizedBox(
                  height: 55, 
                  child: ElevatedButton.icon(
                    onPressed: () {

                      // Validamos que el nombre no este vacio
                      if(controladorNombre.text.isNotEmpty){
                        
                        // Le avisamos a la UI que cambiand datos
                        setState(() {

                          inventario.add(
                            Insumo(
                              nombre: controladorNombre.text,
                              precio: controladorPrecio.text,
                              stock: controladorStock.text),
                          );

                          controladorNombre.clear();
                          controladorPrecio.clear();
                          controladorStock.clear();
                        });

                      }
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text('Agregar', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: inventario.length,
              itemBuilder: (BuildContext context, int index) {
                final insumoActual = inventario[index];
                return TarjetaProducto(insumo: insumoActual);
              }
            ),
          )
        ],
      )
    );
  }

  @override
  void dispose(){

    controladorNombre.dispose();
    controladorPrecio.dispose();
    controladorStock.dispose();

    super.dispose();
  } 
}

// Clase Insumo
class Insumo {
  String nombre;
  String precio;
  String stock;

  Insumo({
    required this.nombre,
    required this.precio,
    required this.stock,
  });
}

// Lista de productos, lista de instancia de Insumo
List<Insumo> inventario = [
Insumo(nombre: 'Teclado Mecánico Redragon', precio: '45000', stock: '15'),
Insumo(nombre: 'Mouse Inalámbrico Logitech', precio: '22000', stock: '8'),
Insumo(nombre: 'Monitor 24" Full HD Samsung', precio: '180000', stock: '4'),
];

// Clase del container
class TarjetaProducto extends StatelessWidget {
  final Insumo insumo;
  const TarjetaProducto({super.key, required this.insumo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blueGrey[300],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4)
          )
        ]
      ),
      child: Row(
        children: [
          const Icon(Icons.inventory_2, size: 40, color: Colors.blueAccent),
          const SizedBox(width: 15),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(insumo.nombre, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('${insumo.precio}', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              Text('${insumo.stock}', style: TextStyle(fontSize: 14, color: Colors.white)),
            ],
          ))
        ],
      ),
    );
  }
}