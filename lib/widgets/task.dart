
class Task {
  Task({
    required this.title,
    required this.checked,
  });

  final String title;
  final bool checked;

  Task copyWith({
    String? title,
    bool? checked,
  }) {
    return Task(
      title: title ?? this.title,
      checked: checked ?? this.checked,
    );
  }
}