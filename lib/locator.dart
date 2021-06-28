// for registering viewmodels

import 'package:get_it/get_it.dart';
import 'package:rehmat/core/viewmodels/registerViewModel.dart';
import 'package:rehmat/core/viewmodels/requestBloodViewModel.dart';

import 'core/services/auth.dart';
import 'core/services/navigationService.dart';
import 'core/viewmodels/baseViewModel.dart';

GetIt locator = GetIt.instance;

// * This is where we register all our services and models
void setupLocator() {
  // * Lazy -  There will be only one instance of the service and
  //           will only be created once the service is required for the first time

  locator.registerLazySingleton(() => AuthService());
  // locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  // locator.registerLazySingleton(() => PushNotificationService());

  locator.registerFactory(() => BaseViewModel());
  locator.registerFactory(() => RegisterViewModel());
  locator.registerFactory(() => RequestBloodViewModel());
  // locator.registerFactory(() => LoginViewModel());
  // locator.registerFactory(() => ProfileviewModel());
  // locator.registerFactory(() => AppDrawerViewModel());
  // locator.registerFactory(() => ProductListViewModel());
  // locator.registerFactory(() => SearchviewModel());
  // locator.registerFactory(() => CartViewModel());
  // locator.registerFactory(() => DatabaseService());
  // locator.registerFactory(() => OrderViewModel());
  // locator.registerFactory(() => FavouritesViewModel());
}
