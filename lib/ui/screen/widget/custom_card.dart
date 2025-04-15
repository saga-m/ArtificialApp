import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:artificial/ui/screen/Fav/Favorites_Provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WorkerCard extends StatelessWidget {
  final String image;
  final String name;
  final String profession;
  final double rating;
  final VoidCallback onOrderPressed;

  const WorkerCard({
    required this.image,
    required this.name,
    required this.profession,
    required this.rating,
    required this.onOrderPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var favoritesProvider = Provider.of<FavoritesProvider>(context);
    bool isFavorite =
        favoritesProvider.favorites.any((worker) => worker['name'] == name);

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xff1C1C1C),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(image),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profession,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          color: index < rating ? Colors.amber : Colors.grey,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: onOrderPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.order_now,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () {
              if (isFavorite) {
                favoritesProvider.removeFromFavorites(name);
              } else {
                favoritesProvider.addToFavorites({
                  'image': image,
                  'name': name,
                  'profession': profession,
                  'rating': rating,
                });
              }
            },
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}
