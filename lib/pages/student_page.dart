import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sekolahku/model/student.dart';
import 'package:sekolahku/util/date_ext.dart';
import 'package:sekolahku/util/dialog_ext.dart';
import 'package:sekolahku/util/navigation_ext.dart';
import 'package:sekolahku/util/snackbar_ext.dart';
import 'package:sekolahku/widgets/button.dart';
import 'package:sekolahku/widgets/checkbox_group.dart';
import 'package:sekolahku/widgets/dropdown.dart';
import 'package:sekolahku/widgets/input_date.dart';
import 'package:sekolahku/widgets/input_phone_number.dart';
import 'package:sekolahku/widgets/radio_group.dart';

import '../app_service.dart';
import '../res/color_res.dart';
import '../res/dimen_res.dart';
import '../res/icon_res.dart';
import '../res/string_res.dart';
import '../widgets/input.dart';
import '../widgets/input_name.dart';

class StudentPage extends StatefulWidget {
  final Student? student;
  StudentPage({super.key, this.student});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  String get title => widget.student != null ? StringRes.editSiswa : StringRes.addSiswa;
  bool get isEdit => widget.student != null ? true : false;

  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _genderCtrl = TextEditingController(text: StringRes.pria);
  final _mobilePhoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _birthDateCtrl = TextEditingController();
  final _hobbiesCtrl =
      CheckBoxController([], ["Reading", "Writing", "Drawing"]);
  final _gradeOptions = ["SD", "SMP", "SMA"];
  final _gradeCtrl = DropDownController<String>("SD");
  final _formKey = GlobalKey<FormState>();

  var saveEnabled = true;
  var _isButtonAlreadyHitOnce = false;

  void _togleBtn() {
    if(_isButtonAlreadyHitOnce) {
      setState(() {
        final formState = _formKey.currentState;
        if(formState != null) {
          saveEnabled = formState.validate();
        }
      });
    }
  }
  
  void _onButtonSavePressed(BuildContext context) {
    _isButtonAlreadyHitOnce = true;
    final formState = _formKey.currentState;
    if(formState != null) {
      _togleBtn();
      saveEnabled = formState.validate();
      if(saveEnabled) {
        if(isEdit) {
          _update(context);
        } else {
          _save(context);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    final received = widget.student;
    if(received != null) {
      setState(() {
        _firstNameCtrl.text = received.firstName;
        _lastNameCtrl.text = received.lastName;
        _mobilePhoneCtrl.text = received.mobilePhone;
        _birthDateCtrl.text = received.birthDate.format();
        _gradeCtrl.value = received.grade;
        _hobbiesCtrl.value = received.hobbies;
        _genderCtrl.text = received.gender;
        _addressCtrl.text = received.address;
      });
    }
  }

  Student studentInputData() {
    var studentInput = Student(
        firstName: _firstNameCtrl.text,
        lastName: _lastNameCtrl.text,
        mobilePhone: _mobilePhoneCtrl.text,
        gender: _genderCtrl.text,
        grade: _gradeCtrl.value,
        hobbies: _hobbiesCtrl.value,
        address: _addressCtrl.text,
        birthDate: _birthDateCtrl.text.parse());
    print(studentInput);
    return studentInput;
  }

  void _save(BuildContext context) async {

    var student = studentInputData();
    var studentService = AppService.studentService;
    try {
      await studentService.save(student);
      context.showSuccessSnackBar(student.toString());
      context.goBack(true);
    } catch (e,s) {
      context.showErrorSnackBar(e.toString());
    }

    // var studentService = AppService.studentService;
    // studentService
    //     .save(student)
    //     .then((value) => {
    //         context.showSuccessSnackBar(student.toString());
    //         context.goBack();
    //      })
    //     .catchError((error) => context.showErrorSnackBar(error.toString()));
  }

  void _update(BuildContext context) async {
    var studentService = AppService.studentService;
    var studentInput = studentInputData();
    studentInput.id = widget.student!.id;
    if(studentInput == widget.student) {
      context.showErrorSnackBar("No Data Change");
    } else {
      try {
        await studentService.update(studentInput);
        context.showSuccessSnackBar(studentInput.toString());
        context.goBack(true);
      } catch (e,s) {
        context.showErrorSnackBar(e.toString());
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: ColorRes.white),
        ),
        backgroundColor: ColorRes.blueAccent,
      ),
      body: Column(
          children: [
            Expanded(child: _createForm()),
            Padding(
                padding: EdgeInsets.all(DimenRes.size_16),
                child: PrimaryButton(
                  label: StringRes.save,
                  enabled: saveEnabled,
                  onPressed: () => _onButtonSavePressed(context),
                ),
            )
            
          ],),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if(isEdit) {
      //       _update(context);
      //     } else {
      //       _save(context);
      //     }
      //   },
      //  
      //   child: const Icon(Icons.save),
      // ),
    );
  }
  
  Widget _createForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(DimenRes.size_16),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(DimenRes.size_25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: DimenRes.size_16,
                ),
                Text(
                  StringRes.welcome,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  StringRes.fillTheForm,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: DimenRes.size_16,
                ),
                Row(children: [
                  Expanded(
                    child: InputName(
                      label: StringRes.firstName,
                      controller: _firstNameCtrl,
                      onChanged: (input) => _togleBtn(),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: InputName(
                        label: StringRes.lastName,
                        controller: _lastNameCtrl,
                        onChanged: (input) => _togleBtn(),
                      )),
                ]),
                InputPhoneNumber(
                  label: StringRes.phoneNumber,
                  controller: _mobilePhoneCtrl,
                  onChanged: (v) => _togleBtn(),
                ),
                InputDate(
                  label: StringRes.birthDate,
                  textEditingController: _birthDateCtrl,
                  onChanged: (v) => _togleBtn(),
                ),
                DropDown(
                  options: _gradeOptions,
                  marginTop: DimenRes.size_16,
                  controller: _gradeCtrl,
                  label: StringRes.grade,
                  onDrawItem: (value) => Text(value),
                ),
                Input(
                  label: StringRes.address,
                  keyboardType: TextInputType.text,
                  marginTop: DimenRes.size_16,
                  controller: _addressCtrl,
                  minLines: 3,
                ),
                RadioGroup(
                  options: const [StringRes.pria, StringRes.wanita],
                  controller: _genderCtrl,
                  label: StringRes.gender,
                  marginTop: DimenRes.size_16,
                ),
                CheckBoxGroup(
                    marginTop: DimenRes.size_16,
                    controller: _hobbiesCtrl,
                    label: StringRes.hobi)
              ],
            ),
          ),),),);
  }
}
