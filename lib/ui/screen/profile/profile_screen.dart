import 'package:artificial/assets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final picker = ImagePicker();

  TextEditingController nameController =
      TextEditingController(text: "محمد أحمد");
  TextEditingController phoneController =
      TextEditingController(text: "01012345678");
  TextEditingController cityController = TextEditingController(text: "القاهرة");
  TextEditingController jobController = TextEditingController(text: "نجار");

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // 🔹 دالة لحفظ البيانات بعد التعديل
  void _saveData() {
    String name = nameController.text;
    String phone = phoneController.text;
    String city = cityController.text;
    String job = jobController.text;

    // 🔹 إظهار رسالة تأكيد
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("تم حفظ التعديلات بنجاح!"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("الملف الشخصي"),
              centerTitle: true,
              backgroundColor:
                  AppColors.primaryGold, // استبدال AppColors.primaryGold
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : AssetImage(AppImages.work),
                        child: Icon(Icons.camera_alt,
                            color: Colors.white, size: 30),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildTextField("الاسم", nameController),
                    SizedBox(height: 20),
                    _buildTextField("رقم الهاتف", phoneController),
                    SizedBox(height: 20),
                    _buildTextField("المدينة", cityController),
                    SizedBox(height: 20),
                    _buildTextField("الوظيفة", jobController),
                    SizedBox(height: 30),

                    //  زر "حفظ التعديلات"
                    ElevatedButton(
                      onPressed: _saveData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                      child: Text("حفظ التعديلات",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                    SizedBox(height: 20),

                    // 🔹 زر "تسجيل خروج"
                    ElevatedButton(
                      onPressed: () {
                        _logout(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                      child: Text("تسجيل خروج",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            )));
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("تأكيد تسجيل الخروج"),
        content: Text("هل أنت متأكد أنك تريد تسجيل الخروج؟"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("إلغاء"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text("خروج", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
