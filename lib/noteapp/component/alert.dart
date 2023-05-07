import 'package:flutter/material.dart';

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Please Wait"),
          content: Container(
              height: 50, child: Center(child: CircularProgressIndicator())),
        );
      });
}

/*
 * Future<T?> showDialog<T>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
  bool barrierDismissible = true,
  Color? barrierColor = Colors.black54,
  String? barrierLabel,
  bool useSafeArea = true,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
}) 
 */

/*
  * (new) AlertDialog AlertDialog({
  Key? key,
  Widget? icon,
  EdgeInsetsGeometry? iconPadding,
  Color? iconColor,
  Widget? title,
  EdgeInsetsGeometry? titlePadding,
  TextStyle? titleTextStyle,
  Widget? content,
  EdgeInsetsGeometry? contentPadding,
  TextStyle? contentTextStyle,
  List<Widget>? actions,
  EdgeInsetsGeometry? actionsPadding,
  MainAxisAlignment? actionsAlignment,
  OverflowBarAlignment? actionsOverflowAlignment,
  VerticalDirection? actionsOverflowDirection,
  double? actionsOverflowButtonSpacing,
  EdgeInsetsGeometry? buttonPadding,
  Color? backgroundColor,
  double? elevation,
  Color? shadowColor,
  Color? surfaceTintColor,
  String? semanticLabel,
  EdgeInsets insetPadding = _defaultInsetPadding,
  Clip clipBehavior = Clip.none,
  ShapeBorder? shape,
  AlignmentGeometry? alignment,
  bool scrollable = false,
})
 */