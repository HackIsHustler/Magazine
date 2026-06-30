import 'package:flutter/material.dart';

class ZoneFormulaire extends StatelessWidget{
  const ZoneFormulaire({super.key});

  @override
  Widget build(BuildContext context){
    return Center(
      child: Column(
        children: [
          TextField(
           // controller: nomController,
            decoration: InputDecoration(labelText: "Nom" ),
          ),
          TextField(decoration: InputDecoration(labelText: "Prenom"),),
          TextField(decoration: InputDecoration(labelText: "Email"),),
          SizedBox(height: 8,),
          ElevatedButton.icon(
            onPressed: (){}, 
            icon: Icon(Icons.add),
            label: Text("ajouter un Redacteur"),
            
            )
        ],
      ),
    );
  }
}