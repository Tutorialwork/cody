import 'package:cody/services/accounts_data_service.dart';
import 'package:cody/services/app_preferences_service.dart';
import 'package:cody/services/navigator_service.dart';
import 'package:get_it/get_it.dart';

class GetItService {

  static void registerSingletons() {
    NavigatorService navigatorService = NavigatorService();
    AccountsDataService accountsDataService = AccountsDataService();
    AppPreferencesService appPreferencesService = AppPreferencesService();

    GetIt.I.registerSingleton<NavigatorService>(navigatorService);
    GetIt.I.registerSingleton<AccountsDataService>(accountsDataService);
    GetIt.I.registerSingleton<AppPreferencesService>(appPreferencesService);
  }

}