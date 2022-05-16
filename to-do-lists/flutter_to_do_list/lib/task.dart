class Task {
  final String id;
  final String title;

  const Task({required this.id, required this.title});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['task'],
    );
  }
}
