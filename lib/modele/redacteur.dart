
class Redacteur{
  final int? id;
  final String nom;
  final String prenom;
  final String email;

  //constructeur avec tous les attributs
  const Redacteur({
    required this.id, 
    required this.nom, 
    required this.prenom, 
    required this.email
    });

  //construteur avec des attributs sans le id
  const Redacteur.sansId({ 
    required this.nom, 
    required this.prenom, 
    required this.email
    }): id = null;

  //Transformer un objet redacteur en map
  Map<String, dynamic> toMap() {
    return{
      'id':id,
      'nom': nom,
      'prenom': prenom,
      'email': email
    };
  }

//methode de reconstruction dun redacteur en map
  factory Redacteur.fromMap(Map<String, dynamic> map){
    return Redacteur(
      id: map['id'], 
      nom: map['nom'], 
      prenom: map['prenom'], 
      email: map['email']
      );
  }

}