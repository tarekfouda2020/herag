part of 'FollowerImports.dart';

class Followers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: DefaultAppBar(
          title: tr(context, "followers"),
          con: context,
        ),
        backgroundColor: MyColors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [_buildTabBarView(context), _buildTabsViews()],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBarView(BuildContext context) {
    return Container(
      color: MyColors.greyWhite,
      child: TabBar(
        indicatorColor: MyColors.primary,
        labelColor: MyColors.primary,
        unselectedLabelColor: MyColors.blackOpacity,
        labelStyle:
            GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.bold),
        unselectedLabelStyle:
            GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.bold),
        tabs: [
          Tab(
            text: tr(context, "followPeople"),
          ),
          Tab(
            text: tr(context, "followAllAds"),
          ),
        ],
      ),
    );
  }

  Widget _buildTabsViews() {
    return Flexible(
      child: TabBarView(children: [
        FollowedUsers(),
        FollowerAds(),
      ]),
    );
  }
}
