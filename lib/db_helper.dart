import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  // Database getter
  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  // Database initialization
  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'wedding.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Tasks table
        await db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            notes TEXT,
            done INTEGER
          )
        ''');

        // Users table
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT
          )
        ''');

        // Guests table
        await db.execute('''
          CREATE TABLE guests(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            rsvp INTEGER
          )
        ''');
      },
    );
  }

  // Insert Task
  static Future<int> insertTask(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('tasks', data);
  }

  // Fetch Tasks
  static Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await database;
    return await db.query('tasks');
  }

  // Update Task
  static Future<int> updateTask(int id, Map<String, dynamic> data) async {
    final db = await database;
    return await db.update('tasks', data, where: 'id=?', whereArgs: [id]);
  }

  // Delete Task
  static Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete('tasks', where: 'id=?', whereArgs: [id]);
  }

  // Insert Guest
  static Future<int> insertGuest(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('guests', data);
  }

  // Fetch Guests
  static Future<List<Map<String, dynamic>>> getGuests() async {
    final db = await database;
    return await db.query('guests');
  }

  // Update Guest (RSVP toggle)
  static Future<int> updateGuest(int id, Map<String, dynamic> data) async {
    final db = await database;
    return await db.update('guests', data, where: 'id=?', whereArgs: [id]);
  }

  // Delete Guest
  static Future<int> deleteGuest(int id) async {
    final db = await database;
    return await db.delete('guests', where: 'id=?', whereArgs: [id]);
  }
}