
import 'package:registro_ponto/model/registroPonto.dart';
import 'package:sqflite/sqflite.dart';

class Provider {
  static const _dbName = 'registro-ponto.db';
  static const _dbVersion = 1;

  Provider._init();
  static final Provider instance = Provider._init();

  Database? _database;

  Future<Database> get database async => _database ??=await _initDatabase();

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = '$databasesPath/$_dbName';

    return await openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        '''
          CREATE TABLE registro (
            ${RegistroPonto.ID} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${RegistroPonto.DATA_HORA} TEXT NOT NULL,
            ${RegistroPonto.LATITUDE} REAL NOT NULL,
            ${RegistroPonto.LONGITUDE} REAL NOT NULL
          );  
        '''
    );
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
    }
  }
}