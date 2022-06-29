import 'package:flutter/material.dart';
import 'package:inventura_app/common/app_bar.dart';
import 'package:inventura_app/common/color_palette.dart';
import 'package:inventura_app/common/menu_drawer.dart';
import 'package:inventura_app/models/lista.dart';
import 'package:inventura_app/screens/liste/add_edit_liste_screen.dart';
import 'package:inventura_app/services/sqlite/liste_service.dart';

class ListeScreen extends StatefulWidget {
  const ListeScreen({ Key? key }) : super(key: key);

  @override
  _ListeScreenState createState() => _ListeScreenState();
}

class _ListeScreenState extends State<ListeScreen> {
  List<Lista> liste = [];
  final ListeService? _listeService = ListeService();

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    fetchListe();
  }

  fetchListe() {
    Future.delayed(Duration.zero, () async {
      var listeData = await _listeService!.fetchAll();
      setState(() {
        liste = listeData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar.buildAppBar('Liste', context),
      body: _buildBody(),
      drawer: MenuDrawer.getDrawer(),
      floatingActionButton: _buildButton(),
    );
  }
  
  _buildBody() {
    return Column(
      children: [
        TextFormField(
          controller: searchController,
          cursorColor: ColorPalette.primary,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: UnderlineInputBorder(),
            labelText: 'Search',
            floatingLabelStyle:
                TextStyle(color: Color.fromARGB(255, 0, 95, 55)),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 0, 95, 55),
                  width: 2.0),
            ),
          ),
          validator: (value) {
            return null;
          },
          onTap: () async {

          },
        ),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: liste.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
              child: Card(
                  child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            settings: const RouteSettings(name: '/add-edit-lista'),
                            builder: (context) => AddEditListaScreen(
                              lista: liste[index],
                              onAddLista: fetchListe,
                              onUpdateLista: fetchListe,
                            ),
                          ),
                        );
                      },
                      onLongPress: () async {
                        await _deleteLista(liste[index].id!);
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(liste[index].naziv!),
                              Text(liste[index].skladiste!)
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Broj itema: 3')
                          ],)
                        ],
                      ),)),
            );
          },
        ),
      ],
    );
  }
  
  _buildButton() {
    return FloatingActionButton(
          heroTag: null,
          backgroundColor: ColorPalette.info,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                settings: const RouteSettings(name: '/add-edit-lista'),
                builder: (context) => AddEditListaScreen(
                  onAddLista: fetchListe,
                  onUpdateLista: fetchListe,
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        );
  }

  _deleteLista(int id) async {
    var deleted = await _listeService!.delete(id);

    if(deleted > 0 ) {
      var snackBar = const SnackBar(content: Text("Lista uspješno obrisana!"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      fetchListe();
    }
  }
}