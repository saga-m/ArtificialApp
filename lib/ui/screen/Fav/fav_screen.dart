import 'package:artificial/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:artificial/ui/screen/Fav/Favorites_Provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavScreen extends StatelessWidget {
  static const String routeName = '/favScreen';

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.primaryGrey,
      appBar: AppBar(
          backgroundColor: AppColors.primaryGrey,
          title: Text(
            AppLocalizations.of(context)!.favorites,
            style: TextStyle(color: Colors.white),
          )),
      body: ListView.builder(
        itemCount: favoritesProvider.favorites.length,
        itemBuilder: (context, index) {
          final worker = favoritesProvider.favorites[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(worker['image']),
            ),
            title: Text(
              worker['name'],
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              worker['profession'],
              style: TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                favoritesProvider.removeFromFavorites(worker['name']);
              },
            ),
          );
        },
      ),
    );
  }
}
