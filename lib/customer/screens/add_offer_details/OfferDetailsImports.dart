import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:base_flutter/general/blocs/lang_cubit/lang_cubit.dart';
import 'package:base_flutter/general/utilities/localization/LocalizationMethods.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:base_flutter/customer/models/DropDownModel.dart';
import 'package:base_flutter/customer/models/Dtos/AddAdsModel.dart';
import 'package:base_flutter/customer/models/SpecificationHeaderModel.dart';
import 'package:base_flutter/customer/models/SpecificationModel.dart';
import 'package:base_flutter/customer/resources/CustomerRepository.dart';
import 'package:base_flutter/customer/screens/add_offer_details/cats_inputs_cubit/cats_inputs_cubit.dart';
import 'package:base_flutter/customer/screens/add_offer_details/group_cubit/group_cubit.dart';
import 'package:base_flutter/customer/screens/add_offer_details/header_cubit/header_cubit.dart';
import 'package:base_flutter/general/constants/Inputs/DropdownTextField.dart';
import 'package:base_flutter/general/constants/Inputs/LabelTextField.dart';
import 'package:base_flutter/general/constants/Inputs/RichTextFiled.dart';
import 'package:base_flutter/general/constants/Inputs/custom_dropDown/CustomDropDown.dart';
import 'package:base_flutter/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/utilities/moor_db/db.dart';
import 'package:base_flutter/general/utilities/routers/RouterImports.gr.dart';
import 'package:base_flutter/general/utilities/validator/Validator.dart';
import 'package:base_flutter/general/widgets/DefaultAppBar.dart';
import 'package:base_flutter/general/widgets/DefaultButton.dart';
import 'package:base_flutter/general/widgets/MyText.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_flutter/customer/models/SpecificationGroupModel.dart';
import 'package:base_flutter/customer/screens/add_offer_details/desc_cubit/desc_cubit.dart';
import 'package:base_flutter/customer/models/Dtos/CatPropertyModel.dart';
import 'package:base_flutter/customer/models/PropertyModel.dart';
import 'package:base_flutter/customer/screens/add_offer_details/ads_phone_cubit/ads_phone_cubit.dart';
import 'dart:convert';


part 'OfferDetailsData.dart';
part 'AddOfferDetails.dart';