import 'package:flutter/material.dart';
import 'dart:convert';

class Student {
  String name;
  String lastName;
  String dob;
  List<String> grades;

  Student({
    required this.name,
    required this.lastName,
    required this.dob,
    required this.grades,
  });
}

class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentFormState createState() => _AddStudentFormState();
}

class _AddStudentFormState extends State<AddStudentScreen> {
  var id = 0;
  var dataBase = {'students': []};
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();
  final List<TextEditingController> _gradeControllers =
      List.generate(8, (_) => TextEditingController());

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _gradeControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, create a Student instance and store the data
      final student = Student(
        name: _nameController.text,
        lastName: _lastNameController.text,
        dob: _dobController.text,
        grades: _gradeControllers.map((controller) => controller.text).toList(),
      );

      var newStudent = {
        'id': id.toString(),
        "name": student.name,
        "fatherLastname": student.lastName,
        "ageOfBirth": student.dob,
        "s1": student.grades[0],
        "s2": student.grades[1],
        "s3": student.grades[2],
        "s4": student.grades[3],
        "s5": student.grades[4],
        "s6": student.grades[5],
        "s7": student.grades[6],
        "s8": student.grades[7],
      };
      dataBase['students']?.add(newStudent);

      // Save the newStudent object to local storage
      print('Student saved to local storage.');
      id++;

      // Reset the form
      _formKey.currentState!.reset();
      _gradeControllers.forEach((controller) => controller.clear());

      // Trigger rebuild of the widget to update the table
      setState(() {});
    }
  }

  void _editStudent(int index) {
    final student = dataBase['students']?[index];
    // Update the form fields with the student's data for editing
    _nameController.text = student['name'];
    _lastNameController.text = student['fatherLastname'];
    _dobController.text = student['ageOfBirth'];
    for (int i = 0; i < _gradeControllers.length; i++) {
      _gradeControllers[i].text = student['s${i + 1}'];
    }
    // Remove the student from the list
    dataBase['students']?.removeAt(index);

    // Trigger rebuild of the widget to update the table
    setState(() {});
  }

  void _deleteStudent(int index) {
    // Remove the student from the list
    dataBase['students']?.removeAt(index);

    // Trigger rebuild of the widget to update the table
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
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
              Text(
                'Grades:',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Column(
                children: List.generate(
                  _gradeControllers.length,
                  (index) => TextFormField(
                    controller: _gradeControllers[index],
                    decoration: InputDecoration(
                      labelText: 'Grade ${index + 1}',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a grade';
                      }
                      return null;
                    },
                  ),
                ),
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
                  DataColumn(label: Text('Grade 1')),
                  DataColumn(label: Text('Grade 2')),
                  DataColumn(label: Text('Grade 3')),
                  DataColumn(label: Text('Grade 4')),
                  DataColumn(label: Text('Grade 5')),
                  DataColumn(label: Text('Grade 6')),
                  DataColumn(label: Text('Grade 7')),
                  DataColumn(label: Text('Grade 8')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: List<DataRow>.generate(
                  dataBase['students']!.length,
                  (index) {
                    var student = dataBase['students']![index];
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text(student['id'].toString())),
                        DataCell(Text(student['name']!)),
                        DataCell(Text(student['fatherLastname']!)),
                        DataCell(Text(student['ageOfBirth']!)),
                        DataCell(Text(student['s1']!)),
                        DataCell(Text(student['s2']!)),
                        DataCell(Text(student['s3']!)),
                        DataCell(Text(student['s4']!)),
                        DataCell(Text(student['s5']!)),
                        DataCell(Text(student['s6']!)),
                        DataCell(Text(student['s7']!)),
                        DataCell(Text(student['s8']!)),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => _editStudent(index),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => _deleteStudent(index),
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
    home: AddStudentScreen(),
  ));
}
