import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../modele/redacteur.dart';

class DatabaseManager {
  static Database? _database;

  //initialisation de la base
  static Future<Database> initDb() async {
    if(_database != null) return _database!;
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'redacteurs.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE redacteurs(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nom TEXT,
          prenom TEXT,
          email TEXT
          )
        ''');
      },
    );

    return _database!;
  }

  // les methodes

  //la methode qui affiche tous les redacteurs 
  static Future<List<Redacteur>> getAllRedacteurs() async {
    final db = await initDb();
    final List<Map<String, dynamic>> maps = await db.query('redacteurs');
    return maps.map((map) => Redacteur.fromMap(map)).toList();
  }

  // la methode qui insere un redacteur
  static Future<int> insertRedacteur(Redacteur redacteur) async {
    final db = await initDb();
    return await db.insert('redacteurs', redacteur.toMap());
  }

  //mettre les infos de redacteur a jours
  static Future<int> updateRedacteur(Redacteur redacteur) async {
    final db = await initDb();
    return await db.update(
      'redacteurs',
       redacteur.toMap(),
       where: 'id =?',
       whereArgs: [redacteur.id],
       );
  }

  //supprimer un redacteur dans la base
  static Future<int> deleteRedacteur(int id) async {
    final db = await initDb();
    return await db.delete(
      'redacteurs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
