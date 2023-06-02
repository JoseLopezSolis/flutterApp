import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildNavigationButton(
            context,
            'Add student',
            '/add_student',
            Icons.person_add,
            Colors.blue,
          ),
          _buildNavigationButton(
            context,
            'Add teacher',
            '/add_teacher',
            Icons.person_add,
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, String title,
      String route, IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: color,
          ),
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              SizedBox(width: 16.0),
              Text(
                title,
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
