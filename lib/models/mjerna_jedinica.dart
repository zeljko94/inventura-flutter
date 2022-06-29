
class MjernaJedinica {
  int? id;
  String? naziv;
  String? opis;

  MjernaJedinica({ this.naziv, this.id, this.opis });

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      'id': id,
      'naziv': naziv,
      'opis': opis
    };
  }
}