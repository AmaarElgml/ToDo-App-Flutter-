import 'package:sqflite/sqflite.dart';

abstract class Repository {
  Future<Database> create();

  Future<void> insert(String name);

  Future<List<Map>> getAll(database);

  Future<void> update(int id, int complete);

  Future<int?> delete(int id);

  Future<void> clear();

  Database? db;
}
