import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_flutter/customer/models/ChatModel.dart';
import 'package:base_flutter/general/blocs/chat_count_cubit/chat_count_cubit.dart';
import 'package:base_flutter/general/blocs/user_cubit/user_cubit.dart';
import 'package:base_flutter/general/constants/ModaLs/LoadingDialog.dart';
import 'package:base_flutter/general/models/UserModel.dart';
import 'package:base_flutter/general/widgets/AnimationContainer.dart';
import 'package:base_flutter/general/constants/MyColors.dart';
import 'package:base_flutter/general/utilities/routers/RouterImports.gr.dart';
import 'package:base_flutter/general/widgets/CachedImage.dart';
import 'package:base_flutter/general/widgets/DefaultAppBar.dart';
import 'package:base_flutter/general/widgets/MyText.dart';
import 'conversation_cubit/conversation_cubit.dart';


part 'Conversations.dart';
part 'ConversationData.dart';