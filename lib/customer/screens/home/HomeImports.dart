import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_flutter/customer/models/Dtos/BottomTabModel.dart';
import 'package:base_flutter/customer/widgets/ChatIcon.dart';
import 'package:base_flutter/customer/widgets/EndDrawer.dart';
import 'package:base_flutter/customer/widgets/NotifyIcon.dart';
import 'package:base_flutter/customer/widgets/StartDrawer.dart';
import 'package:base_flutter/general/blocs/auth_cubit/auth_cubit.dart';
import 'package:base_flutter/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/constants/VersionStatus.dart';
import 'package:base_flutter/general/utilities/routers/RouterImports.gr.dart';
import 'package:base_flutter/general/widgets/MyText.dart';
import 'home_tab_cubit/home_tab_cubit.dart';
import 'homeTabs/favourite/FavouriteImports.dart';
import 'homeTabs/notifications/NotificationImports.dart';
import 'homeTabs/home_main/HomeMainImports.dart';
import 'homeTabs/conversation/ConversationImports.dart';




part 'Home.dart';
part 'HomeData.dart';