import 'dart:io';

import 'package:flutter/material.dart';
import 'package:orquideas_chilpancingo/providers/carrito_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class StorageTables {
  Future<String> getDatabase() async {
    var databasesPath = await getDatabasesPath();
    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (_) {}

    String path = databasesPath + '/cart.db';

    return path;
  }

  Future<Database> openDb(String path) async {
    Database database;
    if (await Directory(path).exists()) {
      database = await openDatabase(path);
    } else {
      database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute('''CREATE TABLE 
            Cart 
            (id TEXT PRIMARY KEY, 
            name TEXT, 
            description TEXT 
            ,price REAL, 
            image TEXT, 
            color TEXT, 
            cantidad INTEGER
            )''');
      });
    }
    return database;
  }

  void insertCart(
      {required String id,
      required String name,
      required String description,
      required double price,
      required String image,
      required String color,
      required int cantidad}) async {
    String path = await getDatabase();
    Database db = await openDb(path);

    List<Map> existid =
        await db.rawQuery('SELECT cantidad, price FROM Cart WHERE id = "$id"');
    if (existid.isEmpty) {
      await db.rawInsert('''INSERT INTO Cart(
      id, 
      name, 
      description,
      price,
      image,
      color,
      cantidad
      ) VALUES(
        "$id",
        "$name",
        "$description",
        $price,
        "$image",
        "$color",
        $cantidad
      )''');
    } else {
      int newcantidad = existid[0]["cantidad"] + cantidad;
      double newprice = existid[0]["price"] + price;
      await db.rawUpdate(
          'UPDATE Cart SET cantidad = $newcantidad, price = $newprice WHERE id = "$id"');
    }

    db.close();
  }

  Future<List<dynamic>> getCart(BuildContext context) async {
    String path = await getDatabase();
    Database db = await openDb(path);
    List<dynamic> totales = await db.rawQuery(
        'SELECT SUM(cantidad) as total , SUM(price) as pagototal FROM Cart');
    List<dynamic> carrito = await db.rawQuery('SELECT  * FROM Cart');
    Provider.of<CarritoProvider>(context, listen: false).cantidad =
        totales[0]["total"] ?? 0;
    Provider.of<CarritoProvider>(context, listen: false).totalpago =
        totales[0]["pagototal"] ?? 0;

    return carrito;
  }

  Future<List<Map>> getTotalCart() async {
    String path = await getDatabase();
    Database db = await openDb(path);
    var data = await db.rawQuery('SELECT SUM(cantidad) as total FROM Cart');
    return data;
  }

  Future<void> deleteproductCart(String id) async {
    String path = await getDatabase();
    Database db = await openDb(path);
    await db.rawDelete('DELETE FROM Cart WHERE id = "$id"');
  }
}
