part of 'HomeMainImports.dart';


class HomeMainData{

  static PagingController<int, AdsModel> pagingController = PagingController(
      firstPageKey: 1);
  final TextEditingController search =new TextEditingController();

  static TabController tabController;
  static CatViewCubit catViewCubit =new CatViewCubit();
  static CatTabCubit catTabCubit=new CatTabCubit();
  static ListenerCubit listenerCubit=new ListenerCubit();
  final ProductViewsCubit productViewsCubit = ProductViewsCubit();
  static BrandsCubit brandsCubit=new BrandsCubit();


  static List<Category> mainCats=[];
  static bool applyListener=true;
  static int currentIndex=0;


  static int currentCat = 0;
  static int regionId = 0;
  static int cityId = 0;
  int filterType = 0;
  final int pageSize = 10;
  static String searchText;

  Future<void> fetchPage(int pageKey, BuildContext context,{bool refresh = true}) async {
    var loc = context.read<LocationCubit>().state.model;
    FilterModel model = FilterModel(
      cityId: "$cityId",
      lat: loc.lat,
      lng: loc.lng,
      catId: "$currentCat",
      pageNumber: pageKey.toString(),
      pageSize: pageSize.toString(),
      regionId: "$regionId",
      typeFilter: "$filterType",
      title: searchText,
    );
    List<AdsModel> _products = await CustomerRepository(context)
        .getAdsData(model,refresh);
    if(pageKey==1){
      pagingController.itemList=[];
    }
    final isLastPage = _products.length < pageSize;
    if (isLastPage) {
      pagingController.appendLastPage(_products);
    } else {
      final nextPageKey = pageKey + 1;
      pagingController.appendPage(_products, nextPageKey);
    }
    applyListener=true;

  }

  static void addControllerListener(){
    HomeMainData.tabController.addListener(() {
      print("-----------------------applyEnter $applyListener ${HomeMainData.tabController.index}");
      if(applyListener&&(HomeMainData.tabController.index!=currentIndex)){
        print("-----------------------applyDone");

      }

    });
  }

  static resetTabs(int index){
    HomeMainData.catTabCubit.onUpdateCatsTab(0);
    currentCat=mainCats[HomeMainData.tabController.index].id;
    HomeMainData.catViewCubit.onUpdateCatRows([]);
  }

  Future<List<SearchModel>> getAutoCompleteSuggestions(BuildContext context,String text) async {
    var data = await CustomerRepository(context).getSearchAds(text??"");
    return data;
  }

  void onSelectModel(BuildContext context){
    FocusScope.of(context).requestFocus(FocusNode());
    searchText=search.text;
    HomeMainData.pagingController.refresh();
  }

  // void onSelectModel(BuildContext context,AdsModel model){
  //   AutoRouter.of(context).push(Routes.productDetails,arguments: ProductDetailsArguments(model: model));
  // }

  void setSelectCats(BuildContext context,int id,Category model,int index)async{
    catTabCubit.onUpdateCatsTab(id);
    brandsCubit.onUpdateBrands([],0);
    if(id!=0){
      catViewCubit.onUpdateCatRows([]);
      List<Category> children = await context.read<MyDatabase>().selectChildrenCatsAsync(id);
      if(children.length>0){
        catViewCubit.onAddCatRow(CategoryChildModel(cats: children,parentId: id));
      }
      HomeMainData.currentCat=id;
    }else{
      HomeMainData.currentCat=model.parentId;

    }

    HomeMainData.pagingController.refresh();

  }

  void setSelectSubCats(BuildContext context,int id,int parentId,int index)async{
    brandsCubit.onUpdateBrands([],0);
    if(id!=0){
      List<Category> children = await context.read<MyDatabase>().selectChildrenCatsAsync(id);
      catViewCubit.updateSelectedCat(parentId, index);
      if(children.length>0){
        if(catViewCubit.state.catRows.length==1){
          brandsCubit.onUpdateBrands(children,id);
        }else{
          catViewCubit.onAddCatRow(CategoryChildModel(cats: children,parentId: id));
        }
      }
      HomeMainData.currentCat=id;
    }else{
      catViewCubit.updateSelectedCat(parentId, index);
      HomeMainData.currentCat=parentId;

    }
    HomeMainData.pagingController.refresh();

  }

  void navigateToLocationAddress(BuildContext context) async {
    LoadingDialog.showLoadingDialog();
    LocationData loc = await Utils.getCurrentLocation();
    EasyLoading.dismiss();
    if (loc != null) {
      await AutoRouter.of(context).push(FilterLocationRoute(lat: loc.latitude, lng: loc.longitude)
      );
    }else{
      await AutoRouter.of(context).push(FilterLocationRoute(lat: 24.774265, lng: 46.738586)
      );
    }
  }

  void removeLocation(BuildContext context) {
    context.read<LocationCubit>().onLocationUpdated(
        LocationModel("0", "0", ""),
        change: false
    );
    pagingController.refresh();
  }

  void changeProductView(BuildContext context) {
    productViewsCubit.setChangeView(
        showGrid: !productViewsCubit.state.showGrid);
  }

  void addAllToCategory(List<Category> lst,int parent){
    var exist= lst.where((element) => element.id==0).toList();
    if(lst.length>0&&exist.length==0){
      lst.insert(0, Category(id: 0, name: "الكل", img: "", parentId: parent, selected: true, showSideManu: false));
    }
  }

}