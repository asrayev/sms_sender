// import 'package:flutter/material.dart';
// import 'dart:async';
// // ignore: depend_on_referenced_packages
// import 'package:telephony/telephony.dart';
//
// onBackgroundMessage(SmsMessage message) {
//   debugPrint("onBackgroundMessage called");
// }
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   String _message = "";
//   final telephony = Telephony.instance;
//
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }
//
//   onMessage(SmsMessage message) async {
//     setState(() {
//       _message = message.body ?? "Error reading message body.";
//     });
//   }
//
//   onSendStatus(SendStatus status) {
//     setState(() {
//       _message = status == SendStatus.SENT ? "sent" : "delivered";
//     });
//   }
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//
//     final bool? result = await telephony.requestPhoneAndSmsPermissions;
//
//     if (result != null && result) {
//       telephony.listenIncomingSms(
//           onNewMessage: onMessage, onBackgroundMessage: onBackgroundMessage);
//     }
//
//     if (!mounted) return;
//   }
//   TextEditingController textController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController howManyTimesController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Plugin example app'),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.only(left: 30, right: 30),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Center(child: Text("Latest received SMS: $_message")),
//                 MyTextField(),
//                 TextButton(
//                     onPressed: () async {
//                       await telephony.openDialer("123413453");
//                     },
//                     child: Text('Open Dialer'))
//               ],
//             ),
//           ),
//         ));
//   }
//

import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

    TextEditingController textController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController howManyTimesController = TextEditingController();
  TextEditingController secund = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(right: 40, left: 40),
              child: Column(
                children: [
                  const SizedBox(height: 100,),
                  MyTextField(textController, "SMS text"),
                  const SizedBox(height: 10,),
                  MyTextField(phoneController, "Phone Number"),
                  const SizedBox(height: 10,),
                  MyTextField(howManyTimesController, "How Many times"),
                  const SizedBox(height: 10,),
                  MyTextField(secund, "Secund"),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {
                      sendSMS(howMany: howManyTimesController.text, number: phoneController.text, Text: textController.text , secund: secund.text );
                    },
                    child: Text("Send SMS"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendSMS({required String number, required String howMany, String? Text, required String secund}) async {
    int sikund = int.parse(secund);
    int numCount = int.parse(howMany);
    final Telephony telephony = Telephony.instance;
    bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
    print(permissionsGranted);
    for(int i=0; i<numCount; i++){
      await telephony.sendSms(to: number, message: Text!);
      Future.delayed(Duration(seconds: sikund));
      print("SMS Sent");
    }

  }
  SizedBox MyTextField(TextEditingController controller, String hintText) {
    return SizedBox(
      height: 70,
      child:TextFormField(
        keyboardType: TextInputType.text,
        controller: controller,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),textInputAction: TextInputAction.next,
        autofocus: true,
        decoration: InputDecoration(
          suffixIcon: const Padding(
            padding: EdgeInsets.only(right: 20),

          ),
          suffixIconConstraints:
          const BoxConstraints(minWidth: 0, minHeight: 0),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          filled: true,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide:
            const BorderSide(width: 1,),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                  width: 1)),
        ),
      ),
    );
  }

}