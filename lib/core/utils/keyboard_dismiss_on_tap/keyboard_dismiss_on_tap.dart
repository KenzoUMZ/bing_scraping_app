import 'package:flutter/widgets.dart';

class KeyboardDismissOnTap extends StatefulWidget {
  final bool dismissOnCapturedTaps;

  const KeyboardDismissOnTap({
    super.key,
    required this.child,
    this.dismissOnCapturedTaps = false,
  });

  final Widget child;

  @override
  State<KeyboardDismissOnTap> createState() => _KeyboardDismissOnTapState();

  static void ignoreNextTap(BuildContext context) {
    context
        .dependOnInheritedWidgetOfExactType<
            _KeyboardDismissOnTapInheritedWidget>()!
        .ignoreNextTap();
  }
}

class _KeyboardDismissOnTapState extends State<KeyboardDismissOnTap> {
  bool ignoreNextTap = false;

  void _hideKeyboard(BuildContext context) {
    if (ignoreNextTap) {
      ignoreNextTap = false;
    } else {
      var currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _KeyboardDismissOnTapInheritedWidget(
      ignoreNextTap: () {
        ignoreNextTap = true;
      },
      child: !widget.dismissOnCapturedTaps
          ? GestureDetector(
              onTap: () {
                _hideKeyboard(context);
              },
              child: widget.child,
            )
          : Listener(
              onPointerUp: (_) {
                _hideKeyboard(context);
              },
              behavior: HitTestBehavior.translucent,
              child: widget.child,
            ),
    );
  }
}

class IgnoreKeyboardDismiss extends StatelessWidget {
  final Widget child;

  const IgnoreKeyboardDismiss({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (_) {
        KeyboardDismissOnTap.ignoreNextTap(context);
      },
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}

class _KeyboardDismissOnTapInheritedWidget extends InheritedWidget {
  const _KeyboardDismissOnTapInheritedWidget({
    required super.child,
    required this.ignoreNextTap,
  });

  final VoidCallback ignoreNextTap;

  @override
  bool updateShouldNotify(_KeyboardDismissOnTapInheritedWidget oldWidget) {
    return false;
  }
}
