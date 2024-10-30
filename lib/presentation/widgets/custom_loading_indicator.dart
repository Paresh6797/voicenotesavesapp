import 'package:flutter/material.dart';
import '../../core/colors/app_colors.dart';
import '../../core/constants/font_weight.dart';
import 'custom_text.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final Widget? child;
  final bool? inAsyncCall;
  final double? opacity;
  final Color? color;
  final Animation<Color> valueColor;
  final loadMsg;

  const CustomLoadingIndicator(
      {Key? key,
      @required this.child,
      @required this.inAsyncCall,
      this.opacity = 0.9,
      this.color = Colors.grey,
      this.valueColor = const AlwaysStoppedAnimation<Color>(theme00b894Color),
      this.loadMsg = 'Loading...'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child!);
    if (inAsyncCall!) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity!,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: valueColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                      text: loadMsg,
                      size: 14,
                      clr: black000000Color,
                      fontWeight: bold),
                ),
              ],
            ),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
