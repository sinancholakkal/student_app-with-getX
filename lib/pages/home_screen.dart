import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app_getx/Alert/delete_student.dart';
import 'package:student_app_getx/Alert/update_student.dart';
import 'package:student_app_getx/color/colors.dart';
import 'package:student_app_getx/db/functions/data/data_model.dart';
import 'package:student_app_getx/db/functions/db_functions.dart';
import 'package:student_app_getx/domain/all_students.dart';
import 'package:student_app_getx/pages/full_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();
  String? filter;
  File? _image;

  ViewType viewType = ViewType.grid;

  double asspet = 2 / 2;

  ImagePicker imagePicker = ImagePicker();

  int cross = 2;

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
  void initState() {
    // init for Searching, Getting every letters in Search fieald
    super.initState();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final studentControll = Get.put(AllStudents());
    return Scaffold(
      appBar: AppBar(
        //AppBar
        //app Bar
        title: const Text(
          "Students",
          style: TextStyle(color: Colours.white),
        ),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
              //Appbar Toggle button for switch to list and grid
              onPressed: () {
                setState(() {
                  if (viewType == ViewType.list) {
                    cross = 2;
                    asspet = 2 / 2;
                    viewType = ViewType.grid;
                  } else {
                    cross = 1;
                    asspet = 3;
                    viewType = ViewType.list;
                  }
                });
              },
              icon: Icon(
                viewType == ViewType.list ? Icons.grid_on : Icons.view_list,
                color: Colours.white,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        //Foatting button for adding student
        onPressed: () {
          bottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              //Searching Field
              controller: searchController,
              decoration: const InputDecoration(
                labelText: "Search",
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Obx((){
              var filteredList =[];
              if (filter != null && filter!.isNotEmpty) {
                  filteredList = studentControll.allStudentsList
                      .where((student) => student.name
                          .toLowerCase()
                          .contains(filter!.toLowerCase()))
                      .toList();
                } else {
                  filteredList = studentControll.allStudentsList;
                }
                return GridView.count(
                  childAspectRatio: asspet,
                  crossAxisCount: cross, //Crooss Acciss
                  children: List.generate(filteredList.length, (index) {
                    final data = filteredList[index];
                    return Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return FlullDetails(data: data);
                          }));
                        },
                        child: viewType == ViewType.list //Checking ViewType
                            ? Align(
                                //It for displaying List
                                child: SingleChildScrollView(
                                  child: ListTile(
                                    title: Text(data.name),
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          FileImage(File(data.profilePath)),
                                      radius: 30,
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                               Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                                return UpdateStudentDetails(name: data.name, age: data.age, gName: data.gName, phone: data.phone, profilePath: data.profilePath, id: data.id!);
                                               }));
                                            },
                                            icon: const Icon(Icons.edit)),
                                        IconButton(
                                            onPressed: () {
                                              
                                             Alerting.showDeleteConfirmation(context: context, title: "Delete Confirmation", subtitle: "Are you sure you want to delete this entry?",id: data.id!);
                                            },
                                            icon: const Icon(Icons.delete))
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Column(
                                //It for Displaying grid
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: FileImage(File(data.profilePath)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(data.name),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        //Delete icon
                                        onPressed: () {
                                           Alerting.showDeleteConfirmation(context: context, title: "Delete Confirmation", subtitle: "Are you sure you want to delete this entry?",id: data.id!);
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                      IconButton(
                                        //Edite icone
                                        onPressed: () {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                                return UpdateStudentDetails(name: data.name, age: data.age, gName: data.gName, phone: data.phone, profilePath: data.profilePath, id: data.id!);
                                               }));
                                        },
                                        icon: const Icon(Icons.edit),
                                      )
                                    ],
                                  )
                                ],
                              ),
                      ),
                    );
                  }),
                );
              },
            
              //Getting data from List
             
            
                // List<StudentModel> filteredList = [];
                //Searching input and list name checking
                
            ),
          ),
        ],
      ),
    );
  }

  void bottomSheet(BuildContext context) {
    // Bottum sheet for adding studdent
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            child: SafeArea(
              child: ListView(
                children: [
                  Form(
                    key: _formKey, //Form key
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: Text(
                              "Add Student Details", //Bottum sheet Heading
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Stack(children: [
                            CircleAvatar(
                              //It for display image from galary
                              radius: 60,
                              backgroundImage:
                                  _image != null ? FileImage(_image!) : null,
                            ),
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
                          TextFormField(
                            //Text form field for Name
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the name";
                              } else {
                                return null;
                              }
                            },
                            controller: nameController,
                            decoration: const InputDecoration(
                                labelText: "Student Name"),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            //Text form field for Age
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the age";
                              } else {
                                return null;
                              }
                            },
                            controller: ageController,
                            decoration:
                                const InputDecoration(labelText: "Student Age"),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            //Text form field for Guardian Name
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the guardian name";
                              } else {
                                return null;
                              }
                            },
                            controller: fNameController,
                            decoration: const InputDecoration(
                                labelText: "Guardian Name"),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            //Text form field for Phone number
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the phone number";
                              } else if (value.length != 10) {
                                return "Please enter a valid phone number";
                              } else {
                                return null;
                              }
                            },
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                labelText: "Phone Number"),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton.icon(
                            // ElevatedButton for add student
                            onPressed: () {
                              inputValidating(ctx);
                            },
                            label: const Text("Add Student"),
                            icon: const Icon(Icons.add),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //Validating all input field
  void inputValidating(ctx) {
    final sname = nameController.text;
    final sage = ageController.text;
    final gName = fNameController.text;
    final phone = phoneController.text;
    if (_formKey.currentState!.validate()) {
      if (_image != null) {
        _image!.readAsBytes().then((Uint8List bytes) {
          final details = StudentModel(
              name: sname,
              age: sage,
              gName: gName,
              phone: phone,
              profilePath: _image!.path);
          addStudent(details);
          cleareTextField();
          Navigator.of(ctx).pop();
        });
      }
    }
  }

  // clear Text fields after submitting
  void cleareTextField() {
    nameController.clear();
    ageController.clear();
    fNameController.clear();
    phoneController.clear();
    setState(() {
      _image = null;
    });
  }
}



//for View type(grid or list)
enum ViewType { grid, list }
