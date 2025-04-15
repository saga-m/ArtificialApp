import 'package:artificial/assets.dart';
import 'package:artificial/ui/Tap/Calender/calender_tap.dart';
import 'package:artificial/ui/screen/Order/order_card.dart';
import 'package:artificial/ui/screen/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileTap extends StatefulWidget {
  final Map<String, dynamic>? workerData;

  const ProfileTap({Key? key, this.workerData}) : super(key: key);

  @override
  _ProfileTapState createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap> {
  String? selectedDay;
  String? selectedTime;
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double avatarRadius = constraints.maxWidth * 0.15;
          double fontSize = constraints.maxWidth * 0.05;

          return Padding(
            padding: EdgeInsets.all(16),
            child: ListView(
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundImage: AssetImage(
                            widget.workerData?["image"] ?? AppImages.work),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.workerData?["name"] ?? "غير معروف",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.workerData?["profession"] ?? "غير محدد",
                        style: TextStyle(
                            color: AppColors.primaryGold,
                            fontSize: fontSize * 0.8),
                      ),
                      SizedBox(height: 20),
                      _buildBookingDetails(),
                      SizedBox(height: 20),
                      _buildActionButtons(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBookingDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context)!.booking_details,
            style: TextStyle(color: AppColors.primaryGold, fontSize: 18)),
        SizedBox(height: 10),
        _buildDropdown(AppLocalizations.of(context)!.day, [
          AppLocalizations.of(context)!.saturday,
          AppLocalizations.of(context)!.sunday,
          AppLocalizations.of(context)!.monday,
          AppLocalizations.of(context)!.tuesday,
          AppLocalizations.of(context)!.wednesday,
          AppLocalizations.of(context)!.thursday,
          AppLocalizations.of(context)!.friday,
        ], (val) {
          setState(() => selectedDay = val);
        }),
        SizedBox(height: 10),
        _buildDropdown(AppLocalizations.of(context)!.time, ["8 am - 6 pm"],
            (val) {
          setState(() => selectedTime = val);
        }),
        SizedBox(height: 10),
        Text(AppLocalizations.of(context)!.notes_for_industrialist,
            style: TextStyle(color: AppColors.primaryGold, fontSize: 16)),
        TextField(
          controller: notesController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[900],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: AppLocalizations.of(context)!.example,
            hintStyle: TextStyle(color: Colors.white60),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(
      String label, List<String> items, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label:", style: TextStyle(color: Colors.white, fontSize: 16)),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            value: items.contains(selectedDay) ? selectedDay : null,
            items: items.map((item) {
              return DropdownMenuItem(
                  value: item,
                  child: Text(item, style: TextStyle(color: Colors.white)));
            }).toList(),
            onChanged: onChanged,
            isExpanded: true,
            dropdownColor: Colors.grey[900],
            underline: SizedBox(),
            hint: Text(label, style: TextStyle(color: Colors.white54)),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 10,
      children: [
        OutlinedButton.icon(
          onPressed: () {
            if (selectedDay != null && selectedTime != null) {
              _confirmBooking();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(AppLocalizations.of(context)!
                        .please_choose_the_day_and_time)),
              );
            }
          },
          icon: Icon(Icons.check_circle, color: Colors.yellow),
          label: Text(
            AppLocalizations.of(context)!.confirm_your_reservation,
            style: TextStyle(color: Colors.yellow),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.yellow, width: 2),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            backgroundColor: Colors.transparent,
          ),
        ),
        OutlinedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    OrderCard(workerData: widget.workerData ?? {}),
              ),
            );
          },
          icon: Icon(Icons.cancel, color: Colors.red),
          label: Text(
            AppLocalizations.of(context)!.cancel_your_reservation,
            style: TextStyle(color: AppColors.primaryGold),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.red, width: 2),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            backgroundColor: Colors.transparent,
          ),
        ),
      ],
    );
  }

  void _confirmBooking() {
    if (selectedDay != null && selectedTime != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(initialTabIndex: 4)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                AppLocalizations.of(context)!.please_choose_the_day_and_time)),
      );
    }
  }
}
