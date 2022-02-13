import 'package:todo_app/data/repository.dart';
import 'package:todo_app/data/tasks_database.dart';
import 'entities/Task.dart';

class TaskServices {
  final Repository _repository = TasksDatabase();
  bool created = false;

  createDatabase() {
    created = true;
    return _repository.create();
  }

  Future<void> insert(String name) async {
    return await _repository.insert(name);
  }

  Future<List<Task>> getAll() async {
    if (!created) await createDatabase();
    List<Task> tasks = [];
    await _repository.getAll(_repository.db).then((value) {
      value.forEach((element) {
        tasks.add(Task.fromMap(element));
      });
    });
    return tasks;
  }

  Future<void> update(int id, int complete) async {
    return await _repository.update(id, complete);
  }

  Future<int?> delete(int id) async {
    return await _repository.delete(id);
  }

  Future<void> clearDB() async {
    return await _repository.clear();
  }
}
