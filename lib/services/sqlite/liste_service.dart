
import 'package:inventura_app/models/artikl.dart';
import 'package:inventura_app/models/lista.dart';
import 'package:inventura_app/services/sqlite/list_item_service.dart';
import 'package:inventura_app/services/sqlite/sqlite_base_service.dart';
import 'package:sqflite/sqflite.dart'; //sqflite package
import 'dart:async';


class ListeService extends SqliteBaseService {
    final ListItemService? _listItemService = ListItemService();

    Future<int> add(Lista lista) async{ //retur
    final db = await init(); //open data
    var map = lista.toMap();
    map.remove("id");
    return db.insert("Liste", map, conflictAlgorithm: ConflictAlgorithm.ignore,);
 }

 Future<List<Lista>> fetchAll() async{
    final db = await init();
    final maps = await db.query("Liste");

    return List.generate(maps.length, (i) { //create a list of memos
      return Lista(              
        id: maps[i]['id'] as int,
        naziv: maps[i]['naziv'] as String,
        napomena: maps[i]['napomena'] as String,
        skladiste: maps[i]['skladiste'] as String,
      );
  });
  }

  Future<List<Artikl>> getArtikleByListId(int listId) async {

  }

  Future<int> delete(int id) async{ //returns number of items deleted
    final db = await init();
  
    int result = await db.delete(
      "Liste",
      where: "id = ?",
      whereArgs: [id] 
    );

    return result;
  }

  Future<int> update(int id, Lista item) async{
    final db = await init();
  
    int result = await db.update(
        "Liste", 
        item.toMap(),
        where: "id = ?",
        whereArgs: [id]
      );
      return result;
 }
}