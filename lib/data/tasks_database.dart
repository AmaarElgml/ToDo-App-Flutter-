import 'package:sqflite/sqflite.dart';
import 'package:todo_app/data/repository.dart';

class TasksDatabase extends Repository {
  @override
  Future<Database> create() async {
    return await openDatabase('TasksApp.db', version: 7,
        onCreate: (database, version) {
      database.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, name TEXT, complete INTEGER)');
    }, onOpen: (database) {
      db = database;
      getAll(db);
    });
  }

  @override
  Future<void> insert(String name) async {
    int completedInitialValue = 0;
    await db?.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO tasks (name, complete) VALUES("$name", "$completedInitialValue")');
    });
  }

  @override
  Future<int?> delete(int id) async {
    return await db?.rawDelete('DELETE FROM tasks WHERE id = ?', [id]);
  }

  @override
  Future<List<Map>> getAll(database) async {
    List<Map> data = [];
    await database.rawQuery('SELECT * FROM tasks').then((value) {
      data = value;
    });
    return data;
  }

  @override
  Future<void> update(int id, int complete) async {
    await db?.rawUpdate(
        'UPDATE tasks SET complete = ? WHERE id = ?', ['$complete', id]);
  }

  @override
  Future<void> clear() async {
    await db?.rawDelete('DELETE FROM tasks');
  }
}
