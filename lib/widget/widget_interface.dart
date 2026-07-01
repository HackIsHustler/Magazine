import 'package:flutter/material.dart';

//wiget pour afficher la zone de formulaire

class ZoneFormulaire extends StatelessWidget{
  final TextEditingController nomController;
  final TextEditingController prenomController;
  final TextEditingController emailController;
  final VoidCallback onAdd;

  const ZoneFormulaire({
    super.key,
    required this.nomController,
    required this.prenomController,
    required this.emailController,
    required this.onAdd
    });

  @override
  Widget build(BuildContext context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nomController,
              decoration: InputDecoration(labelText: "Nom" ),
            ),
            TextField(
              controller: prenomController,
              decoration: InputDecoration(labelText: "Prenom"),
              ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
              ),
            SizedBox(height: 8,),
            ElevatedButton.icon(
              onPressed: (){
                if (nomController.text.isEmpty || prenomController.text.isEmpty || emailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Veuillez remplir tous les champs"),
                    backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                //verifier si l'email est valide
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(emailController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Veuillez entrer un email valide"),
                    backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                onAdd();
              },
              icon: Icon(Icons.add),
              label: Text("ajouter un Redacteur"),
              
              )
          ],
        ),
      ),
    );
  }
}

//widget pour afficher les redacteurs en chef

class RedacteurItem extends StatelessWidget{
  final String nom;
  final String prenom;
  final String email;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const RedacteurItem({
    super.key,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.onEdit,
    required this.onDelete
  });

  @override
  Widget build(BuildContext context) {
   return ListTile(
    title: Text("$nom $prenom"),
    subtitle: Text(email),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onEdit, 
          icon: Icon(Icons.edit)
          ),
        IconButton(
          onPressed: onDelete, 
          icon: Icon(Icons.delete)
          )
      ],
    ),
   );
  }
}