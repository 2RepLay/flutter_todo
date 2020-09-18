import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

}

class HomePageState extends State<HomePage> {

  var name = "Nikita";
  var todo = [];

  var currentItem = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text("Hello, $name\nWhat's your plan for today", textAlign: TextAlign.center),
            TextField(onChanged: (text) {
              setState(() {
                this.currentItem = text;
              });
            }, style: TextStyle(letterSpacing: 2.0),),
            RaisedButton(child: Text("Add"), onPressed: () {
                setState(() {
                  Todo todo = Todo(this.currentItem, false);
                  this.todo.add(todo);
                });
            }),
            buildList()
          ],
        ),
      ),
    );
  }

  Expanded buildList() {
    return Expanded(
            child:
            this.todo.length > 0
                ? ListView.builder(
                shrinkWrap: true,
                itemCount: this.todo.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 50,
                      child: buildListItem(index)
                  );
                })
                : Center(child: const Text('No items')),
          );
  }

  Row buildListItem(index) {
    return Row(
      children: <Widget>[
        Text("${this.todo[index].title}", style: TextStyle(letterSpacing: 2.0)),
        Spacer(),
        Checkbox(onChanged: (bool value) {
          setState(() {
            this.todo[index].isFinished = value;
          });
        }, value: todo[index].isFinished),
        IconButton(icon: Icon(Icons.remove_circle), onPressed: () {
          setState(() {
            this.todo.removeAt(index);
          });
        })
      ],
    );
  }

}

class Todo {

  String title;
  bool isFinished;

  Todo(this.title, this.isFinished);

}