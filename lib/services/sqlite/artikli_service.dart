import 'package:inventura_app/models/artikl.dart';
import 'package:inventura_app/services/sqlite/sqlite_base_service.dart';
import 'package:sqflite/sqflite.dart'; //sqflite package
import 'dart:async';


class ArtikliService extends SqliteBaseService {


  Future<int> addArtikl(Artikl artikl) async{ //retur
    final db = await init(); //open data
    var map = artikl.toMap();
    map.remove("id");
    return db.insert("Artikli", map, conflictAlgorithm: ConflictAlgorithm.ignore,);
 }

 Future<List<Artikl>> fetchArtikli() async{
    final db = await init();
    final maps = await db.query("Artikli");

    return List.generate(maps.length, (i) { //create a list of memos
      return Artikl(              
        id: maps[i]['id'] as int,
        barkod: maps[i]['barkod'] as String,
        naziv: maps[i]['naziv'] as String,
        kod: maps[i]['kod'] as String,
        cijena: maps[i]['cijena'] as num,
        kolicina: maps[i]['kolicina'] as num,
        napomena: maps[i]['napomena'] as String,
        predefiniranaKolicina: maps[i]['predefiniranaKolicina'] as num,
      );
  });
  }

  Future<int> deleteArtikl(int id) async{ //returns number of items deleted
    final db = await init();
  
    int result = await db.delete(
      "Artikli",
      where: "id = ?",
      whereArgs: [id] 
    );

    return result;
  }

  Future<int> updateArtikl(int id, Artikl item) async{
    final db = await init();
  
    int result = await db.update(
        "Artikli", 
        item.toMap(),
        where: "id = ?",
        whereArgs: [id]
      );
      return result;
 }
}