import 'package:flutter/material.dart';
import 'package:magazine/modele/redacteur.dart';
import 'package:magazine/widget/widget_interface.dart';
import '../services/database_manager.dart';

class RedacteurInterface extends StatefulWidget {
  const RedacteurInterface({super.key});

  @override
  State<RedacteurInterface> createState() => _RedacteurInterfaceState();
}

class _RedacteurInterfaceState extends State<RedacteurInterface> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  List<Redacteur> redacteurs = [];

  @override
  void initState() {
    super.initState();
    chargerRedacteurs();
  }

  //recharger la liste des redacteurs
  void chargerRedacteurs() async {
    final donnees = await DatabaseManager.getAllRedacteurs();
    setState(() {
      redacteurs = donnees;
    });
  }

  //ajouter les redacteurs
  void ajouterRedacteur() async {
    await DatabaseManager.insertRedacteur(
      Redacteur.sansId(
        nom: nomController.text,
        prenom: prenomController.text,
        email: emailController.text,
      ),
    );

    //vider les champs apres insertion
    nomController.clear();
    prenomController.clear();
    emailController.clear();

    //recharge la liste
    chargerRedacteurs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Mazagine-Infos", style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.pink,
        leading: Icon(Icons.menu, color: Colors.white),
        actions: [Icon(Icons.search, color: Colors.white)],
      ),
      body: Column(
        children: [
          ZoneFormulaire(
            nomController: nomController,
            prenomController: prenomController,
            emailController: emailController,
            onAdd: ajouterRedacteur,
          ),

          const Divider(),
          //liste des redacteurs
          Expanded(
            child: redacteurs.isEmpty
                ? const Center(child: Text("Aucun redcateur pour le moment"))
                : ListView.builder(
                    itemCount: redacteurs.length,
                    itemBuilder: (context, index) {
                      final r = redacteurs[index];
                      return RedacteurItem(
                        nom: r.nom,
                        prenom: r.prenom,
                        email: r.email,
                        onEdit: () {
                          showDialog(
                            context: context, 
                            builder: (BuildContext ctx){
                              final TextEditingController nomEditController = TextEditingController(text: r.nom);
                              final TextEditingController prenomEditController = TextEditingController(text: r.prenom);
                              final TextEditingController emailEditController = TextEditingController(text: r.email);
                              return AlertDialog(
                                title: const Text("Modifier le redacteur"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: nomEditController,
                                      decoration: const InputDecoration(labelText: "Nom"),
                                    ),
                                    TextField(
                                      controller: prenomEditController,
                                      decoration: const InputDecoration(labelText: "Prenom"),
                                    ),
                                    TextField(
                                      controller: emailEditController,
                                      decoration: const InputDecoration(labelText: "Email"),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text("Annuler"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final redacteurModifie = Redacteur(
                                        id: r.id,
                                        nom: nomEditController.text,
                                        prenom: prenomEditController.text,
                                        email: emailEditController.text,
                                      );
                                      await DatabaseManager.updateRedacteur(redacteurModifie);
                                      Navigator.of(ctx).pop();
                                      chargerRedacteurs();
                                    },
                                    child: const Text("Enregistrer"),
                                  ),
                                ],
                              );
                            }
                            );
                        },
                        onDelete: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext ctx) {
                              return AlertDialog(
                                title: const Text("Confirmation"),
                                content: const Text(
                                  "Voulez-vous vraiment supprimer ce redacteur ?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text("Annuler"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await DatabaseManager.deleteRedacteur(
                                        r.id!,
                                      );
                                      Navigator.of(ctx).pop();
                                      chargerRedacteurs();
                                    },
                                    child: const Text("Supprimer"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
