// import 'dart:convert';
//
// Task taskFromJson(String str) {
//   final jsonData = json.decode(str);
//   return Task.fromMap(jsonData);
// }
//
// String taskToJson(Task data) {
//   final dyn = data.toMap();
//   return json.encode(dyn);
// }
//
// class Task {
//   int id;
//   String firstName;
//   String lastName;
//   bool blocked;
//
//   Task({
//     this.id,
//     this.title,
//     this.lastName,
//     this.blocked,
//   });
//
//   factory Task.fromMap(Map<String, dynamic> json) => new Task(
//         id: json["id"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         blocked: json["blocked"] == 1,
//       );
//
//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "title": title,
//         "last_name": lastName,
//         "blocked": blocked,
//       };
// }
