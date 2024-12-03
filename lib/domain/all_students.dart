
import 'package:get/get.dart';
import 'package:student_app_getx/db/functions/data/data_model.dart';

class AllStudents extends GetxController{
  final allStudentsList =[].obs;
  void addStudent(StudentModel student){
    allStudentsList.add(student);
  }
  void clear(){
    allStudentsList.clear();
  }
}