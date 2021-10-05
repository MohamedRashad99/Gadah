import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gadha/comman/config/app.dart';
import 'package:get/get.dart';
import 'package:queen/queen.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _socialBar(
            color: const Color(0xFF25D366),
            textColor: Colors.black,
            title: 'contact_us_on_whatsapp'.tr,
            icon: FontAwesomeIcons.whatsapp,
            url: 'https://wa.me/${AppConfig.whatsappPhone}',
          ),
          const SizedBox(height: 10),
          _socialBar(
            color: const Color(0xFF0088cc),
            title: 'contact_us_on_telegram'.tr,
            icon: FontAwesomeIcons.telegram,
            url: AppConfig.telegramUrlPhone,
          ),
        ],
      ),
    );
  }
}

Widget _socialBar({
  required Color color,
  String? text,
  required IconData icon,
  required String url,
  String? title,
  Color? textColor = Colors.white,
}) {
  return Container(
    width: width * .9,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: InkWell(
        onTap: () async {
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            log('Error while launching webview');
          }
        },
        child: Row(
          children: <Widget>[
            const SizedBox(width: 10),
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(width: 20),
            if (title == null)
              Text(
                text == 'اتصل بنا' ? 'اتصل بنا' : 'تابعنا على $text',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )
            else
              Text(
                title,
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    ),
  );
}
