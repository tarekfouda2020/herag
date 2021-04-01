import 'package:base_flutter/general/utilities/main_data/MainDataImports.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'general/blocs/lang_cubit/lang_cubit.dart';
import 'general/utilities/localization/SetLocalization.dart';
import 'general/utilities/moor_db/db.dart';
import 'general/utilities/routers/RouterImports.gr.dart';
import 'main.mapper.g.dart' show initializeJsonMapper;

void main()async{
  initializeJsonMapper();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    BlocProvider(
      create: (BuildContext context) => LangCubit(),
      child: Phoenix(child: MyApp()),
    )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = new GlobalKey<NavigatorState>();
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MultiBlocProvider(
      providers: MainData.providers(context),
      child: RepositoryProvider(
        create: (context)=> MyDatabase(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: MainData.defaultThem,
          title: "Base Flutter",
            supportedLocales: [
              Locale('en', 'US'),
              Locale('ar', 'EG')
            ],
            localizationsDelegates: [
              SetLocalization.localizationsDelegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          locale: context.watch<LangCubit>().state.locale,
            routerDelegate: _appRouter.delegate(
              navigatorObservers: [BotToastNavigatorObserver()],
              navigatorKey: navigatorKey
            ),
            routeInformationParser: _appRouter.defaultRouteParser(),
            builder: (ctx, child) {
              child = FlutterEasyLoading(child: child);  //do something
              child = botToastBuilder(context,child);
              return child;
            }
        ),
      ),
    );
  }
}
