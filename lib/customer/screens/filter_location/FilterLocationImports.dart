import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:base_flutter/general/utilities/localization/LocalizationMethods.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_flutter/customer/models/AdsModel.dart';
import 'package:base_flutter/customer/models/Dtos/FilterModel.dart';
import 'package:base_flutter/customer/models/Dtos/LocationModel.dart';
import 'package:base_flutter/customer/models/Dtos/MarkersModel.dart';
import 'package:base_flutter/customer/resources/CustomerRepository.dart';
import 'package:base_flutter/customer/screens/home/homeTabs/home_main/HomeMainImports.dart';
import 'package:base_flutter/general/blocs/generic_cubit/generic_cubit.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/utilities/routers/RouterImports.gr.dart';
import 'package:base_flutter/general/widgets/MyText.dart';


part 'FilterLocation.dart';
part 'FilterLocationData.dart';