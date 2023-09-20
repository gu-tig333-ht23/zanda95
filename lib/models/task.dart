class Task {
  final String name;
  bool isDone;
  DateTime? removalDate; // New property to store the removal date
  DateTime? completionDate; // Add completionDate property

  Task(
      {required this.name,
      this.isDone = false,
      this.removalDate,
      this.completionDate});

  void doneChange() {
    isDone = !isDone;
  }
}
