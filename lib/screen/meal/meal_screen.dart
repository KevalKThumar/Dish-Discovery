// ignore_for_file: unnecessary_null_comparison, unnecessary_import

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodes/model/meal_model.dart';
import 'package:foodes/screen/Home/home_screen.dart';
import 'package:foodes/widget/get_data_of_meal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../widget/meal_help_widget.dart';

// ignore: must_be_immutable
class MealScreen extends StatelessWidget {
  MealScreen({super.key, required this.meal});

  final Meal meal;

  APIService apiService = APIService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          meal.data!.strMeal.toString(),
          style: GoogleFonts.openSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Consumer<MealProvider>(
            builder: (context, mealProvider, _) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  icon: Icon(
                    mealProvider.favoriteMeals.contains(meal)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    mealProvider.toggleFavorite(meal);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.pinkAccent,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        duration: const Duration(seconds: 1),
                        elevation: 5,
                        content: Text(
                          mealProvider.favoriteMeals.contains(meal)
                              ? 'Added to favorites'
                              : 'Removed from favorites',
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                    log(mealProvider.favoriteMeals.toString());
                  },
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                meal.data!.strMealThumb.toString(),
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    // Image has finished loading
                    return child;
                  } else {
                    // Image is still loading, show a loading indicator
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: Text(
                meal.data!.strMeal.toString(),
                style: GoogleFonts.openSans(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Category: ${meal.data!.strCategory}',
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(255, 64, 129, 1),
              ),
            ),
            Text(
              'Area: ${meal.data!.strArea}',
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Ingredients:',
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 8),
            printIngredients(meal.data!),
            const SizedBox(height: 16),
            Text(
              'Instructions:',
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              meal.data!.strInstructions.toString(),
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                if (await canLaunchUrl(Uri.parse(meal.data!.strSource!))) {
                  await launchUrl(
                    Uri.parse(meal.data!.strSource!),
                  );
                } else {
                  throw 'Could not launch ${meal.data!.strSource}';
                }
              },
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Source: ',
                    ),
                    TextSpan(
                      text: '${meal.data!.strSource}',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Tags: ${meal.data!.strTags}",
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Youtube Video:",
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: YoutubePlayer.convertUrlToId(
                    meal.data!.strYoutube.toString(),
                  ).toString(),
                  flags: const YoutubePlayerFlags(
                    autoPlay: false,
                    mute: false,
                    showLiveFullscreenButton: false,
                  ),
                ),
                showVideoProgressIndicator: true,
                onReady: () {
                  // Add custom overlay to hide the full-screen button
                  YoutubePlayerController? controller =
                      YoutubePlayerController.of(context);
                  controller?.addListener(() {
                    // Disable full-screen button
                    controller.toggleFullScreenMode();
                    controller.fitHeight(const Size.fromHeight(200));
                    controller.fitWidth(
                        Size.fromWidth(MediaQuery.of(context).size.width));
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
