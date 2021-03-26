part of 'UtilsImports.dart';

class Utils {


  static Future<void> manipulateSplashData( BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await GeneralRepository(context).getHomeConstData();
    //  await context.read<MyDatabase>().selectAllCats();
    // if(_all.length==0){
    //   await GeneralRepository(context).getAllCategories();
    // }else{
    //   GeneralRepository(context).getAllCategories();
    // }
    GeneralRepository(context).getAllCategories().then((value) async {
      var strUser = prefs.get("user");
      if (strUser != null) {
        UserModel data = UserModel.fromJson(json.decode(strUser));
        GlobalState.instance.set("token", data.token);
        changeLanguage(data.lang,context);
        setCurrentUserData(data,context);
      } else {
        context.read<AuthCubit>().onUpdateAuth(false);
        changeLanguage("ar",context);
        int parentCount=(await context.read<MyDatabase>().selectParentCatsAsync()).length;
        AutoRouter.of(context).push(HomeRoute(parentCount: parentCount));
      }
    });


  }

  static void  setCurrentUserData(UserModel model,BuildContext context)async{
    context.read<AuthCubit>().onUpdateAuth(true);
    context.read<UserCubit>().onUpdateUserData(model);
    int parentCount=(await context.read<MyDatabase>().selectParentCatsAsync()).length;
    AutoRouter.of(context).push(HomeRoute(parentCount: parentCount));
  }

