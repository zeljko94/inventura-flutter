import 'package:flutter/material.dart';
import 'package:inventura_app/common/app_bar.dart';
import 'package:inventura_app/common/color_palette.dart';
import 'package:inventura_app/common/menu_drawer.dart';
import 'package:inventura_app/models/mjerna_jedinica.dart';
import 'package:inventura_app/services/sqlite/mjerne_jedinice_service.dart';

class AddEditMjerneJediniceScreen extends StatefulWidget {
  final MjernaJedinica? mjernaJedinica;
  const AddEditMjerneJediniceScreen({ Key? key, this.mjernaJedinica }) : super(key: key);

  @override
  _AddEditMjerneJediniceScreenState createState() => _AddEditMjerneJediniceScreenState();
}

class _AddEditMjerneJediniceScreenState extends State<AddEditMjerneJediniceScreen> {
  bool isEdit = false;
  final MjerneJediniceService? _mjerneJediniceService = MjerneJediniceService();

  final TextEditingController nazivController = TextEditingController();
  final TextEditingController opisController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

    @override
  void initState() {
    super.initState();
    
    isEdit = widget.mjernaJedinica != null;

    if(isEdit) {
      nazivController.text  = widget.mjernaJedinica!.naziv!;
      opisController.text = widget.mjernaJedinica!.opis!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar.buildAppBar(isEdit ? 'Edit mjerne jedinice' : 'Dodaj mjernu jedinicu', context),
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
                    !isEdit ? "Nova mjerna jedinica" : "Izmjeni mjernu jedinicu",
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
                children: [
                  TextFormField(
                    controller: nazivController,
                    cursorColor: ColorPalette.primary,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Naziv',
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
                        return 'Unesite naziv';
                      }
                      return null;
                    },
                    onTap: () async {
        
                    },
                  ),
                  TextFormField(
                    controller: opisController,
                    cursorColor: ColorPalette.primary,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Opis',
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
                  resetControllers();
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
                    try {

                        var mjernaJedinica = MjernaJedinica(
                          id: isEdit ? widget.mjernaJedinica!.id : 0,
                          naziv: nazivController.text,
                          opis: opisController.text
                        );

                      if(!isEdit) {
                        var inserted = await _mjerneJediniceService!.add(mjernaJedinica);
                
                        if(inserted > 0) {
                          var snackBar = const SnackBar(content: Text("Mjerna jedinica je uspješno dodana!"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          resetControllers();
                        }
                        else {
                          var snackBar = const SnackBar(content: Text("Greška prilikom dodavanja mjerne jedinice!"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                      else {
                        var updated = await _mjerneJediniceService!.update(widget.mjernaJedinica!.id!, mjernaJedinica);

                        if(updated > 0) {
                          var snackBar = const SnackBar(content: Text("Mjerna jedinica je uspješno izmjenjena!"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        else {
                          var snackBar = const SnackBar(content: Text("Greška prilikom izmjene mjerne jedinice!"));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    }
                    catch(exception) {       
                      print(exception);   
                      var snackBar = const SnackBar(content: Text("Došlo je do pogreške!"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
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

  resetControllers() {
    nazivController.clear();
    opisController.clear();
  }
}