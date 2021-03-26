import 'package:auto_route/auto_route.dart';
import 'package:base_flutter/general/blocs/lang_cubit/lang_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_flutter/customer/models/AdsDataModel.dart';
import 'dart:convert';

import 'package:base_flutter/customer/models/Dtos/UpdateAdModel.dart';
import 'package:base_flutter/customer/resources/CustomerRepository.dart';
import 'package:base_flutter/customer/screens/edit_offer_location/map_reply_cubit/map_reply_cubit.dart';
import 'package:base_flutter/customer/screens/home/homeTabs/home_main/HomeMainImports.dart';
import 'package:base_flutter/general/constants/Inputs/LabelTextField.dart';
import 'package:base_flutter/general/constants/Inputs/RichTextFiled.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/utilities/routers/RouterImports.gr.dart';
import 'package:base_flutter/general/utilities/validator/Validator.dart';
import 'package:base_flutter/general/widgets/DefaultAppBar.dart';
import 'package:base_flutter/general/widgets/DefaultButton.dart';
import 'package:base_flutter/general/widgets/MyText.dart';

part 'EditDetailsData.dart';
part 'EditOfferDetails.dart';