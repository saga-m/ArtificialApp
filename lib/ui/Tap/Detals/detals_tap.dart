import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetalsTap extends StatefulWidget {
  const DetalsTap({super.key});

  @override
  State<DetalsTap> createState() => _DetalsTapState();
}

class _DetalsTapState extends State<DetalsTap> {
  bool _isDropdownVisible = false;
  TextEditingController _questionController = TextEditingController();
  List<Map<String, String>> _questions = [];

  late List<String> _governorates;
  late List<String> _crafts;
  late String _selectedGovernorate;
  late String _selectedCraft;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _governorates = [
      AppLocalizations.of(context)!.choose_governorate,
      AppLocalizations.of(context)!.cairo,
      AppLocalizations.of(context)!.qena,
      AppLocalizations.of(context)!.new_valley,
      AppLocalizations.of(context)!.red_sea,
    ];

    _crafts = [
      AppLocalizations.of(context)!.choose_craft,
      AppLocalizations.of(context)!.glazier,
      AppLocalizations.of(context)!.blacksmith,
      AppLocalizations.of(context)!.industrial_air_conditioning,
      AppLocalizations.of(context)!.industrial_ceramic,
      AppLocalizations.of(context)!.painter,
      AppLocalizations.of(context)!.bricklayers,
      AppLocalizations.of(context)!.carpenter,
      AppLocalizations.of(context)!.plumber,
      AppLocalizations.of(context)!.electrician,
    ];

    _selectedGovernorate = _governorates[0];
    _selectedCraft = _crafts[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildTopSection(),
                ..._questions.map((question) {
                  return _buildOrderItem(
                    title: question["title"]!,
                    description: question["description"]!,
                    time: question["time"]!,
                    comments: question["comments"]!,
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.ask_about_problem,
            style: TextStyle(
              color: Color(0xffffda1a),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                _isDropdownVisible = !_isDropdownVisible;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.white70),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.share_question,
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isDropdownVisible) _buildDropdownSection(),
        ],
      ),
    );
  }

  Widget _buildDropdownSection() {
    return Column(
      children: [
        SizedBox(height: 10),
        _buildDropdown(_governorates, _selectedGovernorate, (value) {
          setState(() => _selectedGovernorate = value);
        }),
        SizedBox(height: 10),
        _buildDropdown(_crafts, _selectedCraft, (value) {
          setState(() => _selectedCraft = value);
        }),
        SizedBox(height: 10),
        _buildQuestionInput(),
        SizedBox(height: 10),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildDropdown(
      List<String> items, String selectedItem, Function(String) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        value: selectedItem,
        dropdownColor: Colors.grey[900],
        isExpanded: true,
        underline: SizedBox(),
        style: TextStyle(color: Colors.white),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: TextStyle(color: Colors.white)),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) onChanged(value);
        },
      ),
    );
  }

  Widget _buildQuestionInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _questionController,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.write_your_message_here,
          hintStyle: TextStyle(color: Colors.white54),
          border: InputBorder.none,
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_questionController.text.isEmpty ||
            _governorates.indexOf(_selectedGovernorate) == 0 ||
            _crafts.indexOf(_selectedCraft) == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)!.please_choose_the_gov_and_pro,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red[700],
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }
        {
          String questionText = _questionController.text;

          setState(() {
            _questions.add({
              "title": questionText,
              "description":
                  "محافظة $_selectedGovernorate - صنعة $_selectedCraft",
              "time": AppLocalizations.of(context)!.published_now,
              "comments": AppLocalizations.of(context)!.comments,
            });
            print("عدد الأسئلة: ${_questions.length}");
            _isDropdownVisible = false;
            _questionController.clear();
          });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffffda1a),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(AppLocalizations.of(context)!.share_your_question,
          style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildOrderItem({
    required String title,
    required String description,
    required String time,
    required String comments,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(description,
              style: TextStyle(color: Colors.white70, fontSize: 14)),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(time, style: TextStyle(color: Colors.white54, fontSize: 12)),
            Text(comments,
                style: TextStyle(color: Colors.white54, fontSize: 12)),
          ]),
        ],
      ),
    );
  }
}
