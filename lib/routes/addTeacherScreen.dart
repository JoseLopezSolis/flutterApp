import 'package:flutter/material.dart';
import 'dart:convert';

class Teacher {
  String name;
  String lastName;
  String dob;

  Teacher({
    required this.name,
    required this.lastName,
    required this.dob,
  });
}

class AddTeacherScreen extends StatefulWidget {
  @override
  _AddTeacherFormState createState() => _AddTeacherFormState();
}

class _AddTeacherFormState extends State<AddTeacherScreen> {
  var id = 0;
  var dataBase = {'teachers': []};
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, create a Teacher instance and store the data
      final teacher = Teacher(
        name: _nameController.text,
        lastName: _lastNameController.text,
        dob: _dobController.text,
      );

      var newTeacher = {
        'id': id.toString(),
        "name": teacher.name,
        "lastName": teacher.lastName,
        "dob": teacher.dob,
      };
      dataBase['teachers']?.add(newTeacher);

      // Save the newTeacher object to local storage
      print('Teacher saved to local storage.');
      id++;

      // Reset the form
      _formKey.currentState!.reset();

      // Trigger rebuild of the widget to update the table
      setState(() {});
    }
  }

  void _editTeacher(int index) {
    final teacher = dataBase['teachers']?[index];
    // Update the form fields with the teacher's data for editing
    _nameController.text = teacher['name'];
    _lastNameController.text = teacher['lastName'];
    _dobController.text = teacher['dob'];
    // Remove the teacher from the list
    dataBase['teachers']?.removeAt(index);

    // Trigger rebuild of the widget to update the table
    setState(() {});
  }

  void _deleteTeacher(int index) {
    // Remove the teacher from the list
    dataBase['teachers']?.removeAt(index);

    // Trigger rebuild of the widget to update the table
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Teacher'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(labelText: 'Date of Birth'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a date of birth';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
              SizedBox(height: 32.0),
              Text(
                'Registers:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DataTable(
                columns: const <DataColumn>[
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Last Name')),
                  DataColumn(label: Text('Date of Birth')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: List<DataRow>.generate(
                  dataBase['teachers']!.length,
                  (index) {
                    var teacher = dataBase['teachers']![index];
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text(teacher['id'].toString())),
                        DataCell(Text(teacher['name']!)),
                        DataCell(Text(teacher['lastName']!)),
                        DataCell(Text(teacher['dob']!)),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => _editTeacher(index),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => _deleteTeacher(index),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AddTeacherScreen(),
  ));
}
