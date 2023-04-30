import 'package:clinicky/models/notification_data.dart';
import 'package:clinicky/util/color_pallete.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final NotificationData notificationData;
  const NotificationCard({
    super.key,
    required this.notificationData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorPallete.secondaryColor,
        border: Border.all(color: ColorPallete.mainColor),
      ),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 20),
                const Icon(
                  Icons.medical_services,
                  color: ColorPallete.mainColor,
                  size: 35,
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    const Text(
                      "تم حجز موعد بنجاح!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorPallete.mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      "${notificationData.bookingTime!.split(" ")[0]}  |  ${notificationData.bookingTime!.split(" ")[1].split(".")[0]}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: ColorPallete.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              "تم حجز موعد بنجاح مع الدكتور ${notificationData.doctorName}\nبتوقيت ${notificationData.appointmentDate}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: ColorPallete.mainColor,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
