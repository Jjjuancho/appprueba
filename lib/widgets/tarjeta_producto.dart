// Clase del container
import 'package:appprueba/models/insumo.dart';
import 'package:flutter/material.dart';

class TarjetaProducto extends StatelessWidget {

  final VoidCallback onEliminar;
  final VoidCallback onEditar;

  final Insumo insumo;
  const TarjetaProducto({super.key, required this.insumo, required this.onEliminar, required this.onEditar});

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

          // ESTO ESTAMOS AGREGANDO
          CircleAvatar(
            backgroundColor: Colors.blueGrey,
            radius: 25,
            child: Text(
              insumo.nombre[0].toUpperCase(),
              style: const
                TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
          // ESTO ESTAMOS AGREGANDO

          const SizedBox(width: 15),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(insumo.nombre, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('${insumo.precio}', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              Text('${insumo.stock}', style: TextStyle(fontSize: 14, color: Colors.white)),
            ],
          )),
          IconButton(onPressed: onEditar, icon: Icon(Icons.edit, color: Colors.blue)),
          IconButton(onPressed: onEliminar, icon: Icon(Icons.delete, color: Colors.redAccent))
        ],
      ),
    );
  }
}