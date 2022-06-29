import 'package:flutter/material.dart';
import 'package:inventura_app/common/app_bar.dart';
import 'package:inventura_app/common/color_palette.dart';
import 'package:inventura_app/common/menu_drawer.dart';
import 'package:inventura_app/models/artikl.dart';
import 'package:inventura_app/models/lista.dart';
import 'package:inventura_app/services/sqlite/liste_service.dart';

class AddEditListaScreen extends StatefulWidget {
  final Lista? lista;
  final Function? onAddLista, onUpdateLista;
  const AddEditListaScreen({ Key? key, this.lista, this.onAddLista, this.onUpdateLista }) : super(key: key);

  @override
  _AddEditListaScreenState createState() => _AddEditListaScreenState();
}

class _AddEditListaScreenState extends State<AddEditListaScreen> {
  final ListeService? _listeService = ListeService();
  bool isEdit = false;
  List<Artikl> dodaniArtikli = [];


  final TextEditingController nazivController = TextEditingController();
  final TextEditingController skladisteController = TextEditingController();
  final TextEditingController napomenaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    
    isEdit = widget.lista != null;

    if(isEdit) {
      nazivController.text = widget.lista!.naziv!;
      skladisteController.text = widget.lista!.skladiste!;
      napomenaController.text = widget.lista!.napomena!;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar.buildAppBar('Edit list', context),
      body: _buildBody(),
      drawer: MenuDrawer.getDrawer(),
      floatingActionButton: _buildButton(),
    );
  }
  
  _buildBody() {
    
      return StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
          Row(
            children: [
              Icon(
                !isEdit ? Icons.add_box_outlined : Icons.mode_edit_outline,
                color: ColorPalette.primary,
                size: 30.0,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    !isEdit ? "Nova lista" : "Izmjeni listu",
                    style: Theme.of(context).textTheme.headline6,
                  ),
              )
            ],
          ),
          Form(
            key: _formKey,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: (Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: nazivController,
                    cursorColor: ColorPalette.primary,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Naziv liste',
                      floatingLabelStyle:
                          TextStyle(color: ColorPalette.primary),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorPalette.primary,
                            width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite naziv liste';
                      }
                      return null;
                    },
                    onTap: () async {
        
                    },
                  ),
                  TextFormField(
                    controller: skladisteController,
                    cursorColor: ColorPalette.primary,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Skladište',
                      floatingLabelStyle:
                          TextStyle(color: ColorPalette.primary),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorPalette.primary,
                            width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Unesite naziv skladišta';
                      }
                      return null;
                    },
                    onTap: () async {
        
                    },
                  ),
                  TextFormField(
                    controller: napomenaController,
                    cursorColor: ColorPalette.primary,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Napomena',
                      floatingLabelStyle:
                          TextStyle(color: ColorPalette.primary),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorPalette.primary,
                            width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      return null;
                    },
                    onTap: () async {
        
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, ),
                    child: const Text('Artikli:'),
                  )
                ],
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  primary: ColorPalette.primary,
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () async{
                  Navigator.pop(context, 'Odustani');
                  _resetControllers();
                },
                child: const Text('Odustani'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: ColorPalette.primary,
                  primary: const Color.fromARGB(255, 255, 255, 255),
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {

                    // buildLoadingSpinner(context);
                    // try {


                      var lista = Lista(
                        id: isEdit ? widget.lista!.id! : 0,
                        naziv: nazivController.text,
                        skladiste: skladisteController.text,
                        napomena: napomenaController.text
                      );

                      if(!isEdit) {
                        var inserted = await _listeService!.add(lista);
                
                        if(inserted > 0) {
                          var snackBar = const SnackBar(content: Text("Lista je uspješno dodana!"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          _resetControllers();
                          widget.onAddLista!();
                          Navigator.of(context).pop();
                        }
                        else {
                          var snackBar = const SnackBar(content: Text("Greška prilikom dodavanja liste!"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                      else {
                        var updated = await _listeService!.update(widget.lista!.id!, lista);

                        if(updated > 0) {
                          var snackBar = const SnackBar(content: Text("Artikl je uspješno izmjenjen!"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          widget.onUpdateLista!();
                          Navigator.of(context).pop();
                        }
                        else {
                          var snackBar = const SnackBar(content: Text("Greška prilikom izmjene artikla!"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    // }
                    // catch(exception) {          
                    //   var snackBar = const SnackBar(content: Text("Došlo je do pogreške!"));
                    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    //   print("Exception");
                    //   print(exception);
                    // }
                     
                    // await Future.delayed(const Duration(seconds: 1));
                    // removeLoadingSpinner(context);
                  }
                },
                child: const Text('Spremi'),
              ),
            ]),
          )
          ],),
        );
    });
  }
  
  _buildButton() {}

  _resetControllers() {
    nazivController.clear();
    skladisteController.clear();
    napomenaController.clear();
  }
}