import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:primart/page/item_page.dart';
import 'firebase_options.dart';

import 'package:primart/dashboard.dart';
import 'package:primart/config/settings.dart';
import 'package:primart/page/add_item_page.dart';
import 'package:primart/page/item_component.dart';
import 'package:primart/page/barcode_scanner.dart';
import 'package:primart/page/pencarian_page.dart';
import 'package:primart/page/test_scroll.dart';
import 'package:primart/page/item_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Primart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/dashboard': (context) => DashboardPage(),
        '/item_list': (context) => ItemList(),
        // '/item_page': (context) => itemPage(),
        '/pencarian': (context) => PencarianPage(),
        '/barcode': (context) => BarcodeScannerPage(),
      },
      home: const DashboardPage(),
    );
  }
}
