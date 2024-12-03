import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_app_getx/color/colors.dart';
import 'package:student_app_getx/db/functions/data/data_model.dart';

class FlullDetails extends StatelessWidget {
  final StudentModel data;

  const FlullDetails({super.key, required this.data});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  // decoration: BoxDecoration(borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(100, 200))),
                  decoration: const BoxDecoration(
                    color: Colours.indigo,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(100, 200),
                    ),
                  ),
        
                  child: const Center(
                    child: Text(
                      "PROFILE",
                      style: TextStyle(
                          color: Colours.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 10),
                  child: Column(
                    children: [
                      Card(
                        child: ListTile(
                          title:const Text("Name"), //Student name
                          subtitle: Text(data.name),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title:const Text("Age"), //Student Age
                          subtitle: Text(data.age),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text("Guardian"),  //Student Guardian
                          subtitle: Text(data.gName),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title:const Text("Phone"), //Student Contact number
                          subtitle: Text(data.phone),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
             Positioned( //Display profile
              top: 180,
              left: 120,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: FileImage(File(data.profilePath)),
              ),
            ),
        
          ],
        ),
      ),
    );
  }
}
