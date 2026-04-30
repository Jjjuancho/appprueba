// ignore_for_file: deprecated_member_use
import 'package:appprueba/models/insumo.dart';
import 'package:appprueba/widgets/tarjeta_producto.dart';
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

  bool errorNombre = false;

  // Dentro de el state de la funcion

  void eliminar(int index){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("¿Estás seguro que queres eliminar este producto?"),
            content: Text("Esta acción no se puede deshacer."),
            actions: [

              // Boton cancelar
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancelar")
              ),
              

              // Boton de confirmar y eliminar
              TextButton(
                onPressed: () {
                  setState(() {
                    inventario.removeAt(index);
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Producto eliminado correctamente.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Text("Confirmar y eliminar")
              ),
            ],
          ); 
        }
      );
    }

  // Antes de construir UI

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
                    decoration: InputDecoration(
                      labelText: 'Nombre del producto',
                      border: const OutlineInputBorder(),
                      errorText: errorNombre ? "El nombre es necesario" : null,
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

                          errorNombre = false;
                        });

                      }else{
                        setState(() {
                          errorNombre = true;
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
                return TarjetaProducto(insumo: insumoActual, onEditar: () {}, onEliminar: () => eliminar(index));
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

// Lista de productos, lista de instancia de Insumo
List<Insumo> inventario = [
Insumo(nombre: 'Teclado Mecánico Redragon', precio: '45000', stock: '15'),
Insumo(nombre: 'Mouse Inalámbrico Logitech', precio: '22000', stock: '8'),
Insumo(nombre: 'Monitor 24" Full HD Samsung', precio: '180000', stock: '4'),
];
