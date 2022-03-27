import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:todo_list_provider/app/core/database/sqlite_migration_factory.dart';

class SqliteConnectionFactory {
  static const _version = 1;
  static const _dataBaseName = 'TODO_LIST_PROVIDER';

  static SqliteConnectionFactory? _instance;
  SqliteConnectionFactory._();
  Database? _db;
  final _lock = Lock();

  factory SqliteConnectionFactory() {
    if (_instance == null) {
      _instance = SqliteConnectionFactory._();
    }
    return _instance!;
  }
  Future<Database> openConnection() async {
    var dataBasePath = await getDatabasesPath();
    var dataBasePathFinal = join(dataBasePath, _dataBaseName);
    if (_db == null) {
      // sincroniza e impede que abra 2 conexões ao mesmo tempo
      await _lock.synchronized(() async {
        _db ??
            await openDatabase(
              dataBasePathFinal,
              version: _version,
              onConfigure: _onConfigure,
              onCreate: _onCreate,
              onUpgrade: _onUpgrade,
              onDowngrade: _onDowngrade,
            );
      });
    }
    return _db!;
  }

  void closeConnection() {
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();
    //Pega a lista de Migrations
    final migrations = SqliteMigrationFactory().getCreateMigration();
    //Executa todos os create de cada Migration
    for (var migracion in migrations) {
      migracion.create(batch);
    }

    batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {
    final batch = db.batch();
    //Pega a lista de Migrations
    final migrations = SqliteMigrationFactory().getUpgradeMigration(oldVersion);
    //Executa todos os upgrade de cada Migration
    for (var migracion in migrations) {
      migracion.upgrade(batch);
    }

    batch.commit();
  }

  Future<void> _onDowngrade(Database db, int oldVersion, int version) async {}
}
