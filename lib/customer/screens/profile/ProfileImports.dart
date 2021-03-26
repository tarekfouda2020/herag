import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:base_flutter/customer/widgets/TitleButton.dart';
import 'package:base_flutter/customer/widgets/pull_refresher/CustomPullRefresh.dart';
import 'package:base_flutter/general/blocs/user_cubit/user_cubit.dart';
import 'package:base_flutter/general/utilities/routers/RouterImports.gr.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'comment_cubit/comment_cubit.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/widgets/DefaultAppBar.dart';
import 'package:base_flutter/general/widgets/MyText.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_flutter/customer/models/CommentModel.dart';
import 'package:base_flutter/general/constants/ModaLs/LoadingDialog.dart';


part 'Profile.dart';