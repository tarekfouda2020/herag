import 'package:base_flutter/general/utilities/moor_db/db.dart';

class CategoryChildModel{
   List<Category> cats;
   int parentId;

  CategoryChildModel({this.cats, this.parentId});
}