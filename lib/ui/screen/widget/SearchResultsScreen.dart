import 'package:artificial/assets.dart';
import 'package:artificial/ui/screen/widget/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchResultsScreen extends StatefulWidget {
  final String query;

  const SearchResultsScreen({Key? key, required this.query}) : super(key: key);

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  String? selectedCategory;

  List<Map<String, dynamic>> workers = [];

  List<Map<String, dynamic>> categories = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        selectedCategory = AppLocalizations.of(context)!.all;

        workers = [
          {
            "name": AppLocalizations.of(context)!.khaled_mohamed,
            "job": AppLocalizations.of(context)!.carpenter,
            "image": AppImages.work,
            "rating": 4.5
          },
          {
            "name": AppLocalizations.of(context)!.mohamed_talat,
            "job": AppLocalizations.of(context)!.plumber,
            "image": AppImages.work,
            "rating": 4.2
          },
          {
            "name": AppLocalizations.of(context)!.ahmed_ali,
            "job": AppLocalizations.of(context)!.electrician,
            "image": AppImages.work,
            "rating": 4.8
          },
        ];

        categories = [
          {"name": AppLocalizations.of(context)!.all, "image": AppImages.all},
          {
            "name": AppLocalizations.of(context)!.bricklayers,
            "image": AppImages.builder
          },
          {
            "name": AppLocalizations.of(context)!.electrician,
            "image": AppImages.electrician
          },
          {
            "name": AppLocalizations.of(context)!.plumber,
            "image": AppImages.plumber
          },
          {
            "name": AppLocalizations.of(context)!.painter,
            "image": AppImages.painter
          },
          {
            "name": AppLocalizations.of(context)!.carpenter,
            "image": AppImages.carpenter
          },
          {
            "name": AppLocalizations.of(context)!.industrial_ceramic,
            "image": AppImages.ceramic
          },
          {
            "name": AppLocalizations.of(context)!.industrial_ceramic,
            "image": AppImages.glass
          },
          {
            "name": AppLocalizations.of(context)!.blacksmith,
            "image": AppImages.blacksmith
          },
          {
            "name": AppLocalizations.of(context)!.industrial_air_conditioning,
            "image": AppImages.HVAC_Technician
          },
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: selectedCategory == null
          ? Center(
              child: CircularProgressIndicator(color: AppColors.primaryGold))
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${AppLocalizations.of(context)!.resalt} \"${widget.query}\" 🔍",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: categories
                              .map((category) => Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedCategory = category["name"];
                                        });
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: selectedCategory ==
                                                        category["name"]
                                                    ? AppColors.primaryGold
                                                    : Colors.transparent,
                                                width: 2,
                                              ),
                                            ),
                                            child: CircleAvatar(
                                              radius: 32,
                                              backgroundColor:
                                                  selectedCategory ==
                                                          category["name"]
                                                      ? Colors.grey[900]
                                                      : Colors.grey[800],
                                              child: Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Image.asset(
                                                  category["image"],
                                                  width: 35,
                                                  height: 35,
                                                  color: selectedCategory ==
                                                          category["name"]
                                                      ? AppColors.primaryGold
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(category["name"],
                                              style: TextStyle(
                                                  color: selectedCategory ==
                                                          category["name"]
                                                      ? AppColors.primaryGold
                                                      : Colors.white,
                                                  fontSize: 14))
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      SizedBox(height: 15),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: workers.length,
                        itemBuilder: (context, index) {
                          String name = workers[index]["name"];
                          String job = workers[index]["job"];
                          String image = workers[index]["image"];
                          double rating = workers[index]["rating"];
                          if (selectedCategory ==
                                  AppLocalizations.of(context)!.all ||
                              selectedCategory == job) {
                            return WorkerCard(
                              image: image,
                              name: name,
                              profession: job,
                              rating: rating,
                              onOrderPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "${AppLocalizations.of(context)!.your_request} $name"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
