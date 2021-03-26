part of  'ProCommentsImports.dart';



class ProductComments extends StatefulWidget {
  final int adsId;
  final bool hideReply;
  ProductComments({@required this.adsId,@required this.hideReply});

  @override
  _ProductCommentsState createState() => _ProductCommentsState();
}

class _ProductCommentsState extends State<ProductComments> with ProductCommentsData {
  int adsId;


  @override
  void initState() {
    adsId = widget.adsId;
    commentCubit.setFetchData(context,adsId,refresh: false);
    commentCubit.setFetchData(context,adsId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<UserCubit>().state.model;
    return Scaffold(
      appBar: DefaultAppBar(
        title: "التعليقات",
        con: context,
      ),
      backgroundColor: MyColors.white,

      body: BlocBuilder<CommentCubit,CommentState>(
        bloc: commentCubit,
        builder: (context,state){
          if(state is CommentUpdated){
            if(state.comments.length>0){
              return _buildCommentList(state.comments,provider);
            }else{
              return Center(
                child: MyText(title: "لايوجد بيانات",size: 12,color: MyColors.blackOpacity,),
              );
            }
          }else{
            return _buildLoadingView();
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()=> _buildAddCommentDialog(),
        child: Icon(Icons.add,size: 25,color: MyColors.white,),
        backgroundColor: MyColors.primary,

      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }


  Widget _buildLoadingView(){
    return Center(
      child: LoadingDialog.showLoadingView(),
    );
  }

  Widget _buildCommentList(List<CommentModel> comments,UserModel user){
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 80),
      itemCount: comments.length,
      itemBuilder: (context,index){
        return _buildCommentView(comments[index],user,index);
      },
    );
  }

  Widget _buildCommentView(CommentModel model,UserModel user,int index){
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
                visible: model.fKUser== user.id,
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
                      offstage: widget.hideReply,
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
        _buildReplyList(model.replyList,user,index)
      ],
    );
  }

  Widget _buildReplyList(List<ReplyModel> replies,UserModel user,int index){
    return Column(
      children: List.generate(replies.length, (position) {
        return _buildReplyView(replies[position],user,index);
      }),
    );
  }

  Widget _buildReplyView(ReplyModel model,UserModel user,int index){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      decoration: BoxDecoration(
          color: MyColors.greyWhite.withOpacity(.1),
          border: Border(
              bottom: BorderSide(color: MyColors.grey.withOpacity(.5),width: 1)
          )
      ),
      child: Column(
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
            visible: model.fKUser==user.id,
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

  void _buildAddCommentDialog(){
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
                MyText(title: "تعليق",size: 12,color: Colors.black87,),
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
                    controller: comment,
                    height: 100,
                    label: "اكتب تعليقك ....",
                    max: 10,
                    min: 6,
                    submit: (value)=>setAddComment(context,adsId),
                    validate: (value)=>Validator(context).validateEmpty(value: value),
                  ),
                ),
                DefaultButton(title: "ارسال", onTap: ()=>setAddComment(context,adsId))
              ],
            ),
          ),

        );
      },
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
                MyText(title: "اضافة رد",size: 12,color: Colors.black87,),
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

}

