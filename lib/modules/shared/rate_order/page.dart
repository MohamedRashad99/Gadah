import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gadha/comman/config/constants.dart';
import 'package:gadha/comman/functions.dart';
import 'package:gadha/comman/models/order.dart';

import 'package:gadha/comman/services/reviews_repo.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:gadha/widgets/signle/app_bar.dart';

class RateOrderPage extends StatefulWidget {
  final OrderEntity order;
  const RateOrderPage(this.order, {Key? key}) : super(key: key);

  @override
  _RateOrderPageState createState() => _RateOrderPageState();
}

class _RateOrderPageState extends State<RateOrderPage> {
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();
  bool _loading = false;
  double _rating = 2;
  Future<void> _rateOrdrer() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      setState(() => _loading = true);

      final _comment = _textEditingController.text.trim();
      final msg = await ReviewsRepo.rateOrder(widget.order.id,
          comment: _comment, stars: _rating);
      Q.alertWithSuccess(msg);
      await Q.back();
    } catch (e) {
      Q.alertWithErr(e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _rateOrdrer,
          child: _loading
              ? const CenterLoading()
              : const Icon(Icons.check, color: Colors.white),
        ),
        appBar: const StanderedAppBar(),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                bottom: null,
                child: StanderedAppBar(
                  appBarType: AppBarType.navigator,
                  centerChild: Text(
                    'your_rating'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: size.height * 0.06,
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.20,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Positioned(
                                left: 0,
                                right: 0,
                                top: 0,
                                child: Container(
                                  height: height * 0.25,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.famousGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -50,
                                right: -15,
                                child: SvgPicture.asset(
                                  Constants.logoWaterMark,
                                  height: height * 0.45 * 0.8,
                                  width: width * 0.95 * 0.8,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: -70,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: .1,
                                    blurRadius: 7,
                                  )
                                ],
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 80,
                                child: CircleAvatar(
                                  radius: 75,
                                  backgroundColor: AppColors.darkWhite,
                                  backgroundImage: NetworkImage(
                                      fullImagePath(widget.order.owner.image)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.07),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: size.height * 0.05),
                              Text(
                                'what_is_your_experience_with_client'.tr,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: AppColors.boldBlack,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * .015),
                                child: Directionality(
                                  textDirection: isArabic
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                                  child: RatingBar.builder(
                                    initialRating: 3,
                                    glow: false,
                                    allowHalfRating: true,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    itemBuilder: (context, _) {
                                      const raduis = 25.0;
                                      return const SizedBox(
                                        height: raduis,
                                        width: raduis,
                                        child: Icon(Icons.star,
                                            color: Colors.amber),
                                      );
                                    },
                                    onRatingUpdate: (rating) =>
                                        _rating = rating,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      '\t${'leave_a_comment'.tr}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        controller: _textEditingController,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          hintText: 'leave_a_comment'.tr,
                                          hintStyle:
                                              const TextStyle(fontSize: 14),
                                        ),
                                        validator: qValidator([
                                          IsRequired('required'.tr),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
