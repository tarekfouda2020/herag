import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:base_flutter/customer/screens/product_comments/ProCommentsImports.dart';
import 'package:base_flutter/general/utilities/localization/LocalizationMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:base_flutter/customer/models/AdsDetailsModel.dart';
import 'package:base_flutter/customer/models/CommentModel.dart';
import 'package:base_flutter/customer/models/ImageModel.dart';
import 'package:base_flutter/customer/models/ReplyModel.dart';
import 'package:base_flutter/customer/resources/CustomerRepository.dart';
import 'package:base_flutter/customer/screens/home/homeTabs/home_main/HomeMainImports.dart';
import 'package:base_flutter/customer/screens/product_comments/comment_cubit/comment_cubit.dart';
import 'package:base_flutter/customer/widgets/TitleButton.dart';
import 'package:base_flutter/general/blocs/auth_cubit/auth_cubit.dart';
import 'package:base_flutter/general/blocs/user_cubit/user_cubit.dart';
import 'package:base_flutter/general/constants/Inputs/ChatTextField.dart';
import 'package:base_flutter/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/models/UserModel.dart';
import 'package:base_flutter/general/utilities/main_data/MainDataImports.dart';
import 'package:base_flutter/general/utilities/routers/RouterImports.gr.dart';
import 'package:base_flutter/general/utilities/utils_functions/UtilsImports.dart';
import 'package:base_flutter/general/utilities/validator/Validator.dart';
import 'package:base_flutter/general/widgets/CachedImage.dart';
import 'package:base_flutter/general/widgets/DefaultAppBar.dart';
import 'package:base_flutter/general/widgets/MyText.dart';
import 'package:base_flutter/res.dart';
import 'package:base_flutter/customer/models/AdsDataModel.dart';
import 'package:base_flutter/customer/models/AdsModel.dart';
import 'package:base_flutter/customer/screens/product_details/favourite_cubit/favourite_cubit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:base_flutter/customer/screens/product_details/product_details_cubit/product_details_cubit.dart';
import 'package:base_flutter/general/constants/Inputs/RichTextFiled.dart';
import 'package:base_flutter/general/widgets/DefaultButton.dart';



part 'ProDetailsData.dart';
part 'ProductDetails.dart';