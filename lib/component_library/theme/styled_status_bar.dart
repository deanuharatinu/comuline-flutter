import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StyledStatusBar extends StatelessWidget {
  const StyledStatusBar._({
    required this.child,
    required this.style,
    super.key,
  });

  const StyledStatusBar.dynamic({
    required SystemUiOverlayStyle statusBarStyle,
    required Widget child,
    Key? key,
  }) : this._(
          child: child,
          style: statusBarStyle,
          key: key,
        );

  const StyledStatusBar.light({
    required Widget child,
    Key? key,
  }) : this._(
          child: child,
          style: SystemUiOverlayStyle.light,
          key: key,
        );

  const StyledStatusBar.dark({
    required Widget child,
    Key? key,
  }) : this._(
          child: child,
          style: SystemUiOverlayStyle.dark,
          key: key,
        );

  final Widget child;
  final SystemUiOverlayStyle style;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: style,
      child: child,
    );
  }
}
