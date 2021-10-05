import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gadha/comman/config/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChooseMapStyle extends StatefulWidget {
  final MapType mapType;
  final ValueChanged<MapType?> onChanged;

  const ChooseMapStyle({
    Key? key,
    required this.mapType,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ChooseMapStyleState createState() => _ChooseMapStyleState();
}

class _ChooseMapStyleState extends State<ChooseMapStyle> {
  MapType? _mapType;

  @override
  void initState() {
    _mapType = widget.mapType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 19),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: _itemWidget(
                  title: 'satelite'.tr,
                  pathImage: 'satellite_mode',
                  mapType: MapType.satellite)),
          const SizedBox(width: 16),
          Expanded(
              child: _itemWidget(
                  title: 'normal'.tr,
                  pathImage: 'default_mode',
                  mapType: MapType.normal)),
          const SizedBox(width: 16),
          Expanded(
              child: _itemWidget(
                  title: 'hyprid'.tr,
                  pathImage: 'light_mode',
                  mapType: MapType.hybrid)),
        ],
      ),
    );
  }

  Widget _itemWidget(
      {required String title, String? pathImage, MapType? mapType}) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 98,
          width: 107,
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() => _mapType = mapType);
                  widget.onChanged(_mapType);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _mapType == mapType
                          ? AppColors.darkGreenAccent
                          : Colors.transparent,
                      width: 2,
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/MapStyle/$pathImage.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: const Color(0xffFAF9F7),
                      borderRadius: BorderRadius.circular(4)),
                  child: Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Colors.transparent,
                    ),
                    child: Checkbox(
                      activeColor: Colors.transparent,
                      checkColor: const Color(0xff123159),
                      value: _mapType == mapType,
                      onChanged: (bool? isChecked) {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(padding: const EdgeInsets.only(top: 8), child: Text(title))
      ],
    );
  }
}
