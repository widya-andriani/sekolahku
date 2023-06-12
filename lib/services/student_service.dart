import 'package:sekolahku/repository/student_repository.dart';

import '../model/student.dart';

abstract class StudentService {
  Future<void> save(Student student);
  Future<List<Student>> getAll();
  Future<void> delete(Student student);
  Future<void> update(Student student);
  Future<List<Student>> getAllByName(String name);
  Future<Student> findById(int id);
}

class StudentServiceImpl extends StudentService {
  final StudentRepository _studentRepository;

  StudentServiceImpl(this._studentRepository);

  @override
  Future<void> save(Student student) async {
    return await _studentRepository.save(student.map);
  }

  @override
  Future<List<Student>> getAll() async {
    var found = await _studentRepository.getAll();
    return found.map((e) => Student.toStudent(e)).toList();
  }

  @override
  Future<void> delete(Student student) async {
    return await _studentRepository.delete(student.id);
  }

  @override
  Future<void> update(Student student) async {
    return await _studentRepository.update(student);
  }

  @override
  Future<List<Student>> getAllByName(String name) async {
    var found = await _studentRepository.findByName(name);
    return found.map((e) => Student.toStudent(e)).toList();
  }

  @override
  Future<Student> findById(int id) async{
    var found = await _studentRepository.findById(id);
    if(found != null) return Student.toStudent(found);
    throw Exception("data not found for id : $id");
  }

}