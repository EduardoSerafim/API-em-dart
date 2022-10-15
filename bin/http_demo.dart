import 'dart:convert';
import 'package:http/http.dart' as http;

void main(List<String> args) async {
  Todo todo = await getTodo(5);
  print(todo.title);
  print(todo.completed);

  print("--------");

  List<Todo> todos = await getTodos();
  print(todos[0].id);
  print(todos[0].title);
  print(todos[0].completed);

  await deleteTodo(3);
  
}

Future<Todo> getTodo(int id) async {
   var uri = "https://jsonplaceholder.typicode.com/todos/${id}";

  var response = await http.get(Uri.parse(uri));

  Map map = jsonDecode(response.body);
  Todo todo = Todo.fromJson(map);
  return todo;
}

Future<void> deleteTodo(int id) async {
  var uri = "https://jsonplaceholder.typicode.com/todos/${id}";

  var response = await http.delete(Uri.parse(uri));

  if(response.statusCode != 200){
    throw Exception();
  }
}


Future<List<Todo>> getTodos() async {
  var uri = "https://jsonplaceholder.typicode.com/todos";
  var response = await http.get(Uri.parse(uri));
  var list = jsonDecode(response.body);

  var todos = list.map<Todo>((json) => Todo.fromJson(json)).toList();

  
  return todos;
}


class Todo{
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todo({
    required this.userId, 
    required this.id, 
    required this.title, 
    required this.completed
  });

  factory Todo.fromJson(Map map){
  return Todo(
    userId: map['userId'], 
    id: map['id'], 
    title:map['title'], 
    completed: map['completed']
  );
  }


}