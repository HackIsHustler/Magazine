import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../modele/redacteur.dart';

class DatabaseManager {
  static Database? _database;

  // Initialisation de la base
  static Future<Database> initDb() async {
    if (_database != null) return _database!;
    try {
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
    } catch (e) {
      throw Exception("Erreur lors de l'initialisation de la base : $e");
    }
  }

  // Méthode pour fermer la base
  static Future<void> closeDb() async {
    try {
      final db = _database;
      if (db != null) {
        await db.close();
        _database = null;
      }
    } catch (e) {
      throw Exception("Erreur lors de la fermeture de la base : $e");
    }
  }

  // Afficher tous les rédacteurs
  static Future<List<Redacteur>> getAllRedacteurs() async {
    try {
      final db = await initDb();
      final List<Map<String, dynamic>> maps = await db.query('redacteurs');
      return maps.map((map) => Redacteur.fromMap(map)).toList();
    } catch (e) {
      throw Exception("Erreur lors de la récupération des rédacteurs : $e");
    }
  }

  // Insérer un rédacteur
  static Future<int> insertRedacteur(Redacteur redacteur) async {
    try {
      final db = await initDb();
      return await db.insert('redacteurs', redacteur.toMap());
    } catch (e) {
      throw Exception("Erreur lors de l'insertion du rédacteur : $e");
    }
  }

  // Mettre à jour un rédacteur
  static Future<int> updateRedacteur(Redacteur redacteur) async {
    try {
      final db = await initDb();
      return await db.update(
        'redacteurs',
        redacteur.toMap(),
        where: 'id = ?',
        whereArgs: [redacteur.id],
      );
    } catch (e) {
      throw Exception("Erreur lors de la mise à jour du rédacteur : $e");
    }
  }

  // Supprimer un rédacteur
  static Future<int> deleteRedacteur(int id) async {
    try {
      final db = await initDb();
      return await db.delete(
        'redacteurs',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception("Erreur lors de la suppression du rédacteur : $e");
    }
  }
}
