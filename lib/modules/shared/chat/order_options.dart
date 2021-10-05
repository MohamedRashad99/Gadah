import 'dart:math' as math;
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_show_more/flutter_show_more.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/config/network_constents.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/comman/services/auth_service.dart';
import 'package:gadha/comman/services/orders_repo.dart';
import 'package:gadha/helpers/laravel.dart';
import 'package:gadha/helpers/url_lancher.dart';
import 'package:gadha/modules/client/orders/cubit/user_offers_cubit.dart';
import 'package:gadha/modules/driver/home/orders_tab/in_porgress/cubit/orders_in_progress_cubit.dart';
import 'package:gadha/modules/driver/home/orders_tab/orders_done/cubit/orders_done_cubit.dart';
import 'package:gadha/modules/driver/order_products.dart';
import 'package:gadha/modules/shared/complains/page.dart';
import 'package:gadha/modules/shared/my_reviews/page.dart';
import 'package:gadha/modules/shared/order_bills/page.dart';
import 'package:gadha/modules/shared/rate_order/page.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/action.model.dart';

class ChatPopupOrderOptions extends StatefulWidget {
  final OrderEntity order;

  const ChatPopupOrderOptions(
    this.order, {
    Key? key,
  }) : super(key: key);
  @override
  _ChatPopupOrderOptionsState createState() => _ChatPopupOrderOptionsState();
}

