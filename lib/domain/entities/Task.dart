class Task {
  final int id;
  String name;
  int complete;

  Task({
    required this.id,
    this.complete = 0,
    this.name = '',
  });

  Task.fromMap(Map data)
      : id = data['id'],
        name = data['name'],
        complete = data['complete'];

  toMap() => {'id': id, 'name': name, 'complete': complete};
}
