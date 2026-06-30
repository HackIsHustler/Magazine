import 'package:flutter/material.dart';
import 'package:magazine/widget/widget_interface.dart';

class RedacteurInterface extends StatefulWidget{
  const RedacteurInterface({super.key});

  @override
  State<RedacteurInterface> createState() => _RedacteurInterfaceState();
}

class _RedacteurInterfaceState extends State<RedacteurInterface>{
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  List redacteur = [];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Mazagine-Infos", style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.pink,
        leading: Icon(Icons.menu, color: Colors.white,),
        actions: [
          Icon(Icons.search, color: Colors.white,)
        ],
      ),
      body: Container(
        child: ZoneFormulaire(),
      ),
    );
  }
}