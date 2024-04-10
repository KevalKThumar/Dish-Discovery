import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodes/screen/favoriteScreen/favorite_screen.dart';
import 'package:foodes/widget/get_data_of_meal.dart';
import 'package:provider/provider.dart';
import 'package:foodes/model/meal_model.dart';
import 'package:foodes/screen/meal/meal_screen.dart';
import 'package:shimmer/shimmer.dart';

class MealProvider extends ChangeNotifier {
  final APIService _apiService = APIService();
  final Map<int, Meal> _mealCache = {};
  final List<Meal> _favoriteMeals = [];

  Future<Meal> getMeal(int id) async {
    if (_mealCache.containsKey(id)) {
      return _mealCache[id]!;
    } else {
      final meal = await _apiService.getMeal(id);
      _mealCache[id] = meal;
      return meal;
    }
  }

  List<Meal> get favoriteMeals => _favoriteMeals;

  void toggleFavorite(Meal meal) {
    if (_favoriteMeals.contains(meal)) {
      _favoriteMeals.remove(meal);
    } else {
      _favoriteMeals.add(meal);
    }
    notifyListeners();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scrollController.jumpTo(0);
        },
        child: const Icon(
          Icons.arrow_upward_rounded,
        ),
      ),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset(
            "assets/Faily.png",
          ),
        ),
        title: const Text("Dishes"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.favorite_outline_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoriteScreen(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: Consumer<MealProvider>(
        builder: (context, mealProvider, _) {
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: 200,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 9 / 16,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  controller: scrollController,
                  cacheExtent: 10,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      future: mealProvider.getMeal(index + 1),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Shimmer.fromColors(
                            direction: ShimmerDirection.ttb,
                            baseColor:
                                Theme.of(context).cardColor, // Light grey
                            highlightColor: Colors.pinkAccent.shade100
                                .withOpacity(0.5), // Dark grey
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        }
                        Meal meal = snapshot.data as Meal;
                        return Card(
                          key: ValueKey<int>(index),
                          elevation: 4,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MealScreen(
                                    meal: meal,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          meal.data!.strMealThumb.toString(),
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                          value: downloadProgress.progress,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                    //  Image.network(
                                    //   meal.data!.strMealThumb.toString(),
                                    //   fit: BoxFit.cover,
                                    //   loadingBuilder: (BuildContext context,
                                    //       Widget child,
                                    //       ImageChunkEvent? loadingProgress) {
                                    //     if (loadingProgress == null) {
                                    //       return child;
                                    //     } else {
                                    //       return Center(
                                    //         child: CircularProgressIndicator(
                                    //           value: loadingProgress
                                    //                       .expectedTotalBytes !=
                                    //                   null
                                    //               ? loadingProgress
                                    //                       .cumulativeBytesLoaded /
                                    //                   loadingProgress
                                    //                       .expectedTotalBytes!
                                    //               : null,
                                    //         ),
                                    //       );
                                    //     }
                                    //   },
                                    // ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    meal.data!.strMeal.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
