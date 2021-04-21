part of 'HomeMainImports.dart';

class HomeMainAds extends StatefulWidget {
  final int catId;

  const HomeMainAds({@required this.catId});

  @override
  _HomeMainAdsState createState() => _HomeMainAdsState();
}

class _HomeMainAdsState extends State<HomeMainAds> with HomeMainData {
  @override
  void initState() {
    super.initState();
    HomeMainData.brandsCubit.onUpdateBrands([], 0);
    HomeMainData.pagingController = PagingController(firstPageKey: 1);
    HomeMainData.regionId = 0;
    HomeMainData.cityId = 0;
    fetchPage(1, context, refresh: false);
    HomeMainData.pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey, context);
    });
  }

  final GlobalKey<DropdownSearchState<DropDownModel>> region = new GlobalKey();
  final GlobalKey<DropdownSearchState<DropDownModel>> city = new GlobalKey();
  final GlobalKey<DropdownSearchState<Category>> brand = new GlobalKey();

  void setSelectBrand(Category model) {
    HomeMainData.currentCat =
        model == null ? HomeMainData.brandsCubit.state.parentId : model.id;
    HomeMainData.pagingController.refresh();
  }

  void setSelectRegion(DropDownModel model) {
    HomeMainData.regionId = model == null ? 0 : model.id;
    city.currentState.changeSelectedItem(null);
    HomeMainData.pagingController.refresh();
  }

  void setSelectCity(DropDownModel model) {
    HomeMainData.cityId = model == null ? 0 : model.id;
    HomeMainData.pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFilterView(context),
        BlocBuilder<ProductViewsCubit, ProductViewsState>(
          bloc: productViewsCubit,
          builder: (context, state) {
            if (state.showGrid) {
              return _buildGridProductView();
            } else {
              return _buildRowProductView();
            }
          },
        ),
      ],
    );
  }

  Widget _buildFilterView(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: MyColors.greyWhite, width: 1))),
      child: Row(
        children: [
          Flexible(
            child: DropdownTextField<DropDownModel>(
              dropKey: region,
              label: tr(context, "deptName"),
              fontSize: 10,
              labelSize: 10,
              margin: EdgeInsets.symmetric(horizontal: 5),
              onChange: setSelectRegion,
              downIconPadding: EdgeInsets.all(0),
              finData: (filter) async =>
                  await CustomerRepository(context).getRegionData(),
            ),
          ),
          BlocBuilder<BrandsCubit, BrandsState>(
            bloc: HomeMainData.brandsCubit,
            builder: (_, state) {
              if (state.brands.length > 0) {
                return Flexible(
                  child: DropdownTextField<Category>(
                    dropKey: brand,
                    label: tr(context, "model"),
                    fontSize: 10,
                    labelSize: 10,
                    downIconPadding: EdgeInsets.all(0),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    onChange: setSelectBrand,
                    useName: true,
                    data: state.brands,
                  ),
                );
              } else {
                return Flexible(
                  child: DropdownTextField<DropDownModel>(
                    dropKey: city,
                    label: tr(context, "city"),
                    fontSize: 10,
                    labelSize: 10,
                    downIconPadding: EdgeInsets.all(0),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    onChange: setSelectCity,
                    finData: (filter) async => await CustomerRepository(context)
                        .getCitiesData(HomeMainData.regionId.toString()),
                  ),
                );
              }
            },
          ),

          // _buildFilterItem(icon: Icons.filter_alt_rounded,onTab: ()=>_showFilterModel(context)),
          _buildFilterItem(
            icon: Icons.location_city,
            bgColor: MyColors.greyWhite,
            onTab: () => navigateToLocationAddress(context),
          ),
          BlocBuilder<ProductViewsCubit, ProductViewsState>(
            bloc: productViewsCubit,
            builder: (context, state) {
              return _buildFilterItem(
                  icon: state.showGrid ? Icons.menu : Icons.view_module_rounded,
                  onTab: () => changeProductView(context));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterItem({IconData icon, Function onTab, Color bgColor}) {
    return InkWell(
      onTap: onTab,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        height: 40,
        width: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: bgColor ?? MyColors.greyWhite,
            borderRadius: BorderRadius.circular(10)),
        child: Icon(
          icon,
          size: 20,
          color: MyColors.blackOpacity,
        ),
      ),
    );
  }

  Widget _buildRowProductView() {
    return Flexible(
      child: PagedListView<int, AdsModel>(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        pagingController: HomeMainData.pagingController,
        builderDelegate: PagedChildBuilderDelegate<AdsModel>(
          noItemsFoundIndicatorBuilder: (context) => _buildNoItemFound(),
          itemBuilder: (context, item, index) => ProductRow(
            index: index,
            model: item,
          ),
        ),
      ),
    );
  }

  Widget _buildGridProductView() {
    return Flexible(
      child: PagedListView<int, AdsModel>(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        pagingController: HomeMainData.pagingController,
        builderDelegate: PagedChildBuilderDelegate<AdsModel>(
          noItemsFoundIndicatorBuilder: (context) => _buildNoItemFound(),
          firstPageProgressIndicatorBuilder: (_) =>
              LoadingDialog.showLoadingView(),
          itemBuilder: (context, item, index) => ProductGrid(
            index: index,
            model: item,
          ),
        ),
      ),
    );
  }

  Widget _buildNoItemFound() {
    return NoData(
      title: tr(context, "noAds"),
      message: tr(context, "waitAddAds"),
    );
  }
}
