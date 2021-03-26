part of 'HomeImports.dart';


class HomeData {

  final GlobalKey<ScaffoldState> scaffold =new GlobalKey();
  final HomeTabCubit homeTabCubit=new HomeTabCubit();
  AnimationController animationController;
  TabController tabController;
  Animation<double> animation;
  CurvedAnimation curve;
  int currentIndex=0;

  List<BottomTabModel> tabs = [
    BottomTabModel(iconData: Icons.home,title: "الرئيسية",),
    BottomTabModel(iconData: Icons.favorite,title: "المفضلة",),
    BottomTabModel(iconData: Icons.notifications,title: "الإشعارات",),
    BottomTabModel(iconData: Icons.mail_outline,title: "الرسائل",),
  ];

  void initBottomNavigation(TickerProvider ticker){
    // final systemTheme = SystemUiOverlayStyle.light.copyWith(
    //   systemNavigationBarColor: MyColors.primary,
    //   systemNavigationBarIconBrightness: Brightness.light,
    // );
    // SystemChrome.setSystemUIOverlayStyle(systemTheme);

    tabController =new TabController(length: 4, vsync: ticker);
    animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: ticker,
    );
    curve = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    animation = Tween<double>(begin: 0, end: 1,).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
          () => animationController.forward(),
    );
  }


  void animateTabsPages(int index,BuildContext context){
    bool result= context.read<AuthCubit>().state.authorized;
    if(index!=homeTabCubit.state.current){
      if(result){
        homeTabCubit.onUpdateTab(index);
        tabController.animateTo(index);
      }else{
        LoadingDialog.showAuthDialog(context: context);
      }

    }


  }

  void addAddClick(BuildContext context){
    bool result= context.read<AuthCubit>().state.authorized;
    if(result){
      context.router.push(AddOffersRoute());
    }else{
      LoadingDialog.showAuthDialog(context: context);
    }
  }

  Future<bool> onBackPressed() async {
    SystemNavigator.pop();
    return true;
  }

}