part of 'MainDataImports.dart';


class MainData {

  static String baseUrl="https://harajawamer.ip4s.com";
  static String chatUrl="$baseUrl/chatHub";

  static ThemeData defaultThem=ThemeData(
    primarySwatch: Colors.grey,
    cursorColor: MyColors.primary,
    focusColor: MyColors.primary,
    accentColor: MyColors.primary,
    primaryColor: MyColors.primary,
    platform: TargetPlatform.android,
    fontFamily: GoogleFonts.cairo().fontFamily,
    textTheme: TextTheme(
      subtitle1:GoogleFonts.cairo(fontSize: 14,),
    ),
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
  );

  static List<BlocProvider>  providers(BuildContext context)=>[
    BlocProvider<LangCubit>(
      create: (BuildContext context) => LangCubit(),
    ),
    BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(),
    ),
    BlocProvider<TabsCubit>(
      create: (BuildContext context) => TabsCubit(),
    ),
    BlocProvider<CatsCubit>(
      create: (BuildContext context) => CatsCubit(),
    ),
    BlocProvider<LocationCubit>(
      create: (BuildContext context)=> LocationCubit(),
    ),
    BlocProvider<WishListCubit>(
      create: (BuildContext context)=> WishListCubit(),
    ),
    BlocProvider<OfferHeadersCubit>(
      create: (BuildContext context)=> OfferHeadersCubit(),
    ),
    BlocProvider<AuthCubit>(
      create: (BuildContext context)=> AuthCubit(),
    ),
    BlocProvider<ChatCountCubit>(
      create: (BuildContext context)=> ChatCountCubit(),
    ),
    BlocProvider<NotifyCountCubit>(
      create: (BuildContext context)=> NotifyCountCubit(),
    ),
    BlocProvider<ShowPayCubit>(
      create: (BuildContext context)=> ShowPayCubit(),
    ),
  ];


}