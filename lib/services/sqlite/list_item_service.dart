
import 'package:inventura_app/models/list_item.dart';
import 'package:inventura_app/services/sqlite/sqlite_base_service.dart';
import 'package:sqflite/sqflite.dart'; //sqflite package
import 'dart:async';


class ListItemService extends SqliteBaseService {
    Future<int> add(ListItem lista) async{ //retur
    final db = await init(); //open data
    var map = lista.toMap();
    map.remove("id");
    return db.insert("ListItems", map, conflictAlgorithm: ConflictAlgorithm.ignore,);
 }

 Future<List<ListItem>> fetchAll() async{
    final db = await init();
    final maps = await db.query("ListItems");

    return List.generate(maps.length, (i) { //create a list of memos
      return ListItem(              
        id: maps[i]['id'] as int,
        listId: maps[i]['listId'] as int,
        artiklId: maps[i]['artiklId'] as int
      );
  });
  }

  Future<int> delete(int id) async{ //returns number of items deleted
    final db = await init();
  
    int result = await db.delete(
      "ListItems",
      where: "id = ?",
      whereArgs: [id] 
    );

    return result;
  }

  Future<int> update(int id, ListItem item) async{
    final db = await init();
  
    int result = await db.update(
        "ListItems", 
        item.toMap(),
        where: "id = ?",
        whereArgs: [id]
      );
      return result;
 }
}