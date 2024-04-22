import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqf;
import 'package:sqlite3/sqlite3.dart';

class SqlLiteManager {
  static late Database _database;

  // Инициализация базы данных SQLite
  static Future initializeDatabase() async {
    var databasesPath = await sqf.getDatabasesPath();
    String path = join(databasesPath, 'helps4.db');

    _database = sqlite3.open(path);

    // Создание таблицы settings, если её нет
    _database.execute('''
      CREATE TABLE IF NOT EXISTS settings (
        id INTEGER PRIMARY KEY,
        name TEXT UNIQUE,
        value INTEGER
      );
    ''');

    // Создание таблицы buffer_data, если её нет
    _database.execute('''
      CREATE TABLE IF NOT EXISTS buffer_data (
        id INTEGER PRIMARY KEY,
        data TEXT
      );
    ''');
  }

  // Вставка значения типа bool в таблицу settings
  static void insertSetting(String name, bool value) {
    _database.execute('''
    INSERT OR REPLACE INTO settings (name, value)
    VALUES (?, ?);
  ''', [name, value ? 1 : 0]);
  }

  // Получение значения типа bool из таблицы settings по имени настройки
  static bool getSetting(String name) {
    final resultSet =
        _database.select('SELECT * FROM settings WHERE name = ?', [name]);
    if (resultSet.isEmpty) {
      return false;
    } else {
      return resultSet.first['value'] == 1;
    }
  }

  // Очистка таблицы buffer_data
  static void clearBufferData() {
    _database.execute('DELETE FROM buffer_data');
  }

  // Вставка данных в таблицу buffer_data
  static void insertBufferData(String data) {
    clearBufferData();
    _database.execute('''
      INSERT INTO buffer_data (data)
      VALUES (?);
    ''', [data]);
  }

// Получение первой записи из таблицы buffer_data
  static String? getFirstBufferData() {
    final resultSet = _database.select('SELECT * FROM buffer_data LIMIT 1');
    if (resultSet.isEmpty) {
      return null;
    } else {
      return resultSet.first['data'] as String?;
    }
  }

  // Закрытие базы данных
  static closeDatabase() {
    _database.dispose();
  }
}
