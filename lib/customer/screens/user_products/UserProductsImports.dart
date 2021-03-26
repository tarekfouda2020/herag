import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:base_flutter/customer/models/AdOwnerModel.dart';
import 'package:base_flutter/customer/models/AdsModel.dart';
import 'package:base_flutter/customer/resources/CustomerRepository.dart';
import 'package:base_flutter/customer/widgets/ProductRow.dart';
import 'package:base_flutter/customer/widgets/TitleButton.dart';
import 'package:base_flutter/customer/widgets/pull_refresher/CustomPullRefresh.dart';
import 'package:base_flutter/general/blocs/auth_cubit/auth_cubit.dart';
import 'package:base_flutter/general/blocs/user_cubit/user_cubit.dart';
import 'package:base_flutter/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/models/UserModel.dart';
import 'package:base_flutter/general/utilities/routers/RouterImports.gr.dart';
import 'package:base_flutter/general/widgets/CachedImage.dart';
import 'package:base_flutter/general/widgets/DefaultAppBar.dart';
import 'package:base_flutter/general/widgets/DefaultButton.dart';
import 'package:base_flutter/general/widgets/MyText.dart';
import 'package:base_flutter/customer/screens/user_products/user_ads_cubit/user_ads_cubit.dart';
import 'package:base_flutter/customer/screens/user_products/rate_user_cubit/rate_user_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'ad_owner_cubit/add_owner_cubit.dart';



part 'UserProductsData.dart';
part 'UserProducts.dart';