class _ChatPopupOrderOptionsState extends State<ChatPopupOrderOptions>
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
    setState(() {
      showMenu = !showMenu;
      _containerLinearGradient = _containerLinearGradient == _linearGradient1
          ? _linearGradient2
          : _linearGradient1;
    });
    return await (_animationController.isCompleted
        ? _animationController.reverse()
        : _animationController.forward());
  }

  @override
  Widget build(BuildContext context) {
    final isOrderDriver =
        AuthService.currentUser!.id == widget.order.driver!.id;
    final _actions = <ActionModel>[
      ActionModel(
        title: 'rate_order'.tr,
        icon: FontAwesomeIcons.thumbsUp,
        onPress: () => Q.to(RateOrderPage(widget.order)),
      ),
      ActionModel(
        title: 'bills'.tr,
        icon: FontAwesomeIcons.moneyBill,
        onPress: () => Q.to(OrderBillsPage(
          orderEntity: widget.order,
        )),
      ),
      ActionModel(
        title: 'problem_report'.tr,
        icon: FontAwesomeIcons.exclamation,
        onPress: () => Q.to(ComplainsScreen(orderEntity: widget.order)),
      ),

      ActionModel(
        title: 'pick_place'.tr,
        icon: Icons.location_on_outlined,
        onPress: () => UrlLuncher.openMap(
          widget.order.place.latitude,
          widget.order.place.longtude,
        ),
      ),
      ActionModel(
        title: 'drop_place'.tr,
        icon: Icons.location_on_outlined,
        onPress: () => UrlLuncher.openMap(
          widget.order.dropPlace.latitude,
          widget.order.dropPlace.longtude,
        ),
      ),
      ActionModel(
        title: 'products'.tr,
        icon: FontAwesomeIcons.phoneAlt,
        onPress: () async {
          return Q.to(OrderProducts(widget.order));
        },
      ),
      // * driver actions
      if (isOrderDriver) ...[
        ActionModel(
          title: 'products'.tr,
          icon: Icons.shopping_cart,
          onPress: () async {
            return Q.to(OrderProducts(widget.order));
          },
        ),
        ActionModel(
          title: 'call_driver'.tr,
          icon: FontAwesomeIcons.phoneAlt,
          onPress: () async {
            // * call driver
            if (widget.order.driver!.phone != null) {
              final phoneNumber = 'tel://${widget.order.driver!.phone}';
              if (await canLaunch(phoneNumber)) {
                await launch(phoneNumber);
              }
            }
          },
        ),
        ActionModel(
          title: 'finish_order'.tr,
          icon: Icons.done,
          onPress: () async {
            try {
              final res = await Api.get(kFinishOrderById.replaceAll(
                  ':id', widget.order.id.toString()));
              if (res.statusCode == HttpStatus.ok) {
                Q.alertWithSuccess('order_is_done'.tr);
                await BlocProvider.of<UserOrdersCubit>(context).refresh();
                await BlocProvider.of<OrdersInProgressCubit>(context).refresh();
                await BlocProvider.of<OrdersDoneCubit>(context).refresh();
                Navigator.pop(context);
              } else {
                throw res.data.toString();
              }
            } catch (e) {
              Q.alertWithErr(e);
            }
          },
        ),
        ActionModel(
          title: 'send_arrived_notification'.tr,
          icon: Icons.notifications,
          onPress: () {
            try {
              OrdersRepo().alertWithDriverArrived(widget.order);
              Q.alertWithSuccess('done'.tr);
            } catch (e) {
              Q.alertWithErr(e);
            }
          },
        ),
      ],
      // * client ations
      if (!isOrderDriver) ...[
        ActionModel(
          title: 'find_driver_location'.tr,
          icon: FontAwesomeIcons.moneyBill,
          onPress: () => UrlLuncher.openMap(
            widget.order.driver?.lattitude ?? '',
            widget.order.driver?.langtude ?? '',
          ),
        ),
      ],
    ];

    return ModalEntry(
      visible: showMenu,
      onClose: toggleDirection,
      childAnchor: Alignment.bottomCenter,
      menuAnchor: Alignment.topCenter,
      menu: BlurryContainer(
        bgColor: AppColors.veryLightTransparentBlue.withOpacity(0.7),
        borderRadius: BorderRadius.circular(0),
        blur: 2,
        height: height * (1 - (0.06 + 0.09)),
        width: width,
        child: AnimationLimiter(
          child: ListView.builder(
            itemCount: _actions.length,
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05, vertical: 2),
            itemBuilder: (context, i) {
              return AnimationConfiguration.staggeredList(
                position: i,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.08),
                      child: OrderPopupRow(
                        icon: _actions[i].icon,
                        title: _actions[i].title,
                        onTap: () async {
                          await toggleDirection();
                          _actions[i].onPress();
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      child: _buildOrderDetailsHeader(),
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
            Row(
              children: <Widget>[
                Container(
                  height: size.width * 0.13,
                  width: size.width * 0.13,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 10)
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: InkWell(
                      onTap: () => Q.to(UserReviewsScreen(widget.order.owner)),
                      child: ClipOval(
                        child: FancyShimmerImage(
                          imageUrl: AuthService.currentUser!.id ==
                                  widget.order.owner.id
                              ? fullImagePath(widget.order.driver!.image)
                              : fullImagePath(widget.order.owner.image),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.03),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ShowMoreText(
                        widget.order.dropPlace.name,
                        maxLength: 35,
                        showMoreText: '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      ShowMoreText(
                        widget.order.dropPlace.address,
                        maxLength: 28,
                        showMoreText: '',
                        style: const TextStyle(
                          color: AppColors.lightBlack,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: width * .1 * .741,
              width: width * .1,
              decoration: BoxDecoration(
                color: AppColors.paleLightGreen.withAlpha(100),
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                onTap: toggleDirection,
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
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderPopupRow extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final IconData icon;

  const OrderPopupRow({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.boldBlackAccent,
            ),
          ),
          FaIcon(
            icon,
            size: 16,
            color: AppColors.lightBlack.withAlpha(200),
          ),
        ],
      ),
    );
  }
}

class ModalEntry extends StatelessWidget {
  const ModalEntry({
    Key? key,
    this.onClose,
    this.menu,
    this.visible,
    this.menuAnchor,
    this.childAnchor,
    this.child,
  }) : super(key: key);

  final VoidCallback? onClose;
  final Widget? menu;
  final bool? visible;
  final Widget? child;
  final Alignment? menuAnchor;
  final Alignment? childAnchor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: visible! ? onClose : null,
      child: PortalEntry(
        visible: visible!,
        portal: menu,
        portalAnchor: menuAnchor,
        childAnchor: childAnchor,
        child: IgnorePointer(
          ignoring: visible!,
          child: child,
        ),
      ),
    );
  }
}

double degToRad(double angle) {
  return -angle * (math.pi / 180);
}
