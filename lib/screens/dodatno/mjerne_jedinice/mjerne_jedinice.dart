import 'package:flutter/material.dart';
import 'package:inventura_app/common/app_bar.dart';
import 'package:inventura_app/common/color_palette.dart';
import 'package:inventura_app/common/menu_drawer.dart';
import 'package:inventura_app/models/mjerna_jedinica.dart';
import 'package:inventura_app/screens/dodatno/mjerne_jedinice/add_edit_mjerne_jedinice.dart';
import 'package:inventura_app/services/sqlite/mjerne_jedinice_service.dart';

class MjerneJediniceScreen extends StatefulWidget {
  const MjerneJediniceScreen({ Key? key }) : super(key: key);

  @override
  _MjerneJediniceScreenState createState() => _MjerneJediniceScreenState();
}

class _MjerneJediniceScreenState extends State<MjerneJediniceScreen> {
  List<MjernaJedinica> mjerneJedinice = [];
  final MjerneJediniceService? _mjerneJediniceService = MjerneJediniceService();

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    Future.delayed(Duration.zero, () async {
      var mjerneJediniceData = await _mjerneJediniceService!.fetchAll();
      setState(() {
        mjerneJedinice = mjerneJediniceData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar.buildAppBar('Mjerne jedinice', context),
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
          itemCount: mjerneJedinice.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
              child: Card(
                  child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            settings: const RouteSettings(name: '/add-edit-artikl'),
                            builder: (context) => AddEditMjerneJediniceScreen(
                              mjernaJedinica: mjerneJedinice[index]
                            ),
                          ),
                        );
                      },
                      onLongPress: () async {
                        await _deleteMjernaJedinica(mjerneJedinice[index].id!);
                      },
                      title: Text(mjerneJedinice[index].naziv!),)),
            );
          },
        ),
      ],
    );
  }
  
  _deleteMjernaJedinica(int id) async {
    var deleted = await _mjerneJediniceService!.delete(id);

    if(deleted > 0 ) {
      var snackBar = const SnackBar(content: Text("Mjerna jedinica uspješno obrisana!"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  _buildButton() {
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: ColorPalette.info,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            settings: const RouteSettings(name: '/add-edit-mjerne-jedinice'),
            builder: (context) => const AddEditMjerneJediniceScreen(),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}