import 'package:sekolahku/database/database_open_helper.dart';

import '../database/student_table.dart';
import '../model/student.dart';

abstract class StudentRepository {
  Future<void> save(Map<String, Object?> data);
  Future<List<Map<String, Object?>>> getAll();
  Future<void> delete(int id);
  Future<void> update(Student student);
  Future<List<Map<String,Object?>>> findByName(String name);
  Future<Map<String, Object?>?> findById(int id);
}

class StudentRepositoryImpl extends StudentRepository {
  final DatabaseOpenHelper _openHelper;

  StudentRepositoryImpl(this._openHelper);

  @override
  Future<void> save(Map<String, Object?> data) async{
    var db = await _openHelper.getDatabase();
    await db.insert(StudentTable.tableName, data);
    return await db.close();
  }

  @override
  Future<List<Map<String, Object?>>> getAll() async {
    var db = await _openHelper.getDatabase();
    var result = await db.query(StudentTable.tableName);
    await db.close();
    return result;
  }

  @override
  Future<void> delete(int id) async{
    var db = await _openHelper.getDatabase();
    db.delete(StudentTable.tableName, where: '${StudentTable.idField}=?', whereArgs : [id]);
    
    return await db.close();
  }

  @override
  Future<void> update(Student student) async{
    var db = await _openHelper.getDatabase();
    db.update(StudentTable.tableName, student.map, where: '${StudentTable.idField}=?', whereArgs : [student.id]);
    return await db.close();
  }

  @override
  Future<List<Map<String, Object?>>> findByName(String name) async {
    var db = await _openHelper.getDatabase();
    const query = "SELECT * FROM ${StudentTable.tableName} WHERE ${StudentTable.firstName} LIKE ? OR ${StudentTable.firstName} LIKE ?";
    final result = await db.rawQuery(query, ["%$name%", "%$name%"]);
    await db.close();
    return result;
  }

  @override
  Future<Map<String, Object?>?> findById(int id) async {
    var db = await _openHelper.getDatabase();
    final result = await db.query(
        StudentTable.tableName,
        where: "${StudentTable.idField}=?",
        whereArgs: [id]
    );

    if(result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

}