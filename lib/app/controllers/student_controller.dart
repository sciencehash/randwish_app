import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randwish_app/app/controllers/auth_controller.dart';
import 'package:randwish_app/app/core/utils/helpers/theme.dart';
import 'package:randwish_app/app/data/models/student.dart';
import 'package:randwish_app/app/data/repositories/student_repository.dart';

class StudentController extends GetxController {
  static StudentController to = Get.find();

  StreamSubscription? _authUserStateSubscription;

  final _studentRepository = StudentRepository();
  StreamSubscription? _studentSubscription;

  Rxn<Student> student = Rxn<Student>();

  final isLogged = false.obs;

  // Migrating local data to remote
  bool isMigratingLocalDataToRemote = false;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    //
    final _authCtrl = AuthController.to;
    _authUserStateSubscription = _authCtrl.watchUserState.listen(
      _handleAuthStateChanges,
    );

    super.onReady();
  }

  @override
  void onClose() async {
    await _authUserStateSubscription?.cancel();
    await _studentSubscription?.cancel();
    super.onClose();
  }

  // Handle changes between 'authenticated' and 'unauthenticated'
  Future<void> _handleAuthStateChanges(firebaseUser) async {
    // First of all, after an auth state change, close all subscriptions
    await _studentSubscription?.cancel();

    //
    isLogged.value = firebaseUser != null;

    //
    await _studentRepository.initProviders(
      isLocal: firebaseUser == null,
    );

    //
    _studentSubscription?.cancel();
    //
    _studentSubscription = _studentRepository
        .watchById(isLogged.value ? firebaseUser!.uid : 'local')
        .listen(_handleStudentChanges);
  }

  void _handleStudentChanges(Student? newStudent) async {
    //
    final _authCtrl = AuthController.to;

    // Create reader user if not exists
    if (newStudent == null) {
      // Note: This runs locally the first time the user enters the app,
      // and remotely when the user signs up.

      // Create the reader user object
      Student _newUser = Student.minimum(
        id: isLogged.value ? _authCtrl.firebaseUser.value!.uid : 'local',
      );

      // Just to clarify: If the user has just sign up
      final bool _isNewRegisteredUser = isLogged.value;

      // If the user has just sign up
      if (_isNewRegisteredUser) {
        //
        isMigratingLocalDataToRemote = true;

        // Migrate local db collections to the remote db,
        // and get the local selectedLibraryId
        final _oldLocalUser =
            await _studentRepository.migrateLocalCollectionsToRemoteDb(
          _newUser.id,
        );

        // Set values from Firebase auth
        _newUser = _newUser.copyWith(
          email: _authCtrl.firebaseUser.value!.email,
          name: _authCtrl.firebaseUser.value!.displayName,
          photoUrl: _authCtrl.firebaseUser.value!.photoURL,
          lang: _oldLocalUser.lang,
          contentLang: _oldLocalUser.contentLang,
          theme: _oldLocalUser.theme,
          customThemeColor: _oldLocalUser.customThemeColor,
          selectedLibraryId: _oldLocalUser.selectedLibraryId,
          config: _oldLocalUser.config,
        );
      }

      // Create the reader user in the db (local or remote)
      await _studentRepository.add(_newUser);

      //
      isMigratingLocalDataToRemote = false;

      // Set value to the above code
      newStudent = _newUser;
    }

    // If user change default language (including initial load)
    // Note: student.value = null on app init
    if (student.value == null || newStudent.lang != student.value!.lang) {
      // At app init, this need a bit time
      if (student.value == null) {
        await Future.delayed(Duration(milliseconds: 200));
      }
      //
      if (newStudent.lang == 'en' || newStudent.lang == 'es') {
        Get.updateLocale(Locale(newStudent.lang));
      } else {
        Get.updateLocale(Get.deviceLocale ?? Locale('en'));
      }
    }

    // If user select Dark mode (including initial load)
    // Note: student.value == null on app init
    if (student.value == null || newStudent.theme != student.value!.theme) {
      if (newStudent.theme == 'sys') {
        Get.changeThemeMode(ThemeMode.system);
      } else if (newStudent.theme == 'dark') {
        Get.changeThemeMode(ThemeMode.dark);
      } else {
        Get.changeThemeMode(ThemeMode.light);
      }
      //
      bool? isDarkMode;
      // Wait after theme change
      Future.delayed(Duration(milliseconds: 1000)).then((value) {
        isDarkMode = Get.isDarkMode;
        //
        ThemeHelper.setSystemUIOverlayStyle(isDarkMode!);
      });

      // Wait after theme change
      // Repeat for slow devices
      Future.delayed(Duration(seconds: 5)).then((value) {
        if (isDarkMode != Get.isDarkMode) {
          //
          ThemeHelper.setSystemUIOverlayStyle(Get.isDarkMode);
        }
      });
    }

    // Set new value and refresh view
    student.value = newStudent;
    student.refresh();
  }

  void toggleTheme() {
    late String newThemeName;

    if (student.value!.theme == 'sys')
      newThemeName = 'light';
    else if (student.value!.theme == 'light')
      newThemeName = 'dark';
    else if (student.value!.theme == 'dark') newThemeName = 'sys';

    _studentRepository.update(
      student.value!.copyWith(
        theme: newThemeName,
      ),
    );
  }

  void changeLanguage(String key) {
    _studentRepository.update(
      student.value!.copyWith(
        lang: key,
      ),
    );
  }

  void changeContentLanguage(String key) {
    _studentRepository.update(
      student.value!.copyWith(
        contentLang: key,
      ),
    );
  }

  String get contentLangCode {
    return student.value!.contentLang == 'sys'
        ? (Get.locale.toString().startsWith('es') ? 'es' : 'en')
        : student.value!.contentLang;
  }

  Future<void> updateStudent(Student student) async {
    await _studentRepository.update(student);
  }
}
