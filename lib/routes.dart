import 'package:inventura_app/screens/artikli/add_edit_artikl_screen.dart';
import 'package:inventura_app/screens/artikli/artikli.dart';
import 'package:inventura_app/screens/auth/login.dart';
import 'package:inventura_app/screens/dashboard.dart';
import 'package:inventura_app/screens/dodatno/mjerne_jedinice/add_edit_mjerne_jedinice.dart';
import 'package:inventura_app/screens/dodatno/mjerne_jedinice/mjerne_jedinice.dart';
import 'package:inventura_app/screens/liste/add_edit_liste_screen.dart';
import 'package:inventura_app/screens/liste/liste.dart';

var routes = {
   '/login': (ctx) => const LoginScreen(),

   '/dashboard': (ctx) => const DashboardScreen(title: 'Početna'),
   
   '/artikli': (ctx) => const ArtikliScreen(),
   '/add-edit-artikl': (ctx) => const AddEditArtiklScreen(),

   '/mjerne-jedinice': (ctx) => const MjerneJediniceScreen(),
   '/add-edit-mjerne-jedinice': (ctx) => const AddEditMjerneJediniceScreen(),

   '/liste': (ctx) => const ListeScreen(),
   '/add-edit-lista': (ctx) => const AddEditListaScreen()
};