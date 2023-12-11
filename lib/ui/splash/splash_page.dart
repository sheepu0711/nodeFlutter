import 'package:node_flutter/controller/controller_src.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:im_animations/im_animations.dart';

class SplashPage extends GetView<SplashCtrl> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: HeartBeat(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/playstore.png',
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
