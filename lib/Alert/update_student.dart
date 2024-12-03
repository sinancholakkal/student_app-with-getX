import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app_getx/db/functions/db_functions.dart';

class UpdateStudentDetails extends StatefulWidget {
  final String name;
  final String age;
  final String gName;
  final String phone;
  final String profilePath;
  final int id;

  const UpdateStudentDetails({
    Key? key,
    required this.name,
    required this.age,
    required this.gName,
    required this.phone,
    required this.profilePath,
    required this.id,
  }) : super(key: key);

  @override
  State<UpdateStudentDetails> createState() => _UpdateStudentDetailsState();
}

class _UpdateStudentDetailsState extends State<UpdateStudentDetails> {
  late TextEditingController nameController;
  late TextEditingController profilePathController;
  late TextEditingController ageController;
  late TextEditingController gNameController;
  late TextEditingController phoneController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    ageController = TextEditingController(text: widget.age);
    gNameController = TextEditingController(text: widget.gName);
    phoneController = TextEditingController(text: widget.phone);
    profilePathController = TextEditingController(text: widget.profilePath);
    // final TextEditingController idController = TextEditingController(text: widget.id.toString());
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    gNameController.dispose();
    phoneController.dispose();
    profilePathController.dispose();
    super.dispose();
  }
  Future<void> updateStudentDetails() async {
    await update(widget.id, nameController.text,ageController.text,gNameController.text,phoneController.text,
        _image != null ? _image!.path : widget.profilePath);
  }

  ImagePicker imagePicker = ImagePicker();
  File? _image;
  Future<void> imagePickerFromGallery() async {
    // Picking image from gallery
    final imgPicked = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (imgPicked != null) {
        _image = File(imgPicked.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(children: [
              CircleAvatar(
                  //It for display image from galary
                  radius: 60,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : (widget.profilePath.isNotEmpty
                          ? FileImage(File(widget.profilePath))
                          : null)),
              Positioned(
                top: 80,
                left: 60,
                child: IconButton(
                  //Pick the image from galery
                  onPressed: () {
                    imagePickerFromGallery();
                  },
                  icon: const Icon(
                    Icons.add_a_photo,
                    size: 30,
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    labelText: "Student Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Student Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                controller: ageController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Student Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                controller: gNameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Student Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                controller: phoneController,
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await updateStudentDetails();
                  Navigator.of(context).pop();
                  updateSnack(context);
                },
                child:const Text("Update"))
          ],
        ),
      ),
    );
  }

// Success fully updated snack bar
  void updateSnack(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        elevation: 6.0,
        backgroundColor: Color.fromARGB(255, 76, 190, 80),
        content: Text("Student details hase updated"),
      ),
    );
  }
}
