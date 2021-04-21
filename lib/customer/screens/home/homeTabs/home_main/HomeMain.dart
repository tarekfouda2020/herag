part of 'HomeMainImports.dart';

class HomeMain extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  final int parentCount;

  HomeMain({@required this.scaffold, @required this.parentCount});

  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain>
    with SingleTickerProviderStateMixin, HomeMainData {
  @override
  void initState() {
    super.initState();
    HomeMainData.tabController =
        new TabController(length: widget.parentCount, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Category>>(
      stream: context.watch<MyDatabase>().selectParentCats(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          HomeMainData.mainCats = snapshot.data;
          return DefaultTabController(
            length: snapshot.data.length,
            child: Scaffold(
              appBar: _buildAppbar(),
              body: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: MyColors.greyWhite,
                        border: Border(
                            bottom: BorderSide(
                                color: MyColors.greyWhite.withOpacity(1)))),
                    child: TabBar(
                        controller: HomeMainData.tabController,
                        isScrollable: true,
                        onTap: HomeMainData.resetTabs,
                        indicatorColor: MyColors.primary,
                        labelColor: MyColors.primary,
                        unselectedLabelColor: MyColors.blackOpacity,
                        tabs: List.generate(snapshot.data.length, (index) {
                          return Tab(
                            child: MyText(
                              title: snapshot.data[index].name,
                              size: 12,
                            ),
                          );
                        })),
                  ),
                  Flexible(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: HomeMainData.tabController,
                      children: List.generate(snapshot.data.length, (index) {
                        return _buildPageView(snapshot.data[index].id);
                      }),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return _buildLoadingView();
        }
      },
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      backgroundColor: MyColors.primary,
      // title: AutoCompleteField<SearchModel>(
      //   label: "كلمة البحث",
      //   onSubmit: (model)=>onSelectModel(context,model.adsInfo),
      //   onSearch:(text)async=> getAutoCompleteSuggestions(context,text),
      // ),
      title: IconTextFiled(
        controller: search,
        margin: EdgeInsets.only(top: 25),
        label: tr(context, "searchText"),
        submit: (value) => onSelectModel(context),
        type: TextInputType.text,
        action: TextInputAction.search,
        icon: IconButton(
          icon: Icon(Icons.search, size: 25),
          onPressed: () => onSelectModel(context),
        ),
      ),
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(),
      toolbarHeight: 70,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          size: 30,
          color: MyColors.white,
        ),
        onPressed: () => widget.scaffold.currentState.openDrawer(),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.view_quilt_sharp,
            size: 30,
            color: MyColors.white,
          ),
          onPressed: () => widget.scaffold.currentState.openEndDrawer(),
        ),
      ],
    );
  }

  Widget _buildPageView(int parent) {
    return StreamBuilder<List<Category>>(
      stream: context.read<MyDatabase>().selectChildrenCats(parent),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Visibility(
                  visible: snapshot.data.length > 0,
                  child: BlocBuilder<CatTabCubit, CatTabState>(
                    bloc: HomeMainData.catTabCubit,
                    builder: (context, state) {
                      return _buildCategoryView(
                          snapshot.data, parent, state.id);
                    },
                  ),
                ),
                BlocBuilder<CatViewCubit, CatViewState>(
                  bloc: HomeMainData.catViewCubit,
                  builder: (context, state) {
                    return Column(
                      children: List.generate(state.catRows.length, (index) {
                        return _buildSubCategoryView(state.catRows[index].cats,
                            state.catRows[index].parentId);
                      }),
                    );
                  },
                ),
                Flexible(
                    child: HomeMainAds(
                  catId: parent,
                )),
              ],
            ),
          );
        } else {
          return _buildLoadingView();
        }
      },
    );
  }

  Widget _buildCategoryView(List<Category> lst, int parent, int current) {
    addAllToCategory(lst, parent, context);
    return Container(
      height: 45,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 6),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: lst.length,
        itemBuilder: (BuildContext con, int position) {
          return _buildCatItem(lst[position], position, current);
        },
      ),
    );
  }

  Widget _buildCatItem(Category model, int index, int current) {
    Color color = model.id == current ? MyColors.primary : MyColors.greyWhite;
    Color textColor =
        model.id == current ? MyColors.white : MyColors.blackOpacity;
    return InkWell(
      onTap: () => setSelectCats(context, model.id, model, index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        alignment: Alignment.center,
        child: MyText(
          title: "${model.name}",
          size: 10,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildSubCategoryView(List<Category> lst, int parent) {
    var exist = lst.where((element) => element.id == 0).toList();
    if (lst.length > 0 && exist.length == 0) {
      lst.insert(
          0,
          Category(
              id: 0,
              name: tr(context, "all"),
              img: "",
              parentId: parent,
              selected: true,
              showSideManu: false));
    }
    return Container(
      height: 45,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 6),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: lst.length,
        itemBuilder: (BuildContext con, int position) {
          return _buildSubCatItem(lst[position], position);
        },
      ),
    );
  }

  Widget _buildSubCatItem(Category model, int index) {
    Color color = model.selected ? MyColors.primary : MyColors.greyWhite;
    Color textColor = model.selected ? MyColors.white : MyColors.blackOpacity;
    return InkWell(
      onTap: () => setSelectSubCats(context, model.id, model.parentId, index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        alignment: Alignment.center,
        child: MyText(
          title: "${model.name}",
          size: 10,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: LoadingDialog.showLoadingView(),
    );
  }
}
