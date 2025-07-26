import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

// create a custom hook for LiquidSwipeController
LiquidController useLiquidSwipeController() {
  return use(_LiquidSwipeControllerHook());
}

class _LiquidSwipeControllerHook extends Hook<LiquidController> {
  const _LiquidSwipeControllerHook();

  @override
  _LiquidSwipeControllerState createState() => _LiquidSwipeControllerState();
}

class _LiquidSwipeControllerState
    extends HookState<LiquidController, _LiquidSwipeControllerHook> {
  late LiquidController controller;

  @override
  void initHook() {
    super.initHook();
    controller = LiquidController();
  }

  @override
  LiquidController build(BuildContext context) {
    return controller;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
