import 'package:flutter/material.dart';
import 'package:yash_112/ToDoitem.dart';
import 'package:yash_112/todo.dart';
//import 'ToDoitem.dart';
import 'colors.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Column(children: [
                _SearchBox(),
                Expanded(
                    child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50.0, bottom: 20.0),
                      child: Text(
                        "All ToDos",
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                    for (ToDo toddo in _foundToDo.reversed)
                      ToDoItem(
                        todo: toddo,
                        onToDoChange: _handleToDoChange,
                        onDeleteItem: _deleteToDoItem,
                      ),
                  ],
                ))
              ]),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(
                          bottom: 20.0, right: 20.0, left: 20.0),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                          controller: _todoController,
                          decoration: InputDecoration(
                            hintText: 'Add a new todo item',
                            border: InputBorder.none,
                          )),
                    )),
                    Container(
                        margin: EdgeInsets.only(bottom: 20, right: 20),
                        child: ElevatedButton(
                          child: Text('+', style: TextStyle(fontSize: 40)),
                          onPressed: () {
                            _addToDoItem(_todoController.text);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: tdBlue,
                            minimumSize: Size(60, 60),
                            elevation: 10,
                          ),
                        ))
                  ],
                ))
          ],
        ));
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone!;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(
        ToDo(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          todoText: toDo,
          ToDoText: toDo,
        ),
      );
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.ToDoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30.0,
          )
        ],
      ),
    );
  }

  Widget _SearchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20.0,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20.0,
              maxWidth: 25.0,
            ),
            border: InputBorder.none,
            hintText: " Search",
            hintStyle: TextStyle(color: tdGrey)),
      ),
    );
  }
}
