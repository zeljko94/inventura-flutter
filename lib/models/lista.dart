import 'package:inventura_app/models/artikl.dart';

class Lista {
  int? id;
  String? naziv;
  String? napomena;
  String? skladiste;

  Lista({ this.id, this.naziv, this.napomena, this.skladiste, this.items });

  List<Artikl>? items = [];


  
  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'id': id,
      'naziv': naziv,
      'napomena': napomena,
      'skladiste': skladiste,
    };
  }
}
