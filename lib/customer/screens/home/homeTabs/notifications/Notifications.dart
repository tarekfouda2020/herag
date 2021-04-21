part of 'NotificationImports.dart';

class Notifications extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;

  const Notifications({@required this.scaffold});

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> with NotificationsData {
  @override
  void initState() {
    notifyCubit.fetchData(context, refresh: false);
    notifyCubit.fetchData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(
          con: context,
          title: tr(context, "notifications"),
          leading: Container(),
          actions: [
            IconButton(
              onPressed: _buildConfirmRemoveAllNotifications,
              icon: Icon(
                Icons.delete,
                size: 25,
                color: MyColors.white,
              ),
            )
          ],
        ),
        body: BlocBuilder<NotifyCubit, NotifyState>(
          bloc: notifyCubit,
          builder: (context, state) {
            if (state is NotifyUpdated) {
              if (state.notifies.length > 0) {
                return _buildNotifiesList(state.notifies);
              } else {
                return Center(
                  child: MyText(
                    title: tr(context, "NoData"),
                    size: 12,
                    color: MyColors.blackOpacity,
                  ),
                );
              }
            } else {
              return _buildLoadingView();
            }
          },
        ));
  }

  Widget _buildNotifiesList(List<NotifyModel> lst) {
    return CustomPullRefresh(
      controller: refreshController,
      onRefresh: () => notifyCubit..setRefreshData(context, refreshController),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: lst.length,
        itemBuilder: (con, index) {
          return _buildNotifySlideView(index: index, model: lst[index]);
        },
      ),
    );
  }

  Widget _buildNotifySlideView({NotifyModel model, int index}) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: _buildNotifyItem(index: index, model: model),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: tr(context, "remove"),
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _buildConfirmRemoveNotify(model),
        ),
      ],
    );
  }

  _buildNotifyItem({int index, NotifyModel model}) {
    return InkWell(
      onTap: () => navigateToDetails(context, model),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            color: index.isEven ? MyColors.white : MyColors.greyWhite,
            border: Border(
                bottom: BorderSide(color: MyColors.greyWhite, width: 1))),
        child: Column(
          children: [
            Row(
              children: [
                MyText(
                  title: model.text,
                  size: 10,
                  color: model.show ? MyColors.blackOpacity : MyColors.primary,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyText(
                  title: model.date,
                  size: 9,
                  color: MyColors.blackOpacity,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: LoadingDialog.showLoadingView(),
    );
  }

  void _buildConfirmRemoveNotify(NotifyModel model) {
    LoadingDialog.showConfirmDialog(
        context: context,
        title: tr(context,"confirmDeleteNotify"),
        confirm: () => notifyCubit.removeNotify(context, model));
  }

  void _buildConfirmRemoveAllNotifications() {
    if (notifyCubit.state.notifies.length > 0) {
      LoadingDialog.showConfirmDialog(
          context: context,
          title: tr(context,"confirmDeleteAllNotify"),
          confirm: () => notifyCubit.removeNotifications(context));
    } else {
      LoadingDialog.showSimpleToast(tr(context,"noNotify"));
    }
  }
}
