import 'package:inventura_app/models/artikl.dart';


class ListItem {
  int? id;
  int? artiklId;
  int? listId;

  ListItem({ this.id, this.artiklId, this.listId, this.artikl });

  Artikl? artikl;

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'id': id,
      'artiklId': artiklId as int,
      'listId': listId as int,
    };
  }
}

