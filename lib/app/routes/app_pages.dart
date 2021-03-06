import 'package:get/get.dart';

import 'package:randwish_app/app/modules/account/bindings/account_binding.dart';
import 'package:randwish_app/app/modules/account/views/account_view.dart';
import 'package:randwish_app/app/modules/home/bindings/home_binding.dart';
import 'package:randwish_app/app/modules/home/views/home_view.dart';
import 'package:randwish_app/app/modules/not_found/bindings/not_found_binding.dart';
import 'package:randwish_app/app/modules/not_found/views/not_found_view.dart';
import 'package:randwish_app/app/modules/notifications/bindings/notifications_binding.dart';
import 'package:randwish_app/app/modules/notifications/views/notifications_view.dart';
import 'package:randwish_app/app/modules/search/bindings/search_binding.dart';
import 'package:randwish_app/app/modules/search/views/search_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.NOT_FOUND,
      page: () => NotFoundView(),
      binding: NotFoundBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
  ];
}
