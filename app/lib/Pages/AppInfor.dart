import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Thongtin extends StatefulWidget {
  const Thongtin({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ThongtinState createState() => _ThongtinState();
}

class _ThongtinState extends State<Thongtin> {
  _sendingMails() async {
    var url = Uri.parse("mailto:hungphaolo566@gmail.com");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendingSMS() async {
    var url = Uri.parse("sms:0799020823");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Thông tin ứng dụng'),
          backgroundColor: Colors.green,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 200.0,
                ),
                Container(
                  height: 20.0,
                ),
                const Text(
                  'Nếu có phản hồi, hãy gửi mail cho chúng tôi',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.green,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 10.0,
                ),
                TextButton(
                  onPressed: _sendingMails,
                  style: ButtonStyle(
                    padding:
                    MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(color: Colors.black),
                    ),
                  ),
                  child: const Text('Tại đây'),
                ), // ElevatedButton
                Container(
                  height: 20.0,
                ),
                const Text(
                  'Hoặc gửi tin nhắn',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.green,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 10.0,
                ),
                TextButton(
                  onPressed: _sendingSMS,
                  style: ButtonStyle(
                    padding:
                    MaterialStateProperty.all(const EdgeInsets.all(5.0)),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(color: Colors.black),
                    ),
                  ),
                  child: const Text('Tại đây'),
                ), // ElevatedButton

              ],
            ),
          ),
        ),
      );
  }
}
