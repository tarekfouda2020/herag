import 'dart:convert';
import 'dart:io';
import 'package:base_flutter/general/blocs/lang_cubit/lang_cubit.dart';
import 'package:base_flutter/general/blocs/user_cubit/user_cubit.dart';
import 'package:base_flutter/general/constants/GlobalState.dart';
import 'package:base_flutter/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_flutter/general/utilities/dio_helper/cahce_lib/manager_dio.dart';
import 'package:base_flutter/general/utilities/localization/LocalizationMethods.dart';
import 'package:base_flutter/general/utilities/utils_functions/UtilsImports.dart';
import 'package:dio2/dio2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'dio_http_cache.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



part 'DioHelper.dart';


