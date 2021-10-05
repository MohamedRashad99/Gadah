import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/config/colors.dart';

class LocationRow extends StatelessWidget {
  final String location;
  final String leading;
  final bool hasMarker;
  final Widget? trailing;

  const LocationRow({
    Key? key,
    required this.location,
    required this.leading,
    this.hasMarker = false,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Text(
          leading,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: size.width * 0.040),
        Expanded(
          child: Text(
            location,
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        ),
        if (hasMarker)
          trailing ??
              const Icon(FontAwesomeIcons.mapMarkerAlt,
                  size: 18, color: AppColors.lightBlack)
        else
          Container(),
      ],
    );
  }
}
