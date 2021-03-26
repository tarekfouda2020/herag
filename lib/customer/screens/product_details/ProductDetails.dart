part of  'ProDetailsImports.dart';

class ProductDetails extends StatefulWidget {
  final AdsModel model;
  final AdsDataModel info;
  ProductDetails({@required this.model, this.info});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> with ProDetailsData {

  @override
  void initState() {
    if(widget.info!=null){
      productDetailsCubit.onModelUpdated(AdsDetailsModel(adsData: widget.info,relatedAds: []),favouriteCubit,commentCubit);
    }
    productDetailsCubit.fetchAdsDetails(context, widget.model.id, favouriteCubit,commentCubit,refresh: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserCubit>().state.model;
    return Scaffold(
        appBar: DefaultAppBar(
          title: "تفاصيل الإعلان",
          con: context,
          actions: [
            IconButton(
              icon: Icon(Icons.share_outlined,size: 25,color: MyColors.white,),
              onPressed: () =>Utils.shareApp("${MainData.baseUrl}/Advertisement/GetAdvertisementDetails/${widget.model.id}"),
            ),
          ],
        ),
        backgroundColor: MyColors.white,
        body: BlocBuilder<ProductDetailsCubit,ProductDetailsState>(
          bloc: productDetailsCubit,
          builder: (context , state){
            if(state is ProductDetailsUpdated){
              return Column(
                children: [
                  Flexible(
                    child: ListView(
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        _buildHeader(context,state.model.adsData,user),
                        _buildProductDetails(state.model.adsData.description,state.model.adsData.fromAppOrNo),
                        _buildProductImages(context,state.model.adsData.allImg),
                        _buildContactView(context,state.model.adsData,user),
                        _buildCommentList(user,state.model.adsData),
                        Offstage(
                          offstage: state.model.relatedAds.length==0,
                            child: _buildRelatedProSlider(context,state.model.relatedAds),
                        ),
                      ],
                    ),
                  ),
                  Offstage(
                    offstage: state.model.adsData.closeReply,
                    child: _buildAddCommentInput(),
                  )
                ],
              );
            }else{
              return _buildLoadingView();
            }
          },
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Offstage(
        offstage: user.userName!=widget.model.userName,
        child: FloatingActionButton(
          backgroundColor: MyColors.primary,
          onPressed: ()=> refreshMyAd(context,widget.model.id),
          child: Icon(Icons.refresh,size: 25,color: MyColors.white,),
        ),
      ),
    );
  }

  Widget _buildLoadingView(){
    return Center(
      child: LoadingDialog.showLoadingView(),
    );
  }

  Widget _buildFavouriteIcon(){
    return BlocBuilder<FavouriteCubit,FavouriteState>(
      bloc: favouriteCubit,
      builder: (context,state){
        return Badge(
          child: Visibility(
            visible: state.fav,
            child: IconButton(
              icon: Icon( Icons.favorite,size: 25,color: MyColors.black,),
              onPressed: ()=>removeFromFavourite(context, widget.model),
            ),
            replacement: IconButton(
              icon: Icon( Icons.favorite_border,size: 25,color: MyColors.black,),
              onPressed: ()=>addToFavourite(context,widget.model),
            ),
          ),
          badgeColor: Colors.red,
          badgeContent: Text("${state.count}",style: TextStyle(color: Colors.white),),
          padding: EdgeInsets.all(4),
          position: BadgePosition(top: 0,start: 5),
          toAnimate: true,
          animationType: BadgeAnimationType.scale,
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context,AdsDataModel data,UserModel user){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
      color: MyColors.greyWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: MyText(
                  title: data.title,
                  size: 12,
                  color: MyColors.greenColor,
                ),
              ),              Visibility(
                visible: data.showPrice,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 2),
                  decoration: BoxDecoration(
                    color: MyColors.primary,
                    borderRadius: BorderRadius.circular(10)
                  ),
                    child: MyText(title: "${data.price} ريال",size: 9,color: MyColors.white,)
                ),
              )
            ],
          ),
          Visibility(
            visible: data.showMap,
            child: InkWell(
              onTap: ()=> Utils.navigateToMapWithDirection(lat: data.lat,lng: data.lng,title: data.title),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Icon(Icons.location_pin,size: 20,color: MyColors.black,),
                    SizedBox(width: 5,),
                    Expanded(child: MyText(title: data.location,size: 9,color: MyColors.blackOpacity,))
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: user.id!=data.fkUser ,
            child: Container(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  InkWell(
                    onTap: ()=>AutoRouter.of(context).push(UserProductsRoute(userId: data.fkUser,userName: data.userName)),
                    child: Row(
                      children: [
                        Icon(Icons.person_outline,size: 20,color: MyColors.black,),
                        SizedBox(width: 5,),
                        MyText(title: data.userName,size: 10,color: MyColors.black,),
                      ],
                    ),
                  ),
                  Spacer(),
                  MyText(title: data.date,size: 10,color: MyColors.blackOpacity,),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: Row(
              children: [
                Visibility(
                  visible: user.id!=data.fkUser && context.watch<AuthCubit>().state.authorized,
                  child: BlocBuilder<FavouriteCubit,FavouriteState>(
                    bloc: favouriteCubit,
                    builder: (context,state){
                      return TitleButton(
                        padding: EdgeInsets.all(0),
                        iconData: Icons.wifi,
                        title: "متابعة الإعلان",
                        iconColor: state.follow?MyColors.primary:Colors.black87,
                        onTap: ()=>setFollowAds(context, widget.model),
                      );
                    },
                  ),
                ),
                Spacer(),
                Visibility(
                    visible: data.showPhone,
                    child: TitleButton(
                      padding: EdgeInsets.all(0),
                      iconData: Icons.phone,
                      title: data.userPhone,
                      iconColor: Colors.black87,
                      onTap: ()=>Utils.callPhone(phone: data.userPhone),
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetails(String details,bool fromApp){
    List<dynamic> descList=[];
    if(fromApp){
      descList = json.decode(details);
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Visibility(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(descList.length, (index) {
            return _buildDetailsItem(descList[index]);
          }),
        ),
        visible: fromApp,
        replacement: _buildDetailsItem(details),
      ),
    );
  }

  Widget _buildDetailsItem(String value){
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Expanded(child: MyText(title: "$value",size: 11,color: MyColors.black,)),
        ],
      ),
    );
  }

  Widget _buildProductImages(BuildContext context,List<ImageModel> images){

    return Column(
      children: List.generate(images.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: InkWell(
            onTap: ()=> AutoRouter.of(context).push(ImageZoomRoute(images: images, index: index)),
            child: CachedImage(
              url: images[index].url,
              width: MediaQuery.of(context).size.width,
              height: 160,
              fit: BoxFit.fill,
              borderColor: MyColors.blackOpacity,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildContactView(BuildContext context,AdsDataModel data,UserModel user){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: data.showPhone,
              child: _buildContactItem(
                  icon: Icons.call_sharp,
                  title:"${data.phone}",
                  onTab:()=> Utils.callPhone(phone: data.phone),
                  )
          ),
          Visibility(
              visible: user.id!=data.fkUser,
              child: _buildContactItem(
                  icon: Icons.mail,
                  title:"مراسلة",
                onTab:()=>navigateToChat(context,data,user),
              )
          ),
          _buildContactItem(icon: Icons.thumb_up_alt,title:"التقييم  ${data.userRate}",onTab: null),
          _buildContactItem(
            icon: Icons.comment_outlined,
            title:"التعليقات",
            onTab:()=>navigateToComments(context,data),
          ),

          //fav and report icon
          Visibility(
            visible: user.id!=data.fkUser && context.watch<AuthCubit>().state.authorized,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFavouriteIcon(),
                  IconButton(
                      icon: Icon(Icons.flag_sharp,size: 25,color: MyColors.black,),
                      onPressed: ()=>_buildAddReportDialog(context,data.id),
                  ),
                  Visibility(
                    visible: data.showPhone,
                    child: IconButton(
                        icon: Icon(FontAwesomeIcons.whatsapp,size: 25,color: MyColors.greenColor,),
                        onPressed: ()=>Utils.launchURL(url: data.whatsapp),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: MyColors.grey,width: 1)
            ),
            child: Row(
              children: [
                Image(image: AssetImage(Res.hands),width: 40,height: 40,fit: BoxFit.fill,),
                SizedBox(width: 5,),
                Container(
                  width: MediaQuery.of(context).size.width-100,
                  child: MyText(
                    title: "المبايعة وجها لوجه وبمكان عام وبتحويل بنكي يقلل الخطر والإحتيال .",
                    size: 11,
                    color: MyColors.blackOpacity,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContactItem({IconData icon, String title, Function onTab}){
    return InkWell(
      onTap: onTab,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: MyColors.greyWhite,width: 1)
          )
        ),
        child: Row(
          children: [
            Icon(icon,size: 20,color: Colors.black,),
            SizedBox(width: 10,),
            MyText(title: title,size: 12,color: MyColors.blackOpacity,)
          ],
        ),
      ),
    );
  }

  Widget _buildCommentList(UserModel user,AdsDataModel adsDataModel){
    return BlocBuilder<CommentCubit,CommentState>(
      bloc: commentCubit,
      builder: (_,state){
        var comments = state.comments.take(3).toList();
        return Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              Visibility(
                visible: comments.length!=0,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: List.generate(comments.length, (index){
                      return _buildCommentView(comments[index],user,index,adsDataModel);
                    }),
                  ),
                ),
              ),
              Visibility(
                visible: state.comments.length>0,
                child: DefaultButton(
                  onTap:()=>navigateToComments(context,adsDataModel),
                  title: "عرض كل التعليقات",
                  color: MyColors.primary,
                  textColor: MyColors.white,
                  margin: EdgeInsets.zero,
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommentView(CommentModel model,UserModel user,int index,AdsDataModel adsDataModel){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          decoration: BoxDecoration(
              color: MyColors.greyWhite.withOpacity(.1),
              border: Border(
                  bottom: BorderSide(color: MyColors.grey.withOpacity(.5),width: 1)
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: ()=>AutoRouter.of(context).push(UserProductsRoute(userId: model.fKUser,userName: model.userName)),
                child: Row(
                  children: [
                    Icon(Icons.person,size: 20,color: Colors.black87,),
                    MyText(title: model.userName,size: 12,color: Colors.black87,),
                    Spacer(),
                    MyText(title: model.creationDate,size: 10,color: Colors.black45,)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                child: MyText(
                  title: model.text,
                  size: 11,
                  color: MyColors.blackOpacity,
                ),
              ),
              Visibility(
                visible: adsDataModel.fkUser== user.id,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: ()=>_buildConfirmRemoveComment(model),
                      child: Icon(Icons.delete,size: 20,color: Colors.black87,),
                    ),
                  ],
                ),
                replacement: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Offstage(
                      offstage: adsDataModel.closeReply,
                      child: InkWell(
                        onTap: ()=>_buildAddReplyDialog(model.id),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: MyText(title: "رد",size: 11,color: MyColors.primary,),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        _buildReplyList(model.replyList,user,index,adsDataModel)
      ],
    );
  }

  Widget _buildReplyList(List<ReplyModel> replies,UserModel user,int index,AdsDataModel adsDataModel){
    return Column(
      children: List.generate(replies.length, (position) {
        return _buildReplyView(replies[position],user,index,adsDataModel);
      }),
    );
  }

  Widget _buildReplyView(ReplyModel model,UserModel user,int index,AdsDataModel adsDataModel){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      decoration: BoxDecoration(
          color: MyColors.greyWhite.withOpacity(.1),
          border: Border(
              bottom: BorderSide(color: MyColors.grey.withOpacity(.5),width: 1)
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person,size: 20,color: Colors.black87,),
              MyText(title: model.userName,size: 10,color: Colors.black87,),
              Spacer(),
              MyText(title: model.creationDate,size: 10,color: Colors.black45,)
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: MyText(
              title: model.text,
              size: 10,
              color: MyColors.blackOpacity,
            ),
          ),
          Visibility(
            visible: adsDataModel.fkUser==user.id,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: ()=>_buildConfirmRemoveReply(model,index),
                  child: Icon(Icons.delete,size: 20,color: Colors.black87,),
                ),
                SizedBox(width: 10,),
                Icon(Icons.reply,size: 20,color: Colors.black45,),
              ],
            ),
            replacement: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.reply,size: 20,color: Colors.black45,),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAddCommentInput(){
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: MyColors.greyWhite)
          )
      ),
      child: Column(
        children: [
          ChatTextField(
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
            controller: comment,
            label: "اكتب تعليقك ....",      action: TextInputAction.newline,
            submit: ()=> setAddComment(context,widget.model.id),
          ),
          SizedBox(height: 15)
        ],
      ),
    );
  }

  void _buildAddReplyDialog(int commentId){
    showCupertinoDialog(
      context: context,
      builder: (context){
        return  AlertDialog(
          backgroundColor: MyColors.white,
          titlePadding: EdgeInsets.all(0),
          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          title: Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: MyColors.primary,
                borderRadius: BorderRadius.circular(4)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(title: "اضافة رد",size: 12,color: Colors.white,),
                InkWell(
                  child: Icon(Icons.close,size: 25,color: Colors.white,),
                  onTap: ()=>Navigator.of(context).pop(),
                )
              ],
            ),
          ),

          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: repFormKey,
                  child: RichTextFiled(
                    controller: reply,
                    height: 100,
                    label: "اكتب تعليقك ....",
                    max: 10,
                    min: 6,
                    submit: (value)=>setAddReply(context,commentId),
                    validate: (value)=>Validator(context).validateEmpty(value: value),
                  ),
                ),
                DefaultButton(title: "ارسال", onTap: ()=>setAddReply(context,commentId))
              ],
            ),
          ),

        );
      },
    );
  }

  void _buildConfirmRemoveComment(CommentModel model){
    LoadingDialog.showConfirmDialog(
        context: context,
        title: "تأكيد حذف التعليق",
        confirm: ()=>commentCubit.setRemoveComment(context, model)
    );
  }

  void _buildConfirmRemoveReply(ReplyModel model,int index){
    LoadingDialog.showConfirmDialog(
        context: context,
        title: "تأكيد حذف الرد",
        confirm: ()=>commentCubit.setRemoveReply(context, index ,model)
    );
  }

  Widget _buildRelatedProSlider(BuildContext context,List<AdsModel> relatedAds){
    if(relatedAds.length>0){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MyText(title: "الإعلانات المشابهة ${relatedAds.length} إعلان",size: 12,color: MyColors.black,),
          ),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return CachedImage(
                  url: relatedAds[index].img,
                  width: MediaQuery.of(context).size.width-50,
                  height: 200,
                  colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
                  child: Icon(Icons.favorite_border,size: 25,color: MyColors.white,),
                  alignment: Alignment.topLeft,
                  fit: BoxFit.fill,
                  borderRadius: BorderRadius.circular(5),
                );
              },
              autoplay: relatedAds.length==1?false: true,
              onTap: (index)=>AutoRouter.of(context).push(ProductDetailsRoute(model: relatedAds[index])
              ),
              autoplayDelay: 3000,
              itemCount: relatedAds.length,
              scrollDirection: Axis.horizontal,
              // control: SwiperControl(),
              duration: 2000,
              autoplayDisableOnInteraction: true,
              layout: SwiperLayout.STACK,
              itemWidth: MediaQuery.of(context).size.width-50,

            ),
          ),
        ],
      );
    }else{
      return Container();
    }

  }

  void _buildAddReportDialog(BuildContext context,int id){
    showCupertinoDialog(
      context: context,
      builder: (context){
        return  AlertDialog(
          backgroundColor: MyColors.white,
          titlePadding: EdgeInsets.all(0),
          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          title: Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: MyColors.primary,
                borderRadius: BorderRadius.circular(4)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(title: "بلاغ",size: 12,color: Colors.black87,),
                InkWell(
                  child: Icon(Icons.close,size: 25,color: Colors.black87,),
                  onTap: ()=>Navigator.of(context).pop(),
                )
              ],
            ),
          ),

          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: RichTextFiled(
                    controller: report,
                    height: 100,
                    label: "اكتب السبب ....",
                    max: 10,
                    min: 6,
                    submit: (value)=>setAddReport(context,id),
                    validate: (value)=>Validator(context).validateEmpty(value: value),
                  ),
                ),
                DefaultButton(title: "ارسال", onTap: ()=>setAddReport(context,id))
              ],
            ),
          ),

        );
      },
    );
  }



}

