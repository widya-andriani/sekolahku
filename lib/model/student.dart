
import 'dart:math';

import 'package:sekolahku/util/common_ext.dart';
import 'package:sekolahku/util/date_ext.dart';

import '../database/student_table.dart';

class Student {
  int id;
  String firstName, lastName;
  String mobilePhone;
  String gender;
  String grade;
  List<String> hobbies = [];
  String address;
  DateTime? birthDate;

  Student({
    this.id = 0,
    required this.firstName,
    required this.lastName,
    required this.mobilePhone,
    required this.gender,
    required this.grade,
    required this.hobbies,
    required this.address,
    required this.birthDate,
  });

  @override
  bool operator ==(Object other) {
    if (other is Student) {
      return id == other.id
          && firstName == other.firstName
          && lastName == other.lastName
          && mobilePhone == other.mobilePhone
          && gender == other.gender
          && grade == other.grade
          && hobbies == other.hobbies
          && birthDate == other.birthDate
          && address == other.address;
    }
    return false;
  }

  int generateId() {
    var random = Random();
    int randomInt = random.nextInt(1000) + 1;
    return randomInt;
  }

  String get fullName => "$firstName $lastName";

  Map<String, Object?> get map => {
    StudentTable.firstName : firstName,
    StudentTable.lastName : lastName,
    StudentTable.hobbies : hobbies.join(", "),
    StudentTable.mobilePhone : mobilePhone,
    StudentTable.grade : grade,
    StudentTable.address : address,
    StudentTable.gender : gender,
    StudentTable.birthDate : birthDate.format(),
  };

  @override
  String toString() => {
    "firstName": firstName,
    "lastName" : lastName,
    "mobilePhone" : mobilePhone,
    "gender" : gender,
    "grade" : grade,
    "hobbies" : hobbies,
    "address" : address,
    "birthDate" : birthDate,
  }.toString();

  static Student toStudent(Map<String,Object?> data) {
    return Student(
      id: data[StudentTable.idField].toInt(),
      firstName: data[StudentTable.firstName].toStringOrEmpty(),
      lastName: data[StudentTable.lastName].toStringOrEmpty(),
      mobilePhone: data[StudentTable.mobilePhone].toStringOrEmpty(),
      gender: data[StudentTable.gender].toStringOrEmpty(),
      grade: data[StudentTable.grade].toStringOrEmpty(),
      hobbies: data[StudentTable.hobbies].toListWhenString(),
      address: data[StudentTable.address].toStringOrEmpty(),
      birthDate: data[StudentTable.birthDate].toStringOrEmpty().parse(),
    );
  }
}