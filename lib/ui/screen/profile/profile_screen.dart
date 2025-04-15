import 'package:artificial/assets.dart';
import 'package:artificial/ui/screen/widget/custom_textFiled.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final picker = ImagePicker();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController =
      TextEditingController(text: "01012345678");
  TextEditingController cityController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  //  دالة لحفظ البيانات بعد التعديل
  void _saveData() {
    String name = nameController.text;
    String phone = phoneController.text;
    String city = cityController.text;
    String job = jobController.text;

    //  إظهار رسالة تأكيد
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.edits_saved_successfully),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        nameController.text = AppLocalizations.of(context)!.mohamed_ahmed;
        cityController.text = AppLocalizations.of(context)!.cairo;
        jobController.text = AppLocalizations.of(context)!.carpenter;
      });
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.profile),
              centerTitle: true,
              backgroundColor: AppColors.primaryGold,
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
                            : AssetImage(AppImages.work) as ImageProvider,
                        child: Icon(Icons.camera_alt,
                            color: Colors.white, size: 30),
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomTextField(label: AppLocalizations.of(context)!.name),
                    SizedBox(height: 20),
                    CustomTextField(
                        label: AppLocalizations.of(context)!.phone_number,
                        keyboardType: TextInputType.phone),
                    SizedBox(height: 20),
                    CustomTextField(
                        label: AppLocalizations.of(context)!.governate),
                    SizedBox(height: 20),
                    CustomTextField(
                        label: AppLocalizations.of(context)!.profession),
                    SizedBox(height: 30),

                    //  زر "حفظ التعديلات"
                    ElevatedButton(
                      onPressed: _saveData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryGold,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.save_changes,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),

                    SizedBox(height: 20),

                    //  زر "تسجيل خروج"
                    ElevatedButton(
                      onPressed: () {
                        _logout(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                      child: Text(AppLocalizations.of(context)!.log_out,
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            )));
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.confirm_logout),
        content: Text(AppLocalizations.of(context)!.are_you_sure_log_out),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(AppLocalizations.of(context)!.exit,
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
