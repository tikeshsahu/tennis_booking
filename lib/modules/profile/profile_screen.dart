import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m3m_tennis_booking/modules/profile/profile_controller.dart';
import 'package:m3m_tennis_booking/themes/app_theme.dart';
import 'package:m3m_tennis_booking/utils/app_constants.dart';
import 'package:m3m_tennis_booking/utils/app_dimensions.dart';
import '../../common/services/storage_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: AppDimension.normalIconSize,
          ),
        ),
        title: Text(
          "Profile",
          style: textTheme.titleLarge,
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  height: size.height / 3,
                  color: AppTheme.myColorScheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimension.normalPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                    size: AppDimension.normalIconSize,
                                  ),
                                ),
                                const SizedBox(width: AppDimension.normalPadding),
                                Text(
                                  "Confirmation",
                                  style: textTheme.headlineSmall,
                                ),
                              ],
                            ),
                            const SizedBox(height: AppDimension.largePadding),
                            Text(
                              "Are you sure you want to logout?",
                              style: textTheme.labelMedium,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                "Cancel",
                                style: textTheme.labelSmall,
                              ),
                            ),
                            const SizedBox(width: AppDimension.normalPadding),
                            ElevatedButton(
                              onPressed: () => profileController.logout(),
                              child: const Text("Confirm", style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: AppDimension.normalIconSize,
            ),
          ),
        ],
      ),
      body: SafeArea(
          top: true,
          bottom: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimension.normalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppDimension.normalPadding),
                Obx(() => CircleAvatar(
                      radius: 53,
                      backgroundColor: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: Get.context!,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Select Image'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.camera),
                                      title: const Text('Take a Photo'),
                                      onTap: () {
                                        Get.back();
                                        profileController.pickImage(ImageSource.camera);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.photo),
                                      title: const Text('Choose from Gallery'),
                                      onTap: () {
                                        Get.back();
                                        profileController.pickImage(ImageSource.gallery);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: profileController.imagePath != ""
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: FileImage(
                                  File(profileController.imagePath),
                                ))
                            : const CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey,
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.black,
                                )),
                      ),
                    )),
                const SizedBox(height: AppDimension.normalPadding / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StorageService.instance.fetch(AppConstants.userName),
                      style: textTheme.headlineMedium,
                    ),
                    const SizedBox(width: AppDimension.normalPadding),
                    const Icon(
                      Icons.edit,
                      //color: Colors.grey,
                    ),
                  ],
                ),
                const SizedBox(height: AppDimension.normalPadding),
                Text(
                  "Flat #2356",
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: AppDimension.largePadding),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              "12",
                              style: textTheme.labelMedium,
                            ),
                            const SizedBox(height: AppDimension.normalPadding / 2),
                            Text(
                              "Bookings",
                              style: textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.grey,
                        thickness: 2,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              "24 hrs",
                              style: textTheme.labelMedium,
                            ),
                            const SizedBox(height: AppDimension.normalPadding / 2),
                            Text(
                              "Played",
                              style: textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: Colors.grey,
                        thickness: 2,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              "June 2021",
                              style: textTheme.labelMedium,
                            ),
                            const SizedBox(height: AppDimension.normalPadding / 2),
                            Text(
                              "Member Since",
                              style: textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimension.largePadding * 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimension.normalPadding / 2),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              "Phone Number",
                              style: textTheme.labelMedium,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text(
                              StorageService.instance.fetch(AppConstants.userMobile) ?? "NA",
                              style: textTheme.labelLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimension.normalPadding / 2),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(height: AppDimension.normalPadding / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Email",
                              style: textTheme.labelMedium,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Text(
                              "ramdev@patanjali.in",
                              style: textTheme.labelLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimension.normalPadding / 2),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Notifications",
                            style: textTheme.labelMedium,
                          ),
                          Switch(value: true, onChanged: (v) {})
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
