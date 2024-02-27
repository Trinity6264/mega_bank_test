import "package:bank/app/service_locator.dart";
import "package:bank/bank_blocs.dart";
import "package:bank/bank_observer.dart";
import "package:bank/firebase_options.dart";
import "package:bank/service/local_storage.dart";
import "package:bank/service/model/settings_model.dart";
import "package:bloc/bloc.dart";
import "package:easy_localization/easy_localization.dart";
import "package:firebase_analytics/firebase_analytics.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_crashlytics/firebase_crashlytics.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:hive_flutter/hive_flutter.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  // Registering Adapter
  Hive.registerAdapter<SettingsModel>(SettingsModelAdapter());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics.instance;
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Opening Boxes
  await LocalStorage.openBoxes();
  LocalStorage.getSettings();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xff022E64),
      statusBarIconBrightness: Brightness.light,
    ),
  );

  setupServiceLocator();
  Bloc.observer = const BankObserver();
  runApp(
    Theme(
      data: ThemeData(
        fontFamily: "OpenSans",
      ),
      child: EasyLocalization(
        supportedLocales: const [
          Locale("en"),
          Locale("es"),
          Locale("fr"),
          Locale("ak"),
        ],
        fallbackLocale: const Locale("en"),
        path: "assets/translations",
        useOnlyLangCode: true,
        child: const BankBlocs(),
      ),
    ),
  );
}
