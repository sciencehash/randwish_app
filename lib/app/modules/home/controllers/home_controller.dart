import 'dart:async';

import 'package:get/get.dart';
import 'package:randwish_app/app/controllers/app_user_controller.dart';
import 'package:randwish_app/app/controllers/auth_controller.dart';
import 'package:randwish_app/app/data/models/activity.dart';
import 'package:randwish_app/app/data/models/app_user.dart';
import 'package:randwish_app/app/data/models/category.dart';
import 'package:randwish_app/app/modules/home/repositories/home_repository.dart';

class HomeController extends GetxController {
  StreamSubscription? _authUserStateSubscription;

  final _appUserCtrl = AppUserController.to;
  StreamSubscription? _appUserSubscription;

  final HomeRepository _homeRepository = HomeRepository();
  StreamSubscription? _categorySubscription;

  bool _creatingDefaultCategory = false;

  Rxn<Category> currentCategory = Rxn<Category>();

  /// Reactive Activity list
  var activities = <Activity>[].obs;

  // Reactive Category list obtained in _loadAllCategories()
  var categories = <Category>[].obs;

  // Index of the current tab in the home bottom navigation bar
  var bottomNavigationBarIndex = 0.obs;

  @override
  void onInit() async {
    //
    final _authCtrl = AuthController.to;
    //
    _authUserStateSubscription = _authCtrl.watchUserState.listen(
      _handleAuthStateChanges,
    );

    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() async {
    await _authUserStateSubscription?.cancel();
    await _categorySubscription?.cancel();
    await _appUserSubscription?.cancel();
    super.onClose();
  }

  // Handle changes between 'authenticated' and 'unauthenticated'
  Future<void> _handleAuthStateChanges(firebaseUser) async {
    // First of all, after an auth state change, close all subscriptions
    await _categorySubscription?.cancel();
    await _appUserSubscription?.cancel();

    //
    await _homeRepository.initProviders(
      isLocal: firebaseUser == null,
    );

    // Listen for AppUser changes
    _appUserSubscription = _appUserCtrl.appUser.listen(
      _handleAppUserChanges,
    );

    // For cases in which the user enters directly to a page other than
    // this one, and then enters this page and at that moment the AppUser
    // 'listen' needs a refresh, since that listen is started from the other
    // page and no longer produces initial calls.
    // This Refresh must go here so that the Providers in the
    // repository are previously initiated.
    if (_appUserCtrl.appUser.value != null) {
      _appUserCtrl.appUser.refresh();
    }
  }

  // Handle changes in _appUserCtrl.appUser
  Future<void> _handleAppUserChanges(AppUser? user) async {
    // Avoid first reaction after user sign up
    if (_appUserCtrl.isLogged.value && user!.id == 'local' ||
        _appUserCtrl.isMigratingLocalDataToRemote) {
      return null;
    }

    // If change the selected category,
    // or on init when currentCategory.value == null
    if (user!.selectedCategoryId != currentCategory.value?.id) {
      //
      await _loadCategory(user.selectedCategoryId);
    }
  }

  Future<void> _loadCategory(String _id) async {
    //
    await _categorySubscription?.cancel();
    //
    _categorySubscription = _homeRepository.watchCategoryById(_id).listen(
      (category) async {
        // Create a category if not exists
        if (category == null) {
          //
          if (!_creatingDefaultCategory) {
            //
            await _categorySubscription?.cancel();
            //
            _creatingDefaultCategory = true;

            // Add and save
            final newCategoryId = await _homeRepository.addCategory(
              Category.minimum(
                id: '',
                userId: _appUserCtrl.appUser.value!.id,
                title: 'Default category',
              ),
            );

            //
            await _saveSelectedCategoryId(newCategoryId);
          }
        } else {
          //
          _creatingDefaultCategory = false;

          //
          // activities.value = category.activities;
          // docs.value = category.docs;

          // // Find and get the activities and docs for the current directory level
          // for (DocumentDirectory dirLevel in dirLevels) {
          //   //
          //   for (DocumentDirectory dirRef in activities) {
          //     if (dirLevel == dirRef) {
          //       activities.value = dirRef.activities;
          //       docs.value = dirRef.docs;
          //       break;
          //     }
          //   }
          // }

          // Set new value and refresh view
          currentCategory.value = category;
          currentCategory.refresh();
        }
      },
    );
  }

  // Future<void> addCategory() async {
  //   final String? categoryName = await Get.dialog(
  //     NewCategoryDialogContent(),
  //   );

  //   if (categoryName != null) {
  //     // Add and save
  //     final newCategoryId = await _homeRepository.addCategory(
  //       Category.minimum(
  //         id: '',
  //         userId: _appUserCtrl.appUser.value!.id,
  //         title: categoryName,
  //       ),
  //     );

  //     //
  //     await _saveSelectedCategoryId(newCategoryId);
  //   }
  // }

  // Future<void> editCategory() async {
  //   final String? categoryName = await Get.dialog(
  //     EditCategoryDialogContent(
  //       category: currentCategory.value!,
  //     ),
  //   );

  //   if (categoryName != null) {
  //     // Add and save
  //     await _homeRepository.updateCategory(
  //       currentCategory.value!.copyWith(
  //         title: categoryName,
  //       ),
  //     );
  //   }
  // }

  // Future<void> changeCategory() async {
  //   _loadAllCategories();

  //   final String? categoryId = await Get.dialog(
  //     ChangeCategoryDialogContent(),
  //   );

  //   if (categoryId != null) {
  //     //
  //     await _saveSelectedCategoryId(categoryId);
  //   }
  // }

  Future<void> _saveSelectedCategoryId(String categoryId) async {
    await _appUserCtrl.updateAppUser(
      _appUserCtrl.appUser.value!.copyWith(
        selectedCategoryId: categoryId,
      ),
    );
  }

  // Future<void> removeCategory(String _categoryId) async {
  //   // Cancel category subscription to avoid reactions before save changes
  //   await _categorySubscription?.cancel();

  //   // Get categories
  //   List<Category> _categories = await _homeRepository.getAllCategories();

  //   // Remove the category from this list
  //   _categories.removeWhere((l) => l.id == _categoryId);

  //   // Remove the category from the db
  //   await _homeRepository.removeCategoryById(_categoryId);

  //   // Save the new selected category ID
  //   await _saveSelectedCategoryId(
  //     _categories.isEmpty ? '[create_default]' : _categories.first.id,
  //   );
  // }

  // Future<void> _loadAllCategories() async {
  //   categories.value = [];
  //   categories.value = await _homeRepository.getAllCategories();
  // }

  // void addDirectory() async {
  //   int _getNextDirsIdLib() {
  //     currentCategory.value = currentCategory.value!.copyWith(
  //       lastDirsIdLib: currentCategory.value!.lastDirsIdLib + 1,
  //     );
  //     return currentCategory.value!.lastDirsIdLib;
  //   }

  //   final String? dirName = await Get.dialog(
  //     NewDirectoryDialogContent(),
  //   );

  //   if (dirName != null) {
  //     // Add and save
  //     await _addDirectory(
  //       DocumentDirectory.minimum(
  //         idLib: _getNextDirsIdLib(),
  //         title: dirName,
  //       ),
  //     );
  //   }
  // }

  // Future<void> renameDirectory(DocumentDirectory directory) async {
  //   final String? directoryName = await Get.dialog(
  //     EditDirectoryDialogContent(
  //       directory: directory,
  //     ),
  //   );

  //   if (directoryName != null) {
  //     // Save
  //     await _updateDirectory(
  //       directory.copyWith(
  //         title: directoryName,
  //       ),
  //     );
  //   }
  // }

  // void deleteDirectory(DocumentDirectory directory) async {
  //   final bool? confirmed = await Get.dialog(
  //     DeleteDirectoryDialogContent(
  //       directory: directory,
  //     ),
  //   );

  //   if (confirmed != null && confirmed == true) {
  //     // Delete
  //     await _deleteDirectory(
  //       directory,
  //     );
  //   }
  // }

  // void toggleViewMode() {
  //   //
  //   _homeRepository.updateCategory(
  //     currentCategory.value!.copyWith(
  //       viewMode: currentCategory.value!.viewMode == 'list' ? 'grid' : 'list',
  //     ),
  //   );
  // }

  // void toDirectory(DocumentDirectory directory) {
  //   dirLevels.add(directory);
  //   activities.value = directory.activities;
  //   docs.value = directory.docs;
  // }

  // void outsideDirectory() {
  //   dirLevels.removeLast();
  //   if (dirLevels.isEmpty) {
  //     activities.value = currentCategory.value!.activities;
  //     docs.value = currentCategory.value!.docs;
  //   } else {
  //     activities.value = dirLevels.last.activities;
  //     docs.value = dirLevels.last.docs;
  //   }
  // }

  // //
  // Future<void> _addDirectory(DocumentDirectory directory) async {
  //   await _saveDirectoryOrDocumentFile(directory, 'add');
  // }

  // //
  // Future<void> _updateDirectory(DocumentDirectory directory) async {
  //   await _saveDirectoryOrDocumentFile(directory, 'update');
  // }

  // //
  // Future<void> _deleteDirectory(DocumentDirectory directory) async {
  //   await _saveDirectoryOrDocumentFile(directory, 'delete');
  // }

  // //
  // Future<void> _addDocumentFile(DocumentFile document) async {
  //   await _saveDirectoryOrDocumentFile(document, 'add');
  // }

  // //
  // Future<void> _updateDocumentFile(DocumentFile document) async {
  //   await _saveDirectoryOrDocumentFile(document, 'update');
  // }

  // //
  // Future<void> _deleteDocumentFile(DocumentFile document) async {
  //   await _saveDirectoryOrDocumentFile(document, 'delete');
  // }

  // //
  // Future<void> _saveDirectoryOrDocumentFile(
  //   dynamic input,
  //   String action,
  // ) async {
  //   if (dirLevels.isEmpty) {
  //     //
  //     // Add directly on the category
  //     //
  //     if (input is DocumentDirectory) {
  //       if (action == 'add') {
  //         // Add the new directory
  //         currentCategory.value!.activities.add(input);
  //       } else if (action == 'update') {
  //         //
  //         int dirIdx = currentCategory.value!.activities
  //             .indexWhere((d) => d.idLib == input.idLib);
  //         //
  //         currentCategory.value!.activities[dirIdx] = input;
  //       } else if (action == 'delete') {
  //         // Delete all UserDocumentData of documents in this directory
  //         await _deleteAllUserDocumentDataByDirectory(
  //           currentCategory.value!.activities
  //               .firstWhere((d) => d.idLib == input.idLib),
  //         );
  //         //
  //         currentCategory.value!.activities
  //             .removeWhere((d) => d.idLib == input.idLib);
  //       }
  //     } else if (input is DocumentFile) {
  //       if (action == 'add') {
  //         // Add the new document
  //         currentCategory.value!.docs.add(input);
  //       } else if (action == 'update') {
  //         //
  //         int docIdx = currentCategory.value!.docs
  //             .indexWhere((d) => d.idLib == input.idLib);
  //         //
  //         currentCategory.value!.docs[docIdx] = input;
  //       } else if (action == 'delete') {
  //         // Delete the UserDocumentData of this document
  //         await _deleteUserDocumentDataByDocument(
  //           currentCategory.value!.docs
  //               .firstWhere((d) => d.idLib == input.idLib),
  //         );
  //         //
  //         currentCategory.value!.docs
  //             .removeWhere((d) => d.idLib == input.idLib);
  //       }
  //     }
  //   } else {
  //     //
  //     // Add inside a directory,
  //     // looking for the correct directory from the root of the category.
  //     //

  //     // Note: Although 'activities' is a reference to 'currentCategory.activities',
  //     // it is not possible to directly edit 'activities'
  //     // because after the first edit the reference is lost.

  //     // Get reference
  //     var tempDirsRef = currentCategory.value!.activities;
  //     // Iterate all levels
  //     for (DocumentDirectory dirLevel in dirLevels) {
  //       // Iterate directories in this level
  //       for (DocumentDirectory tempDirRef in tempDirsRef) {
  //         // If is a directory in the 'dirLevels' list
  //         if (dirLevel == tempDirRef) {
  //           // If is the last entered level, the current level
  //           if (dirLevel == dirLevels.last) {
  //             if (input is DocumentDirectory) {
  //               if (action == 'add') {
  //                 // Add the new directory
  //                 tempDirRef.activities.add(input);
  //               } else if (action == 'update') {
  //                 //
  //                 int dirIdx = tempDirRef.activities
  //                     .indexWhere((d) => d.idLib == input.idLib);
  //                 //
  //                 tempDirRef.activities[dirIdx] = input;
  //               } else if (action == 'delete') {
  //                 // Delete all UserDocumentData of documents in this directory
  //                 await _deleteAllUserDocumentDataByDirectory(
  //                   tempDirRef.activities
  //                       .firstWhere((d) => d.idLib == input.idLib),
  //                 );
  //                 //
  //                 tempDirRef.activities
  //                     .removeWhere((d) => d.idLib == input.idLib);
  //               }
  //             } else if (input is DocumentFile) {
  //               if (action == 'add') {
  //                 // Add the new document
  //                 tempDirRef.docs.add(input);
  //               } else if (action == 'update') {
  //                 //
  //                 int docIdx =
  //                     tempDirRef.docs.indexWhere((d) => d.idLib == input.idLib);
  //                 //
  //                 tempDirRef.docs[docIdx] = input;
  //               } else if (action == 'delete') {
  //                 // Delete the UserDocumentData of this document
  //                 await _deleteUserDocumentDataByDocument(
  //                   tempDirRef.docs.firstWhere((d) => d.idLib == input.idLib),
  //                 );
  //                 //
  //                 tempDirRef.docs.removeWhere((d) => d.idLib == input.idLib);
  //               }
  //             }

  //             // Update directory in the 'dirLevels' list
  //             final dirLevelIdx = dirLevels.indexOf(dirLevel);
  //             dirLevels[dirLevelIdx] = tempDirRef;
  //           }

  //           // Update directory reference with its subdirectories
  //           // for the next loop (next level)
  //           tempDirsRef = tempDirRef.activities;

  //           // No find more in this level
  //           break;
  //         }
  //       }
  //     }
  //   }

  //   // Save the new directory or document file
  //   _homeRepository.updateCategory(
  //     currentCategory.value!,
  //   );
  // }

  // int _getNextDocsIdLib() {
  //   currentCategory.value = currentCategory.value!.copyWith(
  //     lastDocsIdLib: currentCategory.value!.lastDocsIdLib + 1,
  //   );
  //   return currentCategory.value!.lastDocsIdLib;
  // }

  // void addLocalFile() async {
  //   //
  //   isGettingFile.value = true;

  //   // Get local file or files with the file picker
  //   FilePickerResult? result = await FileRepository().getLocalFile();

  //   if (result != null) {
  //     result.files.forEach((file) async {
  //       // Get.snackbar(
  //       //   'File',
  //       //   '${file.path} ${file.name} ${file.bytes?.length}',
  //       //   backgroundColor: Colors.black.withOpacity(.8),
  //       //   colorText: Colors.white,
  //       //   snackPosition: SnackPosition.BOTTOM,
  //       //   borderRadius: 8,
  //       //   margin: const EdgeInsets.all(10),
  //       // );

  //       var docFile = DocumentFile.minimum(
  //         idLib: _getNextDocsIdLib(),
  //         title: file.name!,
  //       );

  //       // Add and save
  //       await _addDocumentFile(docFile);

  //       // Add User Document Data
  //       await _homeRepository.addUserDocumentData(
  //         UserDocumentData.minimum(
  //           id: '${currentCategory.value!.id}-${docFile.idLib}',
  //         ).copyWith(
  //           files: [
  //             FileReference.minimum(
  //               storage: GetPlatform.isWeb
  //                   ? FileStorage.webCache
  //                   : FileStorage.localCache,
  //             ).copyWith(
  //               path: GetPlatform.isWeb ? null : file.path,
  //             ),
  //           ],
  //         ),
  //         GetPlatform.isWeb ? file.bytes : null,
  //       );
  //     });
  //   } else {
  //     // User canceled the picker
  //   }

  //   //
  //   isGettingFile.value = false;
  // }

  // void addGoogleDriveFile() async {
  //   Map<String, dynamic>? driveData = await Get.dialog(
  //     DialogScaffold(
  //       title: 'Google Drive',
  //       content: GoogleDriveExplorerView(),
  //       maxWidth: 550,
  //       contentHorizontalPadding: 0,
  //     ),
  //   );

  //   if (driveData != null) {
  //     // Futuro: si un item de selectedDriveFiles en un folder, puedo utilizar
  //     // esta lista para obtener los archivos y carpetas dentro de ese folder
  //     // final List<drive.File> allDriveFiles = driveData['allDriveFiles'];

  //     final List<drive.File> selectedDriveFiles =
  //         driveData['selectedDriveFiles'];

  //     for (drive.File driveFile in selectedDriveFiles) {
  //       var docFile = DocumentFile.minimum(
  //         idLib: _getNextDocsIdLib(),
  //         title: driveFile.name!,
  //       );

  //       // Add and save
  //       await _addDocumentFile(docFile);

  //       // Add User Document Data
  //       await _homeRepository.addUserDocumentData(
  //         UserDocumentData.minimum(
  //           id: '${currentCategory.value!.id}-${docFile.idLib}',
  //         ).copyWith(
  //           files: [
  //             FileReference.minimum(
  //               storage: FileStorage.gDrive,
  //             ).copyWith(
  //               path: driveFile.id,
  //             ),
  //           ],
  //         ),
  //         null,
  //       );
  //     }
  //   }
  // }

  // Future<void> renameDocument(DocumentFile document) async {
  //   final String? documentName = await Get.dialog(
  //     EditDocumentDialogContent(
  //       document: document,
  //     ),
  //   );

  //   if (documentName != null) {
  //     // Save
  //     await _updateDocumentFile(
  //       document.copyWith(
  //         title: documentName,
  //       ),
  //     );
  //   }
  // }

  // void deleteDocument(DocumentFile document) async {
  //   final bool? confirmed = await Get.dialog(
  //     DeleteDocumentDialogContent(
  //       document: document,
  //     ),
  //   );

  //   if (confirmed != null && confirmed == true) {
  //     // Delete
  //     await _deleteDocumentFile(
  //       document,
  //     );
  //   }
  // }

  // Future<void> _deleteUserDocumentDataByDocument(
  //   DocumentFile document,
  // ) async {
  //   await _homeRepository.removeUserDocumentDataById(
  //     '${currentCategory.value!.id}-${document.idLib}',
  //   );
  // }

  // Future<void> _deleteAllUserDocumentDataByDirectory(
  //   DocumentDirectory directory,
  // ) async {
  //   // Remove in documents of this directory
  //   for (DocumentFile document in directory.docs) {
  //     await _deleteUserDocumentDataByDocument(document);
  //   }
  //   // Remove recursively in documents in subdirectories
  //   for (DocumentDirectory directory in directory.activities) {
  //     await _deleteAllUserDocumentDataByDirectory(directory);
  //   }
  // }
}
