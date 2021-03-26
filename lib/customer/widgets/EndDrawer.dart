import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:base_flutter/customer/models/Dtos/CategoryChildModel.dart';
import 'package:base_flutter/customer/screens/home/homeTabs/home_main/HomeMainImports.dart';
import 'package:base_flutter/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/utilities/moor_db/db.dart';
import 'package:base_flutter/general/widgets/CachedImage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_flutter/general/widgets/MyText.dart';


class EndDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffold;
  EndDrawer({@required this.scaffold});


  void setSelectCat(Category model)async{
    HomeMainData.applyListener=false;
    var data =await scaffold.currentContext.read<MyDatabase>().selectParentCatsAsync();
    var parent = data.where((element) => element.id==model.parentId).first;
    HomeMainData.currentCat=model.id;
    HomeMainData.catTabCubit.onUpdateCatsTab(model.id);
    HomeMainData.catViewCubit.onUpdateCatRows([]);
    List<Category> children = await scaffold.currentContext.read<MyDatabase>().selectChildrenCatsAsync(model.id);
    if(children.length>0){
      HomeMainData.catViewCubit.onAddCatRow(CategoryChildModel(cats: children,parentId: model.id));
    }
    HomeMainData.tabController.animateTo(data.indexOf(parent));
    HomeMainData.currentIndex=data.indexOf(parent);
    HomeMainData.pagingController.refresh();
    Navigator.of(scaffold.currentContext).pop();


  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          width: MediaQuery.of(context).size.width*.8,
          height: MediaQuery.of(context).size.height,
          color: MyColors.greyWhite,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: StreamBuilder<List<int>>(
              stream: context.watch<MyDatabase>().selectSideCats(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: List.generate(snapshot.data.length, (index) {
                      return Column(
                        children: [
                          StreamBuilder<Category>(
                            stream: context.watch<MyDatabase>().selectCatData(snapshot.data[index]),
                            builder: (context,snapshot){
                              if(snapshot.hasData){
                                return _buildHeaderTitle(snapshot.data);
                              }else{
                                return Container();
                              }
                            },
                          ),
                          StreamBuilder<List<Category>>(
                            stream: context.watch<MyDatabase>().selectSlideChildrenCats(snapshot.data[index]),
                            builder: (context,snapshot){
                              if(snapshot.hasData){
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 20),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    runSpacing: 15,
                                    spacing: 10,
                                    runAlignment: WrapAlignment.start,
                                    children: List.generate(snapshot.data.length, (index) {
                                      return _buildBrandItem(model: snapshot.data[index]);
                                    }),
                                  ),
                                );
                              }else{
                                return Container();
                              }
                            },
                          ),
                        ],
                      );
                    }),
                  );
                }else{
                  return Center(
                    child: LoadingDialog.showLoadingView(),
                  );
                }

              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrandItem({@required Category model}){
    return InkWell(
      onTap: ()=>setSelectCat(model),
      child: Container(
        width: MediaQuery.of(scaffold.currentContext).size.width*.2,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child:  model.img.toLowerCase().contains(".svg")? _buildSvgIcon(model.img):_buildImageView(model.img),
      ),
    );
  }

  Widget _buildSvgIcon(String icon){
    return SvgPicture.network(
        icon,
        semanticsLabel: '',
        width: MediaQuery.of(scaffold.currentContext).size.width*.2,
        height: 80,
        placeholderBuilder: (BuildContext context) => SpinKitFadingCircle(
          color: MyColors.primary,
          size: 30.0,
        ));
  }

  Widget _buildImageView(String icon){
    return CachedImage(
      url: icon,
      width: MediaQuery.of(scaffold.currentContext).size.width*.2,
      height: 80,
      fit: BoxFit.fill,
      borderRadius: BorderRadius.circular(10),
    );
  }

  Widget _buildHeaderTitle(Category category){
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: MyColors.white,
          boxShadow: [
            BoxShadow(
              color: MyColors.greyWhite,
              spreadRadius: 1.2,
            )
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: MyText(title: category.name ,size: 12,color: MyColors.black,)),
        ],
      ),
    );
  }

}
