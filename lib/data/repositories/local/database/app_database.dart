import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path/path.dart';
import 'dart:io';

class AppDatabase {

  static Database? singleInstance ;

  static Future<Database> get instance async {
    singleInstance ??= await openDatabaseFromAsset();
    return singleInstance!;
  }



  static Future<Database> openDatabaseFromAsset() async {
    // Get the directory for storing the database
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(documentsDirectory.path, 'empform.sqlite');

    // Check if the database already exists to avoid overwriting it
    if (!await File(dbPath).exists()) {
      // If not, copy it from the assets folder
      ByteData data = await rootBundle.load('assets/database/empform.sqlite');
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes);
    }

    // Open and return the database
    return await openDatabase(dbPath);
  }

  static Future<int> insertOrUpdateRow(Database db,Map<String, dynamic> row,String tuidColName,String tableName) async {

    String id = row[tuidColName];
    List<Map<String, dynamic>> result = await db.query(
      tableName,
      where: '$tuidColName = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) {
      // Insert if not exists
      return await db.insert(tableName, row);
    } else {
      // Update if exists
      return await db.update(
        tableName,
        row,
        where: '$tuidColName = ?',
        whereArgs: [id],
      );
    }

  }



}