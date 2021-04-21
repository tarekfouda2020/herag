import 'package:base_flutter/general/utilities/localization/LocalizationMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base_flutter/customer/models/CommentModel.dart';
import 'package:base_flutter/general/constants/Inputs/RichTextFiled.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/utilities/validator/Validator.dart';
import 'package:base_flutter/general/widgets/DefaultAppBar.dart';
import 'package:base_flutter/general/widgets/DefaultButton.dart';
import 'package:base_flutter/general/widgets/MyText.dart';
import 'package:base_flutter/res.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_flutter/general/utilities/utils_functions/UtilsImports.dart';
import 'comment_cubit/comment_cubit.dart';
import 'package:base_flutter/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_flutter/customer/screens/add_offers/AddOfferImports.dart';


part 'UserComments.dart';
part 'UserCommentsData.dart';