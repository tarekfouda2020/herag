part of 'ProDetailsImports.dart';

class ProDetailsData {
  final GlobalKey<FormState> formKey = new GlobalKey();
  final TextEditingController report = new TextEditingController();
  final FavouriteCubit favouriteCubit = new FavouriteCubit();
  final ProductDetailsCubit productDetailsCubit = new ProductDetailsCubit();
  final CommentCubit commentCubit = new CommentCubit();
  final GlobalKey<FormState> commentFormKey = new GlobalKey();
  final GlobalKey<FormState> repFormKey = new GlobalKey();
  final TextEditingController comment = new TextEditingController();
  final TextEditingController reply = new TextEditingController();
  final TextEditingController reason = new TextEditingController();

  final String baseUrl =
      "${MainData.baseUrl}/Info/GetInfoDetails";

  void setAddReport(BuildContext context, int id) async {
    if (formKey.currentState.validate()) {
      var result =
      await CustomerRepository(context).addAdsReport("$id", report.text);
      if (result) {
        Navigator.pop(context);
      }
    }
  }

  void navigateToChat(BuildContext context, AdsDataModel data, UserModel user) {
    var auth = context.read<AuthCubit>().state.authorized;
    if (auth) {
      AutoRouter.of(context).push(ChatRoute(
              receiverId: data.fkUser,
              userName: data.userName,
              senderId: user.id));
    } else {
      LoadingDialog.showAuthDialog(context: context);
    }
  }

  void navigateToComments(BuildContext context, AdsDataModel data) async {
    var auth = context.read<AuthCubit>().state.authorized;
    if (auth) {
      var comments = await Navigator.of(context).push(CupertinoPageRoute(
          builder: (cxt)=>ProductComments(adsId: data.id, hideReply: data.closeReply)))
      ;
      if (comments != null) {
        commentCubit.onSetCommentsList(comments);
      }
    } else {
      LoadingDialog.showAuthDialog(context: context);
    }
  }

  void addToFavourite(BuildContext context, AdsModel model) async {
    await favouriteCubit.setAddToFavourite(context, model);
    productDetailsCubit.fetchAdsDetails(
        context, model.id, favouriteCubit, commentCubit);
    HomeMainData.pagingController.refresh();
  }

  void removeFromFavourite(BuildContext context, AdsModel model) async {
    await favouriteCubit.setRemoveFavourite(context, model);
    productDetailsCubit.fetchAdsDetails(
        context, model.id, favouriteCubit, commentCubit);
    HomeMainData.pagingController.refresh();
  }

  void setFollowAds(BuildContext context, AdsModel model) async {
    await favouriteCubit.setAddToFollower(context, model.id);
    productDetailsCubit.fetchAdsDetails(
        context, model.id, favouriteCubit, commentCubit);
  }

  void setAddComment(BuildContext context, int id) async {
    if (comment.text.isNotEmpty) {
      await commentCubit.setAddComment(context, id, comment.text);
      comment.text = "";
      HomeMainData.pagingController.refresh();
    }
  }

  void setAddReply(BuildContext context, int id) async {
    if (repFormKey.currentState.validate()) {
      await commentCubit.setAddReply(context, id, reply.text);
      reply.text = "";
      Navigator.pop(context);
    }
  }

  void setRemoveAd(BuildContext context, AdsModel model) {
    if (formKey.currentState.validate()) {
      stRemoveMyAd(context, model, reason.text);
    }
  }

  stRemoveMyAd(BuildContext context, AdsModel adsModel, String reason) async {
    var result = await CustomerRepository(context).removeMyAd(adsModel.id);
    if (result) {
      Navigator.of(context).pop();
      HomeMainData.pagingController.refresh();
      AutoRouter.of(context).popUntilRouteWithName(HomeRoute.name);
    }
  }

  void navigateTo(BuildContext context, AdsDataModel model) {
    AutoRouter.of(context).push(EditOfferImagesRoute(model: model));
  }

  void refreshMyAd(BuildContext context,int id)async{
    await CustomerRepository(context).refreshMyAd(id);
  }

}
