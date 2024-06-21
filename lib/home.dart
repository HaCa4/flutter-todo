import 'package:flutter/material.dart';
import 'package:flutter_forms_files/models/todo.dart';
import 'package:flutter_forms_files/todo_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // String _email = "";

  final _formGlobalKey = GlobalKey<FormState>();

  Priority _selectedPriority = Priority.low;
  String _titleValue = "";
  String _descriptionValue = "";
  // TextEditingController _emailController = TextEditingController();

  final List<Todo> todos = [
    const Todo(
        title: 'Buy milk',
        description: 'There is no milk left in the fridge!',
        priority: Priority.high),
    const Todo(
        title: 'Make the bed',
        description: 'Keep things tidy please..',
        priority: Priority.low),
    const Todo(
        title: 'Pay bills',
        description: 'The gas bill needs paying ASAP.',
        priority: Priority.urgent),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: TodoList(todos: todos)),
            Form(
                key: _formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // todo title
                    TextFormField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      maxLength: 20,
                      decoration: const InputDecoration(
                        label: const Text('Todo title'),
                        hintText: 'Enter the title of the todo',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'You must enter a value for the title.';
                        }
                        return null;
                      },
                      onSaved: (value) => _titleValue = value!,
                    ),
                    //todo description
                    TextFormField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: const Text('Todo description'),
                        hintText: 'Enter the description of the todo',
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 10) {
                          return 'Enter a description of at least 10 characters.';
                        }
                        return null;
                      },
                      onSaved: (value) => _descriptionValue = value!,
                    ),

                    //priority
                    DropdownButtonFormField(
                      value: _selectedPriority,
                      items: Priority.values.map((Priority priority) {
                        return DropdownMenuItem(
                          value: priority,
                          child: Text(priority.title),
                        );
                      }).toList(),
                      onChanged: (Priority? value) {
                        setState(() {
                          _selectedPriority = value!;
                        });
                      },
                      decoration: const InputDecoration(
                        label: const Text('Priority of todo'),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'You must select a priority.';
                        }
                        return null;
                      },
                    ),
                    //submit button
                    const SizedBox(
                      height: 20,
                    ),
                    FilledButton(
                      onPressed: () {
                        if (_formGlobalKey.currentState!.validate()) {
                          _formGlobalKey.currentState!.save();
                          setState(() {
                            todos.add(Todo(
                                title: _titleValue,
                                description: _descriptionValue,
                                priority: _selectedPriority));
                          });
                          _formGlobalKey.currentState!.reset();
                          _selectedPriority = Priority.low;
                        }
                      },
                      style: FilledButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4))),
                      child: const Text("Add"),
                    )
                  ],
                ))
            // TextField(
            //   controller: _emailController,
            //   keyboardType: TextInputType.emailAddress,
            //   // onChanged: (value) {
            //   //   setState(() {
            //   //     _email = value;
            //   //   });
            //   // },
            //   decoration: const InputDecoration(
            //     hintText: 'Enter your email',
            //     label: Text("Email"),
            //   ),
            // ),
            // const SizedBox(height: 20),
            // FilledButton(
            //     onPressed: () {
            //       print(_emailController.text.trim());
            //     },
            //     child: const Text("Print Email"))
            // // form stuff below here
          ],
        ),
      ),
    );
  }
}
