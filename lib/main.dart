import 'package:crud_app/screen/product_gridView_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch:Colors.green,),
        title: 'Flutter CRUD APP',
        home: ProductGridViewScreen()
    );
  }
}
