import 'dart:ui';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/comman/models/order.dart';
import 'package:gadha/modules/driver/widgets/order_more_options_pop_up.dart';
import 'package:gadha/modules/shared/curren_location/cubit/current_location_cubit.dart';
import 'package:gadha/comman/services/location_services.dart';

import 'package:gadha/widgets/signle/app_bar.dart';
import 'package:gadha/widgets/signle/header_edit_container.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/comman/config/colors.dart';

import 'bet_on_order.dart';

class DriverOrderDetails extends StatefulWidget {
  final OrderEntity order;
  const DriverOrderDetails(this.order, {Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<DriverOrderDetails> {
  void _launchToStoreMapDirections() {
    final currentDriverLocation =
        BlocProvider.of<CurrentLocationCubit>(context).currentLocation;
    LocationServices.instance.launchMapDiretions(
      fromLat: currentDriverLocation!.latitude!.toString(),
      fromLang: currentDriverLocation.longitude!.toString(),
      toLat: widget.order.place.latitude,
      toLang: widget.order.place.longtude,
    );
  }

  void _launchToClientMapDirections() {
    final currentDriverLocation =
        BlocProvider.of<CurrentLocationCubit>(context).currentLocation;
    LocationServices.instance.launchMapDiretions(
      fromLat: currentDriverLocation!.latitude!.toString(),
      fromLang: currentDriverLocation.longitude!.toString(),
      toLat: widget.order.dropPlace.latitude,
      toLang: widget.order.dropPlace.longtude,
    );
  }

  Widget buildBetButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.2, vertical: 30),
      child: InkWell(
        onTap: () => Q.dialog(Dialog(child: OrderBet(widget.order))),
        child: Container(
          height: size.height * 0.06,
          decoration: BoxDecoration(
            color: AppColors.darkGreenAccent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 0.1,
                blurRadius: 5,
              ),
            ],
          ),
          child: Align(
            child: Text(
              'bet'.tr,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final products = order.products;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const StanderedAppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: buildBetButton(),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              StanderedAppBar(
                appBarType: AppBarType.navigator,
                centerChild: Text(
                  'order_details'.tr,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              AgentPopupOrderOptions(
                title: widget.order.owner.name,
                place: widget.order.dropPlace.name,
                orderID: widget.order.id.toString(),
                image: ClipOval(
                  child: FancyShimmerImage(
                    imageUrl: fullImagePath(widget.order.owner.image),
                    boxFit: BoxFit.cover,
                    shimmerBaseColor: Colors.grey[300],
                    shimmerHighlightColor: Colors.grey[100],
                    height: size.width * 0.08,
                    width: size.width * 0.08,
                  ),
                ),
                onClientAvatarPressed: () {},
              ),
              SizedBox(height: size.height * 0.01),
              HeaderAndEditContainer(title: 'the_order'.tr),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.06, vertical: 15),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final product = order.products![index];
                    return Row(
                      children: <Widget>[
                        Text('\t${product.quantity}\t\t\t'),
                        Text(product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            )),
                        const Spacer(),
                        if (product.image != null)
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),

                              // child: FaIcon(
                              //   FontAwesomeIcons.images,
                              //   color: Colors.green,
                              // ),
                              child: Image.network(
                                fullImagePath(product.image),
                                width: width * .10,
                                height: width * .10,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: products?.length ?? 0,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              HeaderAndEditContainer(
                onTap: _launchToStoreMapDirections,
                title: 'store_address'.tr,
                trailing: Row(
                  children: [
                    Text(
                      'show'.tr,
                      style: const TextStyle(
                        color: AppColors.boldBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      FontAwesomeIcons.mapMarkerAlt,
                      color: AppColors.darkGreen,
                      size: 15,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: size.width * 0.02,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child:
                          Icon(Icons.location_on, color: AppColors.lightBlack),
                    ),
                    Expanded(
                      child: Text(
                        order.place.address,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              HeaderAndEditContainer(
                onTap: _launchToClientMapDirections,
                title: 'client_address'.tr,
                trailing: Row(
                  children: [
                    Text(
                      'show'.tr,
                      style: const TextStyle(
                        color: AppColors.boldBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      FontAwesomeIcons.locationArrow,
                      color: AppColors.darkGreen,
                      size: 15,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: width * 0.02),
                padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.location_on,
                        color: AppColors.lightBlack,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.order.dropPlace.address,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              if (order.note != null && order.note!.isNotEmpty) ...[
                HeaderAndEditContainer(title: 'order_note'.tr),
                Container(
                  margin: EdgeInsets.symmetric(vertical: width * 0.02),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.stickyNote,
                          color: AppColors.lightBlack,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          order.note!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.02),
              ],
              HeaderAndEditContainer(title: 'payment'.tr),
              Container(
                alignment:
                    isArabic ? Alignment.centerRight : Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: size.width * 0.04),
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'cash'.tr,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
