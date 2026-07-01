import 'package:flutter/material.dart';
import './views/redacteur_interface.dart';

void main (){
  runApp(MonApplication());
}

class MonApplication extends StatelessWidget{
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
    title: 'Gestions des redacteurs',
    debugShowCheckedModeBanner: false,
    home: RedacteurInterface()
   );
  }
}