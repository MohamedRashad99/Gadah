import 'package:gadha/comman/models/priver_range.dart';

class PriceRangeCalculator {
  static const minCharge = 15.0;
  static const maxUpTo5Charge = 18.0;
  static const kMinChargeDistance = 5;

  static PriceRange calucaltePriceRange(num totalDistanceInKM) {
    if (totalDistanceInKM <= 5) {
      return const PriceRange(
        minPrice: minCharge,
        maxPrice: maxUpTo5Charge,
      );
    } else {
      return PriceRange(
        minPrice: minCharge + totalDistanceInKM.toInt(),
        maxPrice: maxUpTo5Charge + totalDistanceInKM.toInt(),
      );
    }
  }
}
