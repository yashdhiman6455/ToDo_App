class ToDo {
  String? id;
  String? ToDoText;
  bool? isDone;

  ToDo({
    required this.id,
    required this.ToDoText,
    this.isDone = false,
    required String todoText,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', ToDoText: 'Morning Exercise', isDone: true, todoText: ''),
      ToDo(id: '02', ToDoText: 'Buying Groceries', isDone: true, todoText: ''),
      ToDo(
        id: '03',
        ToDoText: 'Check Emails',
        todoText: '',
      ),
      ToDo(
        id: '04',
        ToDoText: 'Team Metting',
        todoText: '',
      ),
      ToDo(
        id: '05',
        ToDoText: 'Work on Mobile phones for 2 Hr',
        todoText: '',
      ),
      ToDo(
        id: '06',
        ToDoText: 'Dinner With Family',
        todoText: '',
      ),
    ];
  }
}
