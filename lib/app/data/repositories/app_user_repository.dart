import 'package:randwish_app/app/data/models/app_user.dart';
import 'package:randwish_app/app/data/services/app_user_service.dart';
import 'package:randwish_app/app/data/providers/app_user_hive_provider.dart';

class AppUserRepository {
  late AppUserService _appUserService;

  Future<void> initProviders({required bool isLocal}) async {
    _appUserService = AppUserHiveProvider();
    await _appUserService.initProvider();
  }

  Stream<AppUser?> watchById(String id) {
    return _appUserService.watchById(id);
  }

  Future<void> add(AppUser user) async {
    await _appUserService.add(user);
  }

  Future<void> update(AppUser user) async {
    await _appUserService.update(user);
  }

  // Migrate local db collections to the remote db
  Future<AppUser> migrateLocalCollectionsToRemoteDb(String userId) async {
    // Local services
    final AppUserService _localAppUserService = AppUserHiveProvider();
    // final LibraryService _localLibraryService = LibraryHiveProvider();
    // final UserDocumentDataService _localUserDocumentDataService =
    //     UserDocumentDataHiveProvider();

    // Remote services
    // final LibraryService _remoteLibraryService = LibraryFirestoreProvider();
    // final UserDocumentDataService _remoteUserDocumentDataService =
    //     UserDocumentDataFirestoreProvider();

    // Init local providers
    await _localAppUserService.initProvider();
    // await _localLibraryService.initProvider();
    // await _localUserDocumentDataService.initProvider();

    // Init remote providers

    // Migrate Library documents
    // await _localLibraryService.all()
    //   ..forEach((library) {
    //     // Add to remote
    //     _remoteLibraryService.add(
    //       library.copyWith(
    //         userId: userId,
    //       ),
    //     );
    //     // Remove from local
    //     _localLibraryService.removeById(library.id);
    //   });

    // Migrate UserDocumentData documents
    // await _localUserDocumentDataService.all()
    //   ..forEach((userDocumentData) {
    //     // Add to remote
    //     _remoteUserDocumentDataService.add(
    //       userDocumentData,
    //     );
    //     // Remove from local
    //     _localUserDocumentDataService.removeById(userDocumentData.id);
    //   });

    // Get local selectedLibraryId
    final _localAppUser = (await _localAppUserService.byId('local'))!;
    // final String _selectedLibraryId = _localAppUser!.selectedLibraryId;

    // Remove local user
    _localAppUserService.removeById('local');

    // Return local old user
    return _localAppUser;
  }
}
