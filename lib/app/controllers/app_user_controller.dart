import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randwish_app/app/controllers/auth_controller.dart';
import 'package:randwish_app/app/core/utils/helpers/theme.dart';
import 'package:randwish_app/app/data/models/app_user.dart';
import 'package:randwish_app/app/data/repositories/app_user_repository.dart';

class AppUserController extends GetxController {
  static AppUserController to = Get.find();

  // For listen to changes between 'authenticated' and 'unauthenticated'
  // from Firebase auth
  StreamSubscription? _authUserStateSubscription;

  // Repository that connects AppUser to the db (local or remote)
  final _appUserRepository = AppUserRepository();

  // For listen to changes of AppUser on the db (local or remote), apply
  // corresponding changes, and update [appUser] value.
  StreamSubscription? _appUserSubscription;

  // Reactive AppUser instance
  Rxn<AppUser> appUser = Rxn<AppUser>();

  /// Reactive bool value from Firebase auth state
  final isLogged = false.obs;

  // Migrating local data to remote
  bool isMigratingLocalDataToRemote = false;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    final _authCtrl = AuthController.to;

    await _authUserStateSubscription?.cancel();

    // Handle changes between 'authenticated' and 'unauthenticated'
    _authUserStateSubscription = _authCtrl.watchUserState.listen(
      _handleAuthStateChanges,
    );

    // In development, Hot Reload does not get a new listen reaction
    // from AuthController and needs a manual call.
    if (kDebugMode) {
      await _handleAuthStateChanges(_authCtrl.getUser);
    }

    super.onReady();
  }

  @override
  void onClose() async {
    await _authUserStateSubscription?.cancel();
    await _appUserSubscription?.cancel();
    super.onClose();
  }

  // Handle changes between 'authenticated' and 'unauthenticated'
  Future<void> _handleAuthStateChanges(firebaseUser) async {
    // First of all, after an auth state change, close all subscriptions
    await _appUserSubscription?.cancel();

    isLogged.value = firebaseUser != null;

    // Init local (hive) or remote (GDrive) user provider
    await _appUserRepository.initProviders(
      isLocal: firebaseUser == null,
    );

    // Cancel previous AppUser subscription
    _appUserSubscription?.cancel();
    // Listen from the new subscription for AppUser
    _appUserSubscription = _appUserRepository
        .watchById(isLogged.value ? firebaseUser!.uid : 'local')
        .listen(_handleAppUserChanges);
  }

  void _handleAppUserChanges(AppUser? _appUser) async {
    final _authCtrl = AuthController.to;

    // Create app user if not exists
    if (_appUser == null) {
      // Note: This runs locally the first time the user enters the app,
      // and remotely when the user signs up.

      // Create the app user object
      AppUser _newUser = AppUser.minimum(
        id: isLogged.value ? _authCtrl.firebaseUser.value!.uid : 'local',
      );

      // If the user has just sign up (is a new registered user)
      if (isLogged.value) {
        // Flag to wait while local data is migrated to remote
        isMigratingLocalDataToRemote = true;

        // Migrate local db collections to the remote db,
        // and get the local selectedLibraryId
        final _oldLocalUser =
            await _appUserRepository.migrateLocalCollectionsToRemoteDb(
          _newUser.id,
        );

        // Set values from Firebase auth
        _newUser = _newUser.copyWith(
          email: _authCtrl.firebaseUser.value!.email,
          name: _authCtrl.firebaseUser.value!.displayName,
          photoUrl: _authCtrl.firebaseUser.value!.photoURL,
          lang: _oldLocalUser.lang,
          theme: _oldLocalUser.theme,
          customThemeColor: _oldLocalUser.customThemeColor,
          selectedCategoryId: _oldLocalUser.selectedCategoryId,
          config: _oldLocalUser.config,
        );
      }

      // Create the app user in the db (local or remote)
      await _appUserRepository.add(_newUser);

      // Flag to wait while local data is migrated to remote
      isMigratingLocalDataToRemote = false;

      // Set value from code in this block, to be used later in this function.
      _appUser = _newUser;
    }

    // If user change default language (including initial load)
    // Note: appUser.value == null on app init
    if (appUser.value == null || _appUser.lang != appUser.value!.lang) {
      // At app init, this need a bit time
      if (appUser.value == null) {
        await Future.delayed(Duration(milliseconds: 200));
      }
      // If is not language from device preferences
      if (_appUser.lang == 'en' || _appUser.lang == 'es') {
        Get.updateLocale(Locale(_appUser.lang));
      } else {
        Get.updateLocale(Get.deviceLocale ?? Locale('en'));
      }
    }

    // If user select Dark mode (including initial load)
    // Note: appUser.value == null on app init
    if (appUser.value == null || _appUser.theme != appUser.value!.theme) {
      if (_appUser.theme == 'sys') {
        Get.changeThemeMode(ThemeMode.system);
      } else if (_appUser.theme == 'dark') {
        Get.changeThemeMode(ThemeMode.dark);
      } else {
        Get.changeThemeMode(ThemeMode.light);
      }
      //
      bool? isDarkMode;
      // Wait after theme change
      Future.delayed(Duration(milliseconds: 1000)).then((value) {
        isDarkMode = Get.isDarkMode;
        // Specifies the style to use for the system overlays that are visible
        ThemeHelper.setSystemUIOverlayStyle(isDarkMode!);
      });

      // Wait after theme change
      // Repeat for slow devices
      Future.delayed(Duration(seconds: 5)).then((value) {
        if (isDarkMode != Get.isDarkMode) {
          // Specifies the style to use for the system overlays that are visible
          ThemeHelper.setSystemUIOverlayStyle(Get.isDarkMode);
        }
      });
    }

    // Set new value and refresh view
    appUser.value = _appUser;
    appUser.refresh();
  }

  /// Toggle app theme between 'System', 'Light' and 'Dark'
  void toggleTheme() {
    late String newThemeName;

    if (appUser.value!.theme == 'sys')
      newThemeName = 'light';
    else if (appUser.value!.theme == 'light')
      newThemeName = 'dark';
    else if (appUser.value!.theme == 'dark') newThemeName = 'sys';

    _appUserRepository.update(
      appUser.value!.copyWith(
        theme: newThemeName,
      ),
    );
  }

  /// Change app language
  void changeLanguage(String key) {
    _appUserRepository.update(
      appUser.value!.copyWith(
        lang: key,
      ),
    );
  }

  /// Update AppUser in the db (local or remote)
  Future<void> updateAppUser(AppUser appUser) async {
    await _appUserRepository.update(appUser);
  }
}
