import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/helpers/auth.dart';
import 'package:gadha/modules/shared/curren_location/widget.dart';
import 'package:queen/queen.dart';

enum AppBarType {
  // no back button
  placeholder,
  navigator,
  navigatorExtended,
  homeExtended,
  agentHomeExtended,
}

class StanderedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarType appBarType;
  final Widget? centerChild;
  final List<Widget>? trailingActions;
  final Widget? leading;
  final Color? backgroundColor;
  final String extendedTitle;
  final String? profilePhotoUrl;
  final bool activeValue;
  final void Function(bool value)? onActiveStatusChange;
  final VoidCallback? onBack;
  final Color? textColor;
  final bool showBackButton;

  ///Works only with `appBarType` = `AppBarType.homeExtended`
  final VoidCallback? onTap;
  const StanderedAppBar({
    Key? key,
    this.showBackButton = true,
    this.appBarType = AppBarType.placeholder,
    this.centerChild,
    this.backgroundColor,
    this.leading,
    this.trailingActions,
    this.extendedTitle = '',
    this.profilePhotoUrl,
    this.onTap,
    this.activeValue = false,
    this.onActiveStatusChange,
    this.onBack,
    this.textColor,
  }) : super(key: key);

  Widget appBar() {
    return Container(
      color: backgroundColor,
      height: height * .06,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: AppColors.famousGradient(
          end: Alignment.centerRight,
          begin: Alignment.centerLeft,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -60,
              right: -10,
              child: SvgPicture.asset(
                Constants.userDetailsBG2,
                height: size.height * 0.25,
                width: size.width * 0.5,
              ),
            ),
            Positioned.directional(
              textDirection: currentTextDirection,
              start: 0,
              top: -35,
              child: Container(
                color: Colors.transparent,
                child: SvgPicture.asset(
                  Constants.userDetailsBG4,
                  color: const Color(0xff956CC0),
                  height: 90,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Align(
              alignment:
                  isArabic ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                child: leading ??
                    IconButton(
                      padding: const EdgeInsets.all(7.0),
                      icon: Directionality(
                        textDirection: currentTextDirection,
                        child: Icon(
                          Icons.chevron_right_sharp,
                          size: size.aspectRatio * 50,
                        ),
                      ),
                      color: Colors.white,
                      onPressed: () {
                        if (onBack != null) onBack!();
                        Q.back();
                      },
                    ),
              ),
            ),
            Center(child: centerChild),
            //Trailing
            Align(
              alignment:
                  isArabic ? const Alignment(-0.9, 0) : const Alignment(0.9, 0),
              child: trailingActions != null && trailingActions!.isNotEmpty
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: trailingActions!,
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBarExtended() {
    return Container(
      color: backgroundColor,
      height: height * 0.11,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: AppColors.famousGradient(
          end: Alignment.centerRight,
          begin: Alignment.centerLeft,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -50,
              right: -10,
              child: SvgPicture.asset(
                Constants.logoWaterMark,
                height: height * .25 * .9,
                width: width * .5 * .9,
              ),
            ),
            //Leading
            Align(
              alignment: isArabic
                  ? const Alignment(1, -0.55)
                  : const Alignment(-1, -0.55),
              child: SizedBox(
                child: leading ??
                    IconButton(
                      padding: const EdgeInsets.all(7.0),
                      icon: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Icon(
                          Icons.chevron_right_sharp,
                          size: size.aspectRatio * 50,
                        ),
                      ),
                      color: Colors.white,
                      onPressed: Q.back,
                      // onPressed: () {
                      //   log("object");
                      // },
                    ),
              ),
            ),
            Center(child: centerChild),
            //Trailing
            Align(
              alignment: isArabic ? Alignment.topLeft : Alignment.topRight,
              child: trailingActions != null && trailingActions!.isNotEmpty
                  ? Row(children: trailingActions!)
                  : Container(),
            ),
            Align(
              alignment: isArabic
                  ? const Alignment(0.8, 0.65)
                  : const Alignment(-0.8, 0.65),
              child: Text(
                extendedTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget homeExtended() {
    return Container(
      height: height * .085,
      width: width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -80,
              right: -5,
              child: SvgPicture.asset(Constants.logoWaterMark),
            ),
            //Leading
            Align(
              alignment:
                  isArabic ? const Alignment(0.9, 0) : const Alignment(-0.9, 0),
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      ifIsNotLoggedInAskElseAct(onTap!);
                    },
                    child: CircleAvatar(
                      radius: 26,
                      backgroundColor: AppColors.darkWhite,
                      backgroundImage: profilePhotoUrl != null
                          ? NetworkImage(profilePhotoUrl!)
                          : null,
                      child: Center(
                        child: profilePhotoUrl != null
                            ? const SizedBox()
                            : const FaIcon(
                                FontAwesomeIcons.user,
                                color: AppColors.darkGreenAccent,
                              ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: AppColors.boldBlackAccent,
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.bars,
                          color: Colors.white,
                          size: 9,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment:
                  isArabic ? const Alignment(-0.9, 0) : const Alignment(0.9, 0),
              child: MyCurrentLocation(textColor: textColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget driverHomeExtended() {
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: AppColors.famousGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -100,
              right: 0,
              child: SvgPicture.asset(
                Constants.logoWaterMark,
                height: size.height * 0.30,
                width: size.width * 0.90,
              ),
            ),
            Align(
              alignment: isArabic
                  ? const Alignment(0.9, -0.70)
                  : const Alignment(-0.9, -0.70),
              child: GestureDetector(
                onTap: onTap,
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: AppColors.darkWhite,
                      backgroundImage: profilePhotoUrl != null
                          ? NetworkImage(profilePhotoUrl!)
                          : null,
                      child: Center(
                        child: profilePhotoUrl != null
                            ? Container()
                            : const FaIcon(
                                FontAwesomeIcons.user,
                                color: AppColors.darkGreenAccent,
                              ),
                      ),
                    ),
                    const Positioned(
                      left: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        radius: 9,
                        backgroundColor: AppColors.boldBlackAccent,
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.bars,
                            color: Colors.white,
                            size: 9,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment:
                  isArabic ? const Alignment(-0.9, 0) : const Alignment(0.9, 0),
              child: MyCurrentLocation(textColor: textColor),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (appBarType) {
      case AppBarType.placeholder:
        return AppBar(
          backgroundColor: backgroundColor ?? AppColors.lightBlue,
          centerTitle: true,
          title: centerChild,
          elevation: 0,
        );
      case AppBarType.navigator:
        return appBar();
      case AppBarType.navigatorExtended:
        return appBarExtended();
      case AppBarType.homeExtended:
        return homeExtended();
      case AppBarType.agentHomeExtended:
        return driverHomeExtended();
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}
