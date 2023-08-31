import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
      appBar: null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Projects de ',
                        style: TextStyle(fontSize: 26),
                      ),
                      Text(
                        'Iheb',
                        style:
                            TextStyle(color: Color(0xFF598BB4), fontSize: 28),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD0EAFF),
                      ),
                      child: const Text(
                        'Ajouter',
                        style: TextStyle(
                          color: Color(0xFF598BB4),
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20.0))),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explorer les projects',
                    style: TextStyle(fontSize: 21, color: Color(0xFF333A56)),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.filter_alt_outlined,
                        color: const Color(0xFF333A56),
                      ))
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              // Gridview project Cards
              // GridView.builder(gridDelegate: SliverGrid, itemBuilder: itemBuilder)
            ],
          ),
        ),
      ),
    );
  }
}
