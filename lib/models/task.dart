class Task {
  final String id;
  final String name;
  bool done;
  DateTime? removalDate;
  DateTime? completionDate;

  Task({
    required this.id,
    required this.name,
    this.done = false,
    this.removalDate,
    this.completionDate,
  });
}
