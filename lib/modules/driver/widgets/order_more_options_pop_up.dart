import 'dart:math' as math;
import 'dart:ui';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_show_more/flutter_show_more.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:gadha/modules/shared/chat/order_options.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/comman/config/colors.dart';

double degToRad(double angle) {
  return -angle * (math.pi / 180);
}

class AgentPopupOrderOptions extends StatefulWidget {
  final String? place;
  final String? title;
  final double? shippingCost;
  final String? orderID;
  final Widget? image;
  final String? imagePath;
  final VoidCallback? onCallClient;
  final VoidCallback? onIssueBill;
  final VoidCallback? onProblemReport;
  final VoidCallback? onOrderIsDelievered;
  final VoidCallback? onClientAvatarPressed;
  final bool isFinalOrderDetails;
  const AgentPopupOrderOptions({
    Key? key,
    this.place,
    this.onCallClient,
    this.onIssueBill,
    this.onProblemReport,
    this.onOrderIsDelievered,
    this.isFinalOrderDetails = false,
    this.title,
    this.shippingCost,
    this.orderID,
    this.image,
    this.onClientAvatarPressed,
    this.imagePath,
  }) : super(key: key);
  @override
  _AgentPopupOrderOptionsState createState() => _AgentPopupOrderOptionsState();
}

class _AgentPopupOrderOptionsState extends State<AgentPopupOrderOptions>
    with SingleTickerProviderStateMixin {
  bool showMenu = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  final _linearGradient1 = AppColors.famousGradientOrder();
  final _linearGradient2 =
      LinearGradient(colors: [Colors.white, Colors.grey[50]!]);
  LinearGradient? _containerLinearGradient;
  @override
  void initState() {
    _containerLinearGradient = _linearGradient1;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    super.initState();
  }

  Future<void> toggleDirection() async {
    if (!widget.isFinalOrderDetails) return;
    setState(() {
      showMenu = !showMenu;
      _containerLinearGradient = _containerLinearGradient == _linearGradient1
          ? _linearGradient2
          : _linearGradient1;
    });
    return _animationController.isCompleted
        ? _animationController.reverse()
        : _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _titles = <String>[
      'call_client'.tr,
      'issue_bill'.tr,
      //.tr.translate('problem_report'),
      //.tr.translate('delivery_completed'),
    ];
    final _icons = <IconData>[
      FontAwesomeIcons.phoneAlt,
      FontAwesomeIcons.camera,
      // FontAwesomeIcons.exclamation,
      // FontAwesomeIcons.thumbsUp,
    ];
    return ModalEntry(
      visible: showMenu,
      onClose: () {
        toggleDirection();
      },
      childAnchor: Alignment.bottomCenter,
      menuAnchor: Alignment.topCenter,
      menu: GestureDetector(
        onTap: () {
          toggleDirection();
        },
        child: BlurryContainer(
          bgColor: AppColors.veryLightTransparentBlue.withOpacity(0.7),
          borderRadius: BorderRadius.circular(0),
          blur: 2,
          height: size.height * (1 - (0.06 + 0.09)),
          width: size.width,
          child: AnimationLimiter(
            child: ListView.builder(
              itemCount: _titles.length,
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05, vertical: 2),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await toggleDirection();
                    switch (index) {
                      case 0:
                        if (widget.onCallClient != null) {
                          widget.onCallClient!();
                        }
                        break;
                      case 1:
                        //issue bill
                        if (widget.onIssueBill != null) {
                          widget.onIssueBill!();
                        }
                        break;
                      case 2:
                        if (widget.onOrderIsDelievered != null) {
                          widget.onOrderIsDelievered!();
                        }
                        break;
                    }
                  },
                  child: AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Container(
                          height: size.height * 0.06,
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.08),
                          child: OrderPopupRow(
                            title: _titles[index],
                            icon: _icons[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          toggleDirection();
        },
        child: _buildOrderDetailsHeader(),
      ),
    );
  }

  Widget _buildOrderDetailsHeader() {
    return AnimatedContainer(
      duration: const Duration(seconds: 5),
      height: size.height * 0.09,
      width: size.width,
      decoration: BoxDecoration(
        gradient: _containerLinearGradient,
      ),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: widget.onClientAvatarPressed,
                    child: Container(
                      height: size.width * 0.13,
                      width: size.width * 0.13,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 1,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: widget.image ??
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: FancyShimmerImage(
                              imageUrl: widget.imagePath ?? kStoreUrl,
                            ),
                          ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ShowMoreText(
                            widget.title!,
                            maxLength: 20,
                            showMoreText: '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '${'the_place'.tr}:\t',
                                  style: const TextStyle(
                                    color: AppColors.lightBlack,
                                    fontSize: 10,
                                  ),
                                ),
                                ShowMoreText(
                                  widget.place!,
                                  maxLength: 30,
                                  showMoreText: '',
                                  style: const TextStyle(
                                    color: AppColors.lightBlack,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (widget.shippingCost != null &&
                              widget.shippingCost != 0) ...[
                            Row(
                              children: <Widget>[
                                Text(
                                  '${'shipping_cost'.tr}:\t',
                                  style: const TextStyle(
                                    color: AppColors.lightBlack,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(
                                  '${widget.shippingCost!.toStringAsFixed(2)} ${'rs'.tr}'
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    color: AppColors.lightBlack,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  '#${widget.orderID}'.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.boldBlack,
                    fontSize: 10,
                  ),
                ),
                if (widget.isFinalOrderDetails)
                  Container(
                    height: size.width * 0.1 * 0.741,
                    width: size.width * 0.1,
                    decoration: BoxDecoration(
                      color: AppColors.paleLightGreen.withAlpha(100),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (BuildContext context, Widget? child) {
                          final value = _animation.value;
                          return Transform.rotate(
                            angle: degToRad(-180 * value),
                            child: child,
                          );
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.chevronDown,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
