import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/functions.dart';

import '../signle/adaptive_progress_indicator.dart';

class CustomMainButton extends StatefulWidget {
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final double borderRaduis;
  final String text;
  final double? textSize;
  final bool outline;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color? bgColor;
  final FontWeight fontWeight;
  final BoxShape shape;
  final bool isLoading;
  final bool dropShadow;
  const CustomMainButton(
      {required this.text,
      this.width,
      this.height,
      this.bgColor,
      this.outline = false,
      this.borderRaduis = 20,
      this.textSize,
      this.margin,
      this.padding = const EdgeInsets.symmetric(horizontal: 15),
      this.fontWeight = FontWeight.normal,
      this.onTap,
      this.shape = BoxShape.rectangle,
      this.isLoading = false,
      this.dropShadow = false,
      Key? key})
      : super(key: key);

  @override
  _CustomMainButtonState createState() => _CustomMainButtonState();
}

class _CustomMainButtonState extends State<CustomMainButton> {
  late bool _isLoading;

  @override
  void initState() {
    _isLoading = widget.isLoading;
    super.initState();
  }

  @override
  void didUpdateWidget(CustomMainButton oldWidget) {
    if (oldWidget.isLoading != widget.isLoading) {
      _isLoading = widget.isLoading;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.outline) {
      return IgnorePointer(
        ignoring: _isLoading,
        child: InkWell(
          onTap: widget.onTap,
          child: Container(
            width: widget.width,
            height: widget.height,
            padding: widget.width == null ? widget.padding : null,
            margin: widget.margin,
            decoration: BoxDecoration(
              shape: widget.shape,
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(widget.borderRaduis),
              ),
              border: Border.all(
                color: AppColors.darkGreen,
                width: 1.3,
              ),
            ),
            child: Center(
              child: _buildText(),
            ),
          ),
        ),
      );
    }
    return IgnorePointer(
      ignoring: _isLoading,
      child: InkWell(
        onTap: widget.onTap,
        child: Stack(
          children: <Widget>[
            Center(
              child: Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      widget.borderRaduis,
                    ),
                  ),
                ),
                elevation: widget.dropShadow ? 5 : 0,
                child: Container(
                  width: widget.width,
                  height: widget.height,
                  padding: widget.width == null ? widget.padding : null,
                  decoration: BoxDecoration(
                    shape: widget.shape,
                    gradient: widget.bgColor != null
                        ? null
                        : AppColors.famousGradient(),
                    color: widget.bgColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        widget.borderRaduis,
                      ),
                    ),
                  ),
                  child: _isLoading
                      ? Container()
                      : Center(
                          child: _buildText(),
                        ),
                ),
              ),
            ),
            Center(
              child: !_isLoading
                  ? Container()
                  : Container(
                      width: widget.width,
                      height: widget.height,
                      padding: widget.width == null ? widget.padding : null,
                      decoration: BoxDecoration(
                        shape: widget.shape,
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            widget.borderRaduis,
                          ),
                        ),
                      ),
                      child: Center(
                        child: _buildText(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText() {
    if (_isLoading) {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Text(
              '${widget.text}...',
              style: TextStyle(
                color: !widget.outline ? AppColors.white : AppColors.boldBlack,
                fontSize: widget.textSize ?? 15,
                fontWeight: widget.fontWeight,
              ),
            ),
          ),
          Positioned.directional(
            textDirection: currentTextDirection,
            end: MediaQuery.of(context).size.width * 0.22,
            child: const CenterLoading(),
          ),
        ],
      );
    }
    return Text(
      widget.text,
      style: TextStyle(
        color: !widget.outline ? AppColors.white : AppColors.boldBlack,
        fontSize: widget.textSize ?? 13,
        fontWeight: widget.fontWeight,
      ),
    );
  }
}
