import 'package:artificial/assets.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color? backgroundColor; // لون الخلفية
  final Color? textColor; // لون النص

  final double? fontSize; // حجم الخط

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.black,
          foregroundColor: textColor ?? AppColors.primaryGold,
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(icon, color: textColor ?? AppColors.primaryGold, size: 22),
            if (icon != null) SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize, // التحكم في حجم الخط
                fontWeight: FontWeight.bold,
                color: textColor ?? AppColors.primaryGold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
