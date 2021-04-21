import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:base_flutter/general/utilities/localization/LocalizationMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_flutter/customer/models/AdsDataModel.dart';
import 'package:base_flutter/customer/models/Dtos/UpdateAdModel.dart';
import 'package:base_flutter/customer/models/ImageModel.dart';
import 'package:base_flutter/customer/screens/edit_offer_images/edit_images_cubit/edit_images_cubit.dart';
import 'package:base_flutter/customer/screens/edit_offer_images/exist_image_cubit/exist_image_cubit.dart';
import 'package:base_flutter/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/utilities/routers/RouterImports.gr.dart';
import 'package:base_flutter/general/utilities/utils_functions/UtilsImports.dart';
import 'package:base_flutter/general/widgets/CachedImage.dart';
import 'package:base_flutter/general/widgets/DefaultAppBar.dart';
import 'package:base_flutter/general/widgets/MyText.dart';

part 'EditImagesData.dart';
part 'EditOfferImages.dart';