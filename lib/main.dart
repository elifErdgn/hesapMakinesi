import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../bindings/my_bindings.dart';
import 'package:flutter/services.dart';

import 'controller/theme_model.dart';
import 'home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); /// Basit bir cevap, Flutter'ın runApp'ı çağırmadan önce yerel kodu çağırması gerekiyorsa,
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);/// ekranın yan çevrilmesi
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (((context) => ThemeModel())),
      child: Consumer(
        builder: (context, ThemeModel themeNotifier, child) {
          return GetMaterialApp(
            theme: ThemeData(useMaterial3: true),
            debugShowCheckedModeBanner: false,
            initialBinding: MyBindings(),
            title: "Flutter Calculator", 
            home: MyHomePage(),
          );
        },
      ),
    );
  }
}
