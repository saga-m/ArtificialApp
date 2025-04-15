import 'package:artificial/assets.dart';
import 'package:artificial/ui/screen/Home/home_screen.dart';
import 'package:artificial/ui/screen/widget/custom_buttom.dart';
import 'package:artificial/ui/screen/widget/custom_textFiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterForm extends StatefulWidget {
  final Function(bool) onToggle;
  final String userType;

  RegisterForm({
    required this.onToggle,
    required this.userType,
  });

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String? selectedGovernorate;
  String? selectedJob;

  @override
  Widget build(BuildContext context) {
    print("User Type: ${widget.userType}");

    return LayoutBuilder(
      builder: (context, constraints) {
        double padding = constraints.maxWidth * 0.05;
        double fontSize = constraints.maxWidth * 0.05;

        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(padding),
            margin: EdgeInsets.symmetric(horizontal: padding),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.register_now,
                  style: TextStyle(
                      color: AppColors.primaryGold,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                CustomTextField(label: AppLocalizations.of(context)!.name),
                CustomTextField(
                  label: AppLocalizations.of(context)!.governate,
                  dropdownItems: [
                    AppLocalizations.of(context)!.cairo,
                    AppLocalizations.of(context)!.qena,
                    AppLocalizations.of(context)!.giza,
                    AppLocalizations.of(context)!.new_valley,
                    AppLocalizations.of(context)!.red_sea,
                  ],
                  dropdownMaxHeight: 200, // تحديد ارتفاع القائمة المنسدلة
                  onChanged: (value) {
                    setState(() {
                      selectedGovernorate = value;
                    });
                  },
                ),
                CustomTextField(
                    label: AppLocalizations.of(context)!.phone_number,
                    keyboardType: TextInputType.phone),
                if (widget.userType == "worker")
                  CustomTextField(
                    label: AppLocalizations.of(context)!.profession,
                    dropdownItems: [
                      AppLocalizations.of(context)!.glazier,
                      AppLocalizations.of(context)!.industrial_air_conditioning,
                      AppLocalizations.of(context)!.industrial_ceramic,
                      AppLocalizations.of(context)!.painter,
                      AppLocalizations.of(context)!.bricklayers,
                      AppLocalizations.of(context)!.carpenter,
                      AppLocalizations.of(context)!.plumber,
                      AppLocalizations.of(context)!.electrician,
                      AppLocalizations.of(context)!.blacksmith
                    ],
                    dropdownMaxHeight: 200,
                    onChanged: (value) {
                      setState(() {
                        selectedJob = value;
                      });
                    },
                  ),
                SizedBox(height: 16),
                CustomButton(
                  text: AppLocalizations.of(context)!.register_as_a_new_user,
                  fontSize: fontSize,
                  onPressed: () {
                    print("تم تسجيل المستخدم");
                  },
                  backgroundColor: AppColors.primaryGold,
                  textColor: Colors.black,
                ),
                TextButton(
                  onPressed: () => widget.onToggle(true),
                  child:
                      Text(AppLocalizations.of(context)!.already_have_account),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                  child: Text(AppLocalizations.of(context)!.use_app),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
