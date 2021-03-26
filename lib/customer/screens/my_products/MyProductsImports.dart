import 'package:auto_route/auto_route.dart';
import 'package:base_flutter/general/blocs/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:base_flutter/customer/models/AdsModel.dart';
import 'package:base_flutter/customer/models/EditAdModel.dart';
import 'package:base_flutter/customer/widgets/ProductRow.dart';
import 'package:base_flutter/customer/widgets/pull_refresher/CustomPullRefresh.dart';
import 'package:base_flutter/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/models/UserModel.dart';
import 'package:base_flutter/general/utilities/routers/RouterImports.gr.dart';
import 'package:base_flutter/general/widgets/DefaultAppBar.dart';
import 'package:base_flutter/general/widgets/MyText.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_flutter/customer/screens/my_products/my_ads_cubit/my_ads_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'MyProducts.dart';
part 'MyProductsData.dart';


