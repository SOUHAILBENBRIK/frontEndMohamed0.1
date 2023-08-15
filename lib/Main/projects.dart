import 'package:flutter/material.dart';
import 'package:resolve/Main/Components/searchDelegate.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _SettingsState();
}

class _SettingsState extends State<ProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'Projects de , ',
              style: TextStyle(fontSize: 26),
            ),
            Text(
              'Iheb',
              style: TextStyle(color: Color(0xFF598BB4), fontSize: 28),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                // showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        ),
      ),
    );
  }
}
