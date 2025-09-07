import 'dart:io';

import 'package:cody/models/context_menu_opener.dart';
import 'package:cody/services/contextmenus/android_context_menu_opener_service.dart';
import 'package:cody/services/contextmenus/ios_context_menu_opener_service.dart';

import '../models/alert_dialog_opener.dart';
import '../models/storage.dart';
import '../services/alertdialogs/android_alert_dialog_opener_service.dart';
import '../services/alertdialogs/ios_alert_dialog_opener_service.dart';
import '../services/cloud_kit_storage_service.dart';
import '../services/local_storage_service.dart';

class ListsConstants {

  static final List<AlertDialogOpener> alertDialogOpeners = List.of({AndroidAlertDialogOpenerService(), IosAlertDialogOpenerService()});

  static final List<Storage> storageServices = Platform.isIOS
      ? List.of({LocalStorageService(), CloudKitStorageService()})
      : List.of({LocalStorageService()});

  static final List<ContextMenuOpener> contextMenuOpeners = List.of({AndroidContextMenuOpenerService(), IosContextMenuOpenerService()});

}