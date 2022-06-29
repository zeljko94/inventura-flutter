import 'package:inventura_app/models/mjerna_jedinica.dart';
import 'package:inventura_app/services/sqlite/sqlite_base_service.dart';
import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths
import 'dart:io';
import 'dart:async';

class MjerneJediniceService extends SqliteBaseService {


  Future<int> add(MjernaJedinica mjJed) async{ 
    final db = await init(); //open database
    var map = mjJed.toMap();
    map.remove("id");
    return db.insert("MjerneJedinice", map, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

 Future<List<MjernaJedinica>> fetchAll() async {
    final db = await init();
    final maps = await db.query("MjerneJedinice");

    return List.generate(maps.length, (i) {
      return MjernaJedinica(              
        id: maps[i]['id'] as int,
        naziv: maps[i]['naziv'] as String,
        opis: maps[i]['opis'] as String
      );
  });
  }

  Future<int> delete(int id) async{ //returns number of items deleted
    final db = await init();
  
    int result = await db.delete(
      "MjerneJedinice",
      where: "id = ?",
      whereArgs: [id] 
    );

    return result;
  }

  Future<int> update(int id, MjernaJedinica item) async{
    final db = await init();
  
    int result = await db.update(
        "MjerneJedinice", 
        item.toMap(),
        where: "id = ?",
        whereArgs: [id]
      );
      return result;
 }
}