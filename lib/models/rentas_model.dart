import 'package:flutter/material.dart';

class Renta {
  int? rentaId;
  DateTime? fecha_inicio;
  DateTime? fecha_final;
  String? direccion_entrega;
  String? notas;
  List<Estado_renta>? estado_renta;
  List<Cliente>? cliente;

  Renta(
      {this.rentaId,
      this.fecha_inicio,
      this.fecha_final,
      this.notas,
      this.direccion_entrega,
      this.estado_renta,
      this.cliente});

  factory Renta.fromMap(Map<String, dynamic> renta) {
    return Renta(
      rentaId: renta['rentaId'],
      fecha_inicio: renta['fecha_inicio'],
      fecha_final: renta['fecha_final'],
      direccion_entrega: renta['direccion_entrega'],
      notas: renta['notas'],
      estado_renta: [],
      cliente: [],
    );
  }
}

class Cliente {
  int? clienteId;
  String? nombre;
  String? correo;
  String? num_telefono;

  Cliente({
    this.clienteId,
    this.nombre,
    this.correo,
    this.num_telefono,
  });

  factory Cliente.fromMap(Map<String, dynamic> cliente) {
    return Cliente(
      clienteId: cliente['clienteId'],
      nombre: cliente['nombre'],
      correo: cliente['correo'],
      num_telefono: cliente['num_telefono'],
    );
  }
}

class Mobiliario {
  int? mobiliarioId;
  String? nombre;
  int? cantidad_disponible;
  double? precio_unitario_dia;
  List<Categoria>? categoria;

  Mobiliario({
    this.mobiliarioId,
    this.nombre,
    this.cantidad_disponible,
    this.precio_unitario_dia,
    this.categoria,
  });

  factory Mobiliario.fromMap(Map<String, dynamic> mobiliario) {
    return Mobiliario(
      mobiliarioId: mobiliario['mobiliarioId'],
      nombre: mobiliario['nombre'],
      cantidad_disponible: mobiliario['cantidad_disponible'],
      precio_unitario_dia: mobiliario['precio_unitario_dia'],
      categoria: [],
    );
  }
}

class Estado_renta {
  int? estado_rentaId;
  String? estado;

  Estado_renta({
    this.estado_rentaId,
    this.estado,
  });

  factory Estado_renta.fromMap(Map<String, dynamic> estado_renta) {
    return Estado_renta(
      estado_rentaId: estado_renta['estado_rentaId'],
      estado: estado_renta['estado'],
    );
  }
}

class Categoria {
  int? categoriaId;
  String? categoria;

  Categoria({this.categoriaId, this.categoria});

  factory Categoria.fromMap(Map<String, dynamic> categoria) {
    return Categoria(
      categoriaId: categoria['categoriaId'],
      categoria: categoria['categoria'],
    );
  }
}

class Detalle_renta {
  int? detalle_rentaId;
  List<Renta>? renta;
  List<Mobiliario>? mobiliario;
  int? cantidad_rentada;

  Detalle_renta({
    this.detalle_rentaId,
    this.renta,
    this.mobiliario,
    this.cantidad_rentada,
  });

  factory Detalle_renta.fromMap(Map<String, dynamic> detalle_renta) {
    return Detalle_renta(
      detalle_rentaId: detalle_renta['detalle_rentaId'],
      renta: [],
      mobiliario: [],
      cantidad_rentada: detalle_renta['cantidad_rentada'],
    );
  }
}
