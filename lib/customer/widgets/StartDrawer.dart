import 'package:auto_route/auto_route.dart';
import 'package:base_flutter/general/utilities/localization/LocalizationMethods.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:base_flutter/general/blocs/auth_cubit/auth_cubit.dart';
import 'package:base_flutter/general/blocs/show_pay-cubit/show_pay_cubit.dart';
import 'package:base_flutter/general/blocs/user_cubit/user_cubit.dart';
import 'package:base_flutter/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/models/TabModel.dart';
import 'package:base_flutter/general/resources/GeneralRepository.dart';
import 'package:base_flutter/general/screens/splash/tabs_cubit/tabs_cubit.dart';
import 'package:base_flutter/general/utilities/routers/RouterImports.gr.dart';
import 'package:base_flutter/general/widgets/MyText.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffold;

  StartDrawer({@required this.scaffold});

  @override
  Widget build(BuildContext context) {
    List<TabModel> tabs = context.watch<TabsCubit>().state.tabs;
    var user = context.watch<UserCubit>().state.model;
    return SafeArea(
      child: Drawer(
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          color: MyColors.greyWhite,
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: EdgeInsets.all(0),
            children: [
              Offstage(
                offstage: !context.watch<AuthCubit>().state.authorized,
                child: Column(
                  children: [
                    _buildListViewItem(
                        color: Colors.white,
                        title: "${tr(context, "hello")} ${user.userName}",
                        iconData: FontAwesomeIcons.userAlt,
                        onTap: () =>
                            AutoRouter.of(context).push(ProfileRoute())),
                    _buildListViewItem(
                        title: tr(context, "addAds"),
                        iconData: FontAwesomeIcons.plus,
                        onTap: () =>
                            AutoRouter.of(context).push(AddOffersRoute())),
                    _buildListViewItem(
                        title: tr(context, "myAds"),
                        iconData: FontAwesomeIcons.pager,
                        onTap: () =>
                            AutoRouter.of(context).push(MyProductsRoute())),
                    _buildListViewItem(
                        title: tr(context, "followerList"),
                        iconData: FontAwesomeIcons.users,
                        onTap: () =>
                            AutoRouter.of(context).push(FollowersRoute())),
                    Visibility(
                      visible: context.watch<ShowPayCubit>().state.show,
                      child: Column(
                        children: [
                          _buildListViewItem(
                              title: tr(context, "bankAccount"),
                              iconData: FontAwesomeIcons.idCard,
                              onTap: () => AutoRouter.of(context)
                                  .push(AdminBanksRoute())),
                          _buildListViewItem(
                              title: tr(context, "payCommission"),
                              iconData: FontAwesomeIcons.coins,
                              onTap: () => AutoRouter.of(context)
                                  .push(BankPaymentRoute())),
                        ],
                      ),
                    ),
                    _buildListViewItem(
                        title: tr(context, "contactWithUs"),
                        iconData: FontAwesomeIcons.phone,
                        onTap: () =>
                            AutoRouter.of(context).push(CallUsRoute())),
                    Divider(
                      color: MyColors.blackOpacity,
                      height: 20,
                      thickness: .5,
                    ),
                  ],
                ),
              ),
              _buildTabsPages(tabs, context),
              Visibility(
                visible: context.watch<AuthCubit>().state.authorized,
                child: _buildListViewItem(
                    title: tr(context, "logout"),
                    iconData: FontAwesomeIcons.signOutAlt,
                    textColor: Colors.red,
                    onTap: () => _showLogoutConfirm(context)),
                replacement: _buildListViewItem(
                    title: tr(context, "login"),
                    iconData: FontAwesomeIcons.signInAlt,
                    textColor: Colors.red,
                    onTap: () =>
                        AutoRouter.of(context).popAndPush(LoginRoute())),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabsPages(List<TabModel> tabs, BuildContext context) {
    List<Widget> tabsList = new List<Widget>();
    tabs.forEach((element) {
      element.pages.forEach((page) {
        if (page.showInApp) {
          tabsList.add(_buildListViewItem(
              title: page.name,
              iconData: FontAwesomeIcons.chartLine,
              onTap: () =>
                  AutoRouter.of(context).push(RemotePageRoute(page: page))));
        }
      });
      tabsList.add(Divider(
        color: MyColors.blackOpacity,
        height: 20,
        thickness: .5,
      ));
    });
    return Column(
      children: tabsList,
    );
  }

  Widget _buildListViewItem(
      {Color color,
      Color textColor,
      @required IconData iconData,
      @required String title,
      @required Function onTap}) {
    return ListTile(
      focusColor: MyColors.primary,
      hoverColor: MyColors.primary,
      leading: Icon(
        iconData,
        size: 18,
        color: MyColors.blackOpacity,
      ),
      title: MyText(
        title: title,
        size: 10,
        color: textColor ?? MyColors.blackOpacity,
      ),
      onTap: onTap,
      tileColor: color ?? Colors.transparent,
    );
  }

  void _showLogoutConfirm(BuildContext context) {
    LoadingDialog.showConfirmDialog(
        context: context,
        title: tr(context, "confirmLogout"),
        confirm: () {
          Navigator.pop(context);
          GeneralRepository(context).logout();
        });
  }
}
