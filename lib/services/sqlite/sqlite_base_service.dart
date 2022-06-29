import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths
import 'dart:io';
import 'dart:async';



class SqliteBaseService {
    Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory(); //returns a directory which stores permanent files
    final path = join(directory.path,"inventura.db"); //create path to database

      return await openDatabase( //open the database or create a database if there isn't any
        path,
        version: 1,
        onCreate: (Database db,int version) async{
          await db.execute("""
          CREATE TABLE Artikli(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            barkod TEXT,
            naziv TEXT,
            kod TEXT,
            cijena NUMERIC(16,4),
            kolicina NUMERIC(16,4),
            predefiniranaKolicina NUMERIC(16,4),
            napomena TEXT
          )
          """
      );

      await db.execute("""
        CREATE TABLE MjerneJedinice(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          opis TEXT,
          naziv TEXT
        )"""
      );

      await db.execute("""
        CREATE TABLE Liste(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          naziv TEXT,
          napomena TEXT,
          skladiste TEXT
        )"""
      );

      await db.execute("""
        CREATE TABLE ListItems(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          listaId INTEGER,
          artiklId INTEGER
        );
      """);
    });
  }
}