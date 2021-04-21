part of 'ProfileImports.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    commentCubit.setFetchData(context);
    super.initState();
  }

  final CommentCubit commentCubit = new CommentCubit();
  final RefreshController refreshController = new RefreshController();

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserCubit>().state.model;
    return Scaffold(
      appBar: DefaultAppBar(
        title: user.userName,
        con: context,
        actions: [
          IconButton(
            onPressed: () =>
                AutoRouter.of(context).push(EditProfileRoute(user: user)),
            icon: Icon(
              Icons.edit,
              size: 25,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: MyColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildHeaderView(), _buildCommentsListView()],
      ),
    );
  }

  Widget _buildHeaderView() {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      Icons.person_outline,
                      size: 25,
                      color: MyColors.black,
                    ),
                  ),
                  MyText(
                    title: state.model.userName,
                    size: 10,
                    color: MyColors.black,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                padding: EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      title:
                          "${tr(context, "shared")} ${state.model.publishDate} ",
                      size: 10,
                      color: MyColors.blackOpacity,
                    ),
                    RatingBar.builder(
                      initialRating: state.model.rate.toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      updateOnDrag: false,
                      ignoreGestures: true,
                      itemCount: 5,
                      itemSize: 16,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ],
                ),
              ),
              TitleButton(
                iconData: Icons.chat,
                title: tr(context,"comments"),
                onTap: null,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommentsListView() {
    return BlocBuilder<CommentCubit, CommentState>(
      bloc: commentCubit,
      builder: (context, state) {
        if (state is CommentUpdated) {
          return Flexible(
            child: CustomPullRefresh(
              controller: refreshController,
              onRefresh: () =>
                  commentCubit..setRefreshData(context, refreshController),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: state.comments.length,
                itemBuilder: (context, index) {
                  return _buildCommentView(state.comments[index]);
                },
              ),
            ),
          );
        } else {
          return _buildLoadingView();
        }
      },
    );
  }

  Widget _buildCommentView(CommentModel model) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: MyColors.greyWhite.withOpacity(.1),
          border: Border(
              bottom:
                  BorderSide(color: MyColors.grey.withOpacity(.5), width: 1))),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                size: 20,
                color: Colors.black87,
              ),
              MyText(
                title: model.userName,
                size: 10,
                color: Colors.black87,
              ),
              Spacer(),
              MyText(
                title: model.creationDate,
                size: 10,
                color: Colors.black45,
              )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 5),
            child: Expanded(
              child: MyText(
                title: model.text,
                size: 10,
                color: MyColors.blackOpacity,
              ),
            ),
          ),
          Visibility(
              visible: false,
              child: Icon(
                Icons.thumb_up_alt,
                size: 20,
                color: Colors.black87,
              ))
        ],
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: LoadingDialog.showLoadingView(),
    );
  }
}
