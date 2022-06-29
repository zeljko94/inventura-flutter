import 'package:flutter/material.dart';
import 'package:inventura_app/models/user.dart';
// import 'package:intranet_it4/models/menu_items.dart';
// import 'package:intranet_it4/models/user_model.dart';
// import 'package:intranet_it4/services/auth_service.dart';

class MenuDrawer {
  // static AuthService authService = AuthService.fromAuthService();

List<Map> menuItems = [
  {
    'title': 'Početna',
    'icon': Icons.house,
    'group': false,
    'link': '/dashboard',
    'hasChildren': false,
    'claim': 'administracija.add-edit-vazni-linkovi.btnUkloniLink',
  },
  {
    'title': 'Liste',
    'icon': Icons.list,
    'group': false,
    'link': '/liste',
    'hasChildren': false,
    'claim': 'administracija.add-edit-vazni-linkovi.btnUkloniLink',
  },
  {
    'title': 'Artikli',
    'icon': Icons.article,
    'group': false,
    'link': '/artikli',
    'hasChildren': false,
    'claim': 'administracija.add-edit-vazni-linkovi.btnUkloniLink',
  },
  {
    'title': 'Dodatno',
    'icon': Icons.more_horiz,
    'group': false,
    'hasChildren': true,
    'claim': 'administracija.add-edit-vazni-linkovi.btnUkloniLink',
    'children': [
      {
        'title': 'Mjerne jedinice',
        'icon': Icons.balance,
        'group': false,
        'link': '/mjerne-jedinice',
        'hasChildren': false,
        'claim': 'administracija.add-edit-vazni-linkovi.btnUkloniLink',
      },
      {
        'title': 'Skladišta',
        'icon': Icons.storage,
        'group': false,
        'link': '/skladista',
        'hasChildren': false,
        'claim': 'administracija.add-edit-vazni-linkovi.btnUkloniLink',
      },
      {
        'title': 'Dokumenti',
        'icon': Icons.folder,
        'group': false,
        'link': '/dokumenti',
        'hasChildren': false,
        'claim': 'administracija.add-edit-vazni-linkovi.btnUkloniLink',
      },
      {
        'title': 'Kategorije',
        'icon': Icons.category,
        'group': false,
        'link': '/kategorije',
        'hasChildren': false,
        'claim': 'administracija.add-edit-vazni-linkovi.btnUkloniLink',
      },
      {
        'title': 'Tagovi',
        'icon': Icons.tag,
        'group': false,
        'link': '/tagovi',
        'hasChildren': false,
        'claim': 'administracija.add-edit-vazni-linkovi.btnUkloniLink',
      },
      {
        'title': 'Korisnici',
        'icon': Icons.person,
        'group': false,
        'link': '/korisnici',
        'hasChildren': false,
        'claim': 'administracija.add-edit-vazni-linkovi.btnUkloniLink',
      },
    ]
  },
  {
    'title': 'Import/Export konfiguracije',
    'icon': Icons.import_export,
    'group': false,
    'link': '/konfiguracije',
    'hasChildren': false,
    'claim': 'administracija.add-edit-vazni-linkovi.btnUkloniLink',
  },
  {
    'title': 'Import data',
    'icon': Icons.upload,
    'group': false,
    'link': '/import',
    'hasChildren': false,
    'claim': 'administracija.add-edit-vazni-linkovi.btnUkloniLink',
  },
  {
    'title': 'Settings',
    'icon': Icons.settings,
    'group': false,
    'link': '/postavke',
    'hasChildren': false,
    'claim': 'administracija.add-edit-vazni-linkovi.btnUkloniLink',
  },
];


  Future<List<Map>> getMenuItems() async {
    List<Map> items = [];
    User? user = User(1, 'test@test.com', 'test1', ['claim1', 'claim2']);
    items.add({'title': 'user', 'email': user.email, 'name': user.name});
    for (var element in menuItems) {
      // if (user.claims.contains(element['claim'])) {
        items.add(element);
      // }
    }
    return items;
  }

  List<Widget> getChildren(items, context) {
    List<Widget> children = [];
    for (var element in items) {
      if (element['title'] == 'user') {
        children.add(Container(
          height: 150,
          child: UserAccountsDrawerHeader(
            accountEmail: Text(element['email']),
            accountName: Text(
              element['name'],
            ),
          ),
        ));
      } else {
        if (element['group']) {
          children.add(const Divider(
            height: 10,
            thickness: 1,
          ));
          children.add(Container(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                element['title'],
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.start,
              ),
            ),
          ));
        } else {
          if (element['hasChildren']) {
            List<Widget> elementChildren = [];
            element['children'].forEach((child) {
              elementChildren.add(ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Icon(child['icon']),
              ),
                  title: Text(
                    child['title'],
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(child['link']);
                  }));
            });
            children.add(ExpansionTile(
              leading: Icon(element['icon']),
              title: Text(
                element['title'],
                style: Theme.of(context).textTheme.subtitle2,
              ),
              children: elementChildren,
            ));
          } else {
            children.add(ListTile(
                leading: Icon(element['icon']),
                title: Text(
                  element['title'],
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(element['link']);
                }));
          }
        }
      }
    }
    return children;
  }

  static getDrawer() {
    MenuDrawer menuDrawer = MenuDrawer();
    return FutureBuilder(
      future: menuDrawer.getMenuItems(),
      builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Drawer(
              child: ListView(
                  padding: EdgeInsets.zero,
                  children: menuDrawer.getChildren(snapshot.data, context)),
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