  static Future<void> saveUserData(UserModel model)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", json.encode(model.toJson()));
  }

  static void  changeLanguage(String lang,BuildContext context){
    context.read<LangCubit>().onUpdateLanguage(lang);
  }

  static UserModel getSavedUser({@required BuildContext context}){
    return context.read<UserCubit>().state.model;
  }

  static Future<String> getDeviceId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("deviceId");
  }

  static Future<void> setDeviceId(String token)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("deviceId",token);
  }

  static void clearSavedData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }


  // static CustomerModel getCustomerData({@required BuildContext context}){
  //   var provider = Provider.of<UserStore>(context,listen: false);
  //   return provider.model.customer;
  // }

  // static DelegateModel getDelegateData({@required BuildContext context}){
  //   var provider = Provider.of<UserProvider>(context,listen: false);
  //   return provider.model.delegate;
  // }

  // static int getCurrentUserType({@required BuildContext context}){
  //   var provider = Provider.of<UserStore>(context,listen: false);
  //   return provider.model.type;
  // }
  //
  // static String getCurrentUserLang({@required BuildContext context}){
  //   var provider = Provider.of<UserStore>(context,listen: false);
  //   return provider.model.lang;
  // }
  //
  // static String getCurrentUserToken({@required BuildContext context}){
  //   var provider = Provider.of<UserStore>(context,listen: false);
  //   return provider.model.token;
  // }
  //
  // static void setCurrentUserType({@required BuildContext context,@required int type}){
  //   var provider = Provider.of<UserStore>(context,listen: false);
  //   SavedDataModel model=provider.model;
  //   model.type=type;
  //   provider.setUserModel(model);
  // }

  // static void setCurrentUserLang({@required BuildContext context,@required String lang}){
  //   var provider =Provider.of<UserStore>(context,listen: false);
  //   SavedDataModel model=provider.model;
  //   model.lang=lang;
  //   provider.setUserModel(model);
  //   saveUserData(provider.model);
  //   changeLanguage(lang,context);
  // }

  static String getCurrentUserId({@required BuildContext context}){
    var provider = context.watch<UserCubit>().state.model;
    return provider.id;
  }


  // static void setSelectUser({@required int type, @required BuildContext context}) async {
  //   setCurrentUserType(context: context,type: type);
  //   AutoRouter(router: AppRouter(), name: Routes.login);
  // }

  static void launchURL({String url,BuildContext context}) async {
    if (!url.toString().startsWith("https")) {
      url = "https://" + url;
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      LoadingDialog.showToastNotification("${tr(context,"checkLink")}");
    }
  }

  static void launchWhatsApp(phone) async {
    String message = 'مرحبا بك';
    if (phone.startsWith("00966")) {
      phone = phone.substring(5);
    }
    var _whatsAppUrl = "whatsapp://send?phone=+966$phone&text=$message";
    print(_whatsAppUrl);
    if (await canLaunch(_whatsAppUrl)) {
      await launch(_whatsAppUrl);
    } else {
      throw 'حدث خطأ ما';
    }
  }

  static void launchYoutube({@required String url}) async {
    if (Platform.isIOS) {
      if (await canLaunch('$url')) {
        await launch('$url', forceSafariVC: false);
      } else {
        if (await canLaunch('$url')) {
          await launch('$url');
        } else {
          throw 'Could not launch $url';
        }
      }
    } else {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  static void callPhone({phone}) async {
    await launch("tel:$phone");
  }

  static void sendMail(mail) async {
    await launch("mailto:$mail");
  }

  static void shareApp(url) {
    LoadingDialog.showLoadingDialog();
    Share.share(url).whenComplete((){
      EasyLoading.dismiss();
    });
  }

  static Future<File> getImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image
    );

    if(result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();
      return files.first;
    } else {
      return null;
    }
  }

  static Future<List<File>> getImages()async{
    FilePickerResult result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image
    );

    if(result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();
      return files;
    } else {
      return [];
    }
  }

  static Future<File> getVideo() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.video
    );

    if(result != null) {
      List<File> files = result.paths.map((path) => File(path)).toList();
      return files.first;
    } else {
      return null;
    }
  }

  static void copToClipboard({String text, GlobalKey<ScaffoldState> scaffold}){
    if(text.trim().isEmpty){
      LoadingDialog.showToastNotification("لا يوجد بيانات للنسخ");
      return;
    }else{
      Clipboard.setData(ClipboardData(text: "$text")).then((value) {
        LoadingDialog.showToastNotification("تم النسخ بنجاح");
      });
    }
  }

  static Future<File> getFile({FileType type = FileType.image}) async {
    FilePickerResult result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: type);

    if (result != null) {
      return File(result.files.first.path);
    } else {
      return null;
    }
  }



  static Future<bool> askForPermission(Location location)async{
    var permission = await location.hasPermission();
    if (permission == PermissionStatus.deniedForever) {
      return false;
    } else if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission == PermissionStatus.denied ||
          permission == PermissionStatus.deniedForever) {
        return false;
      }
    }
    return true;
  }

  static Future<LocationData> getCurrentLocation()async{
    final location = new Location();
    bool permission =await askForPermission(location);
    LocationData current;
    if(permission){
      current = await location.getLocation();
    }
    return current;

  }

  static void navigateToMapWithDirection({String lat, String lng, String title})async{
    print("_____________lat: $lat   lng: $lng");
    final availableMaps = await MapLauncher.installedMaps;
    LocationData loc = await getCurrentLocation();
    if (availableMaps.length>0) {
      await availableMaps.first.showDirections(
        destinationTitle: title,
        origin: Coords(loc.latitude, loc.longitude),
        destination: Coords(double.parse(lat), double.parse(lng)),
      );
    }
    else{
      LoadingDialog.showSimpleToast("قم بتحميل خريطة جوجل");
    }
  }

  static Future<void> navigateToLocationAddress(BuildContext context) async {
    var currentLoc=context.read<LocationCubit>();
    if(currentLoc.state.model.lat!="0"&&currentLoc.state.model.lat.isNotEmpty){
      double lat = double.parse(currentLoc.state.model.lat);
      double lng = double.parse(currentLoc.state.model.lng);
      EasyLoading.dismiss();
      await AutoRouter.of(context).push(LocationAddressRoute(lat: lat, lng: lng)
      );
      return;
    }

    LoadingDialog.showLoadingDialog();
    LocationData loc = await Utils.getCurrentLocation();
    if (loc != null) {
      LocationModel locationModel = LocationModel(
          loc.latitude.toString(),
          loc.longitude.toString(),
          ""
      );
      currentLoc.onLocationUpdated(locationModel);
      EasyLoading.dismiss();
      await AutoRouter.of(context).push(LocationAddressRoute(
              lat: loc.latitude, lng: loc.longitude)
      );
    }else{
      currentLoc.onLocationUpdated(
          LocationModel("24.774265", "46.738586", ""),
          change: false
      );

      EasyLoading.dismiss();
      await AutoRouter.of(context).push(LocationAddressRoute(lat: 24.774265, lng: 46.738586)
      );
    }
  }


  static String convertDigitsToLatin(String s) {
    var sb = new StringBuffer();
    for (int i = 0; i < s.length; i++) {
      switch (s[i]) {
      //Arabic digits
        case '\u0660':
          sb.write('0');
          break;
        case '\u0661':
          sb.write('1');
          break;
        case '\u0662':
          sb.write('2');
          break;
        case '\u0663':
          sb.write('3');
          break;
        case '\u0664':
          sb.write('4');
          break;
        case '\u0665':
          sb.write('5');
          break;
        case '\u0666':
          sb.write('6');
          break;
        case '\u0667':
          sb.write('7');
          break;
        case '\u0668':
          sb.write('8');
          break;
        case '\u0669':
          sb.write('9');
          break;
        default:
          sb.write(s[i]);
          break;
      }
    }
    return sb.toString();
  }

}
