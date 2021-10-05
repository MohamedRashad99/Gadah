import 'package:gadha/comman/models/order.dart';
import 'package:gadha/comman/models/priver_range.dart';
import 'package:gadha/comman/services/location_services.dart';
import 'package:gadha/helpers/price_range.dart';
import 'package:gadha/modules/driver/home/orders_tab/to_offer/cubit/orders_to_offer_cubit.dart';
import 'package:gadha/comman/services/offers_repo.dart';
import 'package:gadha/widgets/signle/adaptive_progress_indicator.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';

import 'package:flutter/material.dart';
import 'package:gadha/comman/config/colors.dart';

class OrderBet extends StatefulWidget {
  final OrderEntity order;
  const OrderBet(this.order, {Key? key}) : super(key: key);

  @override
  _OrderBetState createState() => _OrderBetState();
}

class _OrderBetState extends State<OrderBet> {
  bool _isLoading = false;
  final _textEditingController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  late PriceRange priceRange;
  @override
  void initState() {
    priceRange = PriceRangeCalculator.calucaltePriceRange(
      LocationServices.instance.getDistanceBetwwen(
        double.tryParse(widget.order.place.latitude) ?? -1,
        double.tryParse(widget.order.place.longtude) ?? -1,
        double.tryParse(widget.order.dropPlace.latitude) ?? -1,
        double.tryParse(widget.order.dropPlace.longtude) ?? -1,
      ),
    );
    log(LocationServices.instance
        .getDistanceBetwwen(
          double.tryParse(widget.order.place.latitude) ?? -1,
          double.tryParse(widget.order.place.longtude) ?? -1,
          double.tryParse(widget.order.dropPlace.latitude) ?? -1,
          double.tryParse(widget.order.dropPlace.longtude) ?? -1,
        )
        .toString());

    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  String get _buildPriceHintText {
    // return '${'enter_between'.tr} ${widget.priceRange.minPrice.toStringAsFixed(1)}${'rs'.tr} ${'and'.tr} ${widget.priceRange.maxPrice.toStringAsFixed(1)}${'rs'.tr}';
    return '${'minim_price'.tr} \n'
        '${priceRange.minPrice.toStringAsFixed(1)} ${'rs'.tr}';
    // '${priceRange.maxPrice.toStringAsFixed(1)} ${'rs'.tr}';
  }

  bool _isPriceWithinBoundries() {
    final _price = double.tryParse(_textEditingController.text.trim());
    if (_price == null) {
      return false;
    } else {
      // in 10-7-2021 the clientd requested this to be only minimum with no max boundres
      // return _price <= priceRange.maxPrice && _price >= priceRange.minPrice;
      return _price >= priceRange.minPrice;
    }
  }

  bool _isValidPrice() {
    // there is input
    if (!_fromKey.currentState!.validate()) return false;
    // input is only numbers
    return _isPriceWithinBoundries();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _fromKey,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'write_your_bet'.tr,
                  style: const TextStyle(
                    color: AppColors.boldBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  _buildPriceHintText,
                  textAlign: TextAlign.center,
                  style: textTheme.headline6,
                ),
              ),
              const Divider(endIndent: 30, indent: 30, height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20)
                    .add(const EdgeInsets.only(top: 20.0, bottom: 5)),
                child: _buildPriceTextField(),
              ),
              buildConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildConfirmButton() {
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.2,
        right: size.width * 0.2,
        bottom: 30,
        top: 15,
      ),
      child: InkWell(
        onTap: () async {
          if (_isLoading) return;
          try {
            if (_isValidPrice()) {
              setState(() => _isLoading = true);
              await OffersRepo().offerToOrder(widget.order.id,
                  double.parse(_textEditingController.text.trim()));
              Q.alertWithSuccess('offer_created_sucessfuly'.tr);
              await Q.back();
              await Q.back();
              await OrdersToOfferCubit.of(context).refresh();
            } else {
              throw 'please_re_enter_number'.tr;
            }
          } catch (e) {
            setState(() => _isLoading = false);
            Q.alertWithErr(e);
          }
        },
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
            child: _isLoading
                ? const CenterLoading()
                : Text(
                    'confirm'.tr,
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

  Widget _buildPriceTextField() {
    return Theme(
      data: ThemeData(
        primaryColor: AppColors.lightBlack,
        primaryColorDark: AppColors.lightBlueAccent,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200]!,
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: TextFormField(
            controller: _textEditingController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            keyboardAppearance: Brightness.dark,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'price'.tr,
              labelStyle: TextStyle(
                color: AppColors.boldBlack.withOpacity(0.7),
              ),
              hintText: _buildPriceHintText,
              hintStyle: const TextStyle(fontSize: 13),
              errorStyle: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              // prefixIcon: Icon(FontAwesomeIcons.moneyBillAlt),
              focusColor: AppColors.lightBlack,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.teal),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: qValidator([
              IsRequired('please_re_enter_number'.tr),
              QRule((_) =>
                  !_isPriceWithinBoundries() ? 'not_valid_price'.tr : null),
            ])),
      ),
    );
  }
}
