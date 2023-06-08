class Command {
  final String name;
  final String? description;
  final void Function() function;

  Command({required this.name, this.description, required this.function});
}
