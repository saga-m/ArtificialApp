import 'package:artificial/assets.dart';
import 'package:flutter/material.dart';

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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          // ✅ استخدام ListView بدلاً من Column
          children: [
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        widget.workerData?["image"] ?? AppImages.work),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.workerData?["name"] ?? "غير معروف",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.workerData?["profession"] ?? "غير محدد",
                    style:
                        TextStyle(color: AppColors.primaryGold, fontSize: 18),
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
      ),
    );
  }

  /// ✅ **تصميم واجهة إدخال تفاصيل الحجز**
  Widget _buildBookingDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("تفاصيل الحجز:",
            style: TextStyle(color: AppColors.primaryGold, fontSize: 18)),
        SizedBox(height: 10),
        _buildDropdown("اليوم", [
          "السبت",
          "الاحد",
          "الاثنين",
          "الثلاثاء",
          "الاربعاء",
          "الخميس",
          "الجمعة",
        ], (val) {
          setState(() => selectedDay = val);
        }),
        SizedBox(height: 10),
        _buildDropdown("الوقت", ["8 صباحًا - 6 مساءً"], (val) {
          setState(() => selectedTime = val);
        }),
        SizedBox(height: 10),
        Text("ملاحظات للصنايعي:",
            style: TextStyle(color: AppColors.primaryGold, fontSize: 16)),
        TextField(
          controller: notesController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[900],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: "مثلاً أنا عندي عدة مفاتيح جاهزة...",
            hintStyle: TextStyle(color: Colors.white60),
          ),
        ),
      ],
    );
  }

  /// ✅ **بناء قائمة منسدلة لاختيار اليوم والوقت**
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

  /// ✅ **تصميم الأزرار في أسفل الصفحة**
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            if (selectedDay != null && selectedTime != null) {
              _confirmBooking();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("يرجى اختيار اليوم والوقت")),
              );
            }
          },
          icon: Icon(Icons.check_circle, color: Colors.black),
          label: Text("أكد الحجز"),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryGold,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.cancel, color: Colors.black),
          label: Text("الغِ الحجز"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          ),
        ),
      ],
    );
  }

  /// ✅ **تنفيذ الحجز عند الضغط على "أكد الحجز"**
  void _confirmBooking() {
    print(
        "تم تأكيد الحجز لـ ${widget.workerData?["name"]} في يوم $selectedDay من الساعة $selectedTime");
  }
}
