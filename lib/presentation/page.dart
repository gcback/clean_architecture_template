library my_page;

import 'dart:ui';

import 'package:align_positioned/align_positioned.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mvvm/presentation/pages/component/action_button.dart';
import 'package:mylib/mylib.dart';
import 'package:scrolls_to_top/scrolls_to_top.dart';

import 'viewmodel/profile_controller.dart';

import 'navigation/navbar_state.dart';
import 'order_status.dart';
import 'pages/component.dart';

part 'pages/home_page.dart';
part 'pages/profiles_page.dart';
part 'pages/commute_page.dart';
part 'pages/saved_page.dart';
part 'pages/settings_page.dart';
