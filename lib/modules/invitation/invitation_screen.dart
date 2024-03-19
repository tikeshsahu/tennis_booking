import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

// class InvitationScreen extends StatelessWidget {
//   const InvitationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Invitations'),
//       ),
//       body: const Center(
//         child: Text('Invitations'),
//       ),
//     );
//   }
// }

class InvitationScreen extends StatefulWidget {
  @override
  _InvitationScreenState createState() => _InvitationScreenState();
}

class _InvitationScreenState extends State<InvitationScreen> {
  List<String> selectedNumbers = [];

  @override
  void initState() {
    super.initState();
    requestContactsPermission();
  }

  Future<void> requestContactsPermission() async {
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      await Permission.contacts.request();
    }
  }

  selectContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    print(contacts);
    // print the name of all contacts
    for (var contact in contacts) {
      print(contact.displayName);
    }

    List<String> numbers = [];
    //for (var contact in contacts) {
      // for (var phone in contact.phones!) {
      //   numbers.add(phone.value.toString());
      // }  
    //}

  

    print(numbers.length);
    // if (numbers.isEmpty) {
    //   Get.dialog(const Text('No contacts available.'));
    //   print('No contacts available.');
    //   return;
    // }

    // show Getx Dialog
    Get.defaultDialog(
      title: 'Select Contacts',
      content: Container(
        height: 300,
        width: 300,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(numbers[index]),
              // trailing: Obx(() {
              //   return selectedNumbers.contains(numbers[index]) ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank);
              // }),
              onTap: () {
                if (selectedNumbers.contains(numbers[index])) {
                  selectedNumbers.remove(numbers[index]);
                } else {
                  selectedNumbers.add(numbers[index]);
                }
                setState(() {});
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Get.back(result: selectedNumbers);
            sendInvitation(selectedNumbers);
            // openWhatsapp(context: context, text: "dvhdwj", number: "+919617622633")
          },
          child: const Text('Done'),
        ),
      ],
    );
  }

  Future<void> sendInvitation(List<String> selectedNumbers) async {
    String message = "Hey, let's play tennis! Join me by booking a court here: 'Jaii ho' ";

    for (var number in selectedNumbers) {
      // Construct the WhatsApp or message URL
      String url = 'https://wa.me/$number?text=${Uri.encodeComponent(message)}';
      // Launch the URL
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tennis Invitation App'),
      ),
      body: Center(
        child:
            // ElevatedButton(
            //   onPressed: () async {
            //     await requestContactsPermission();
            //     List<String> selectedContacts = await selectContacts();
            //     if (selectedContacts.isNotEmpty) {
            //       await sendInvitation(selectedContacts);
            //     }
            //   },
            //   child: const Text('Send Invitations'),
            // ),
            TextButton(
          // onPressed: () async{
          //   final url = Uri.parse('sms:+919617622633');
          //   if (await canLaunchUrl(url)) {
          //     await launchUrl(url);
          //   } else {
          //     throw 'Could not launch $url';
          //   }
          // },
          onPressed: () => selectContacts(),
          //openWhatsapp(context: context, text: "dvhdwj", number: "+919617622633"),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.sms,
                color: Color.fromARGB(255, 106, 130, 238),
                size: 30,
              ),
              SizedBox(width: 18.0),
              Text('+123 456 789', style: TextStyle(color: Color.fromARGB(255, 42, 225, 137), fontSize: 18.0, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  void openWhatsapp({required BuildContext context, required String text, required String number}) async {
    var whatsapp = number; //+92xx enter like this
    var whatsappURlAndroid = "whatsapp://send?phone=$whatsapp&text=$text";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(
          whatsappURLIos,
        ));
      } else {
        Get.snackbar("Error", "Whatsapp not installed");
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        Get.snackbar("Error", "Whatsapp not installed");
      }
    }
  }
}
