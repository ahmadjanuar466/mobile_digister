import 'package:digister/firebase_options.dart';
import 'package:digister/themes/custom_theme.dart';
import 'package:digister/utils/global.dart';
import 'package:digister/widgets/theme_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localstorage/localstorage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:digister/screens/splash/splash_screen.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  await dotenv.load(fileName: '.env');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
    ),
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  appVersion = packageInfo.version;

  runApp(ThemeSwitcher(child: const MyApp()));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeMode = localStorage.getItem('theme');

    return ToastificationWrapper(
      child: StreamBuilder<ThemeData>(
        initialData: themeMode == null
            ? MediaQuery.of(context).platformBrightness == Brightness.dark
                ? CustomTheme.darkTheme
                : CustomTheme.lightTheme
            : themeMode == 'dark'
                ? CustomTheme.darkTheme
                : CustomTheme.lightTheme,
        stream: ThemeSwitcher.of(context)!.streamController.stream,
        builder: (context, snapshot) => MaterialApp(
          title: 'Digister',
          theme: snapshot.data,
          navigatorKey: navigatorKey,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: const Locale("id"),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
