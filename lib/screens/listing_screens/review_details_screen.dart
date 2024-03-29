import 'package:flutter/material.dart';
import 'package:foodreviewapp/models/review.dart';
import 'package:foodreviewapp/screens/form_screens/review_form_screen.dart';
import 'package:foodreviewapp/database/database_service.dart';
import 'package:foodreviewapp/widgets/common/custom_divider.dart';
import 'package:foodreviewapp/widgets/common/review_details_field.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

// List all the details about a review screen
class ReviewDetailsScreen extends StatefulWidget {
  final int reviewId;
  const ReviewDetailsScreen({super.key, required this.reviewId});

  @override
  State<ReviewDetailsScreen> createState() => _ReviewDetailsScreenState();
}

class _ReviewDetailsScreenState extends State<ReviewDetailsScreen> {
  Review? reviewObject;
  bool isLoading = false;
  bool isFavourite = false;
  @override
  void initState() {
    super.initState();
    _getReview();
  }

  Future _getReview() async {
    setState(() {
      isLoading = true;
    });

    reviewObject = await DatabaseService.getReviewById(widget.reviewId);
    isFavourite = reviewObject?.isFavourite ?? false;
    setState(() {
      isLoading = false;
    });
  }

  void _toggleFavourite() async {
    await DatabaseService.updateReviewFavourite(
      reviewObject!.id!,
      isFavourite ? 0 : 1,
    );
    setState(() {
      isFavourite = !isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        elevation: 0,
        actions: [
          isFavourite
              ? IconButton(
                  onPressed: _toggleFavourite,
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                )
              : IconButton(
                  onPressed: _toggleFavourite,
                  icon: const Icon(Icons.favorite_border, color: Colors.red),
                ),
        ],
      ),
      body: LiquidPullToRefresh(
        color: Theme.of(context).colorScheme.tertiary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        showChildOpacityTransition: false,
        onRefresh: () async {
          await _getReview();
        },
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 0.5 * MediaQuery.of(context).size.height,
                    child: reviewObject?.image != null
                        ? Image.memory(
                            reviewObject!.image!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/default_restaurant.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                  DraggableScrollableSheet(
                    maxChildSize: 1,
                    initialChildSize: 0.50,
                    minChildSize: 0.50,
                    builder: (context, scrollController) =>
                        SingleChildScrollView(
                      controller: scrollController,
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              top: 40,
                              right: 14,
                              left: 14,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //-----Restaurant Name-----
                                      Flexible(
                                        child: Text(
                                          "${reviewObject?.restaurantName}",
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      //-----Rating-----
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 26,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "${reviewObject?.rating.toString()}",
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),

                                  //-----Category-----
                                  if (reviewObject?.categories != null &&
                                      reviewObject!.categories!.isNotEmpty) ...[
                                    SizedBox(
                                      height: 30,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            reviewObject?.categories?.length,
                                        itemBuilder: (context, index) =>
                                            Container(
                                          margin:
                                              const EdgeInsets.only(right: 8),
                                          child: Chip(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                8.0,
                                              ), // Set the desired border radius
                                            ),
                                            side: BorderSide(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white,
                                              width: 1,
                                              style: BorderStyle.solid,
                                            ),
                                            label: Text(
                                              "#${reviewObject?.categories?[index]}",
                                            ),
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                  //-----Location-----
                                  ReviewDetailsField(
                                    icon: const Icon(
                                      Icons.location_on_outlined,
                                    ),
                                    title:
                                        AppLocalizations.of(context)!.location,
                                    content: reviewObject?.location,
                                  ),
                                  const CustomDivider(
                                    symmetricPadding: 20,
                                    dividerHeight: 4,
                                    dividerThickness: 2,
                                  ),
                                  //-----Description-----
                                  ReviewDetailsField(
                                    icon: const Icon(
                                      Icons.description_outlined,
                                    ),
                                    title: AppLocalizations.of(context)!
                                        .description,
                                    content: reviewObject?.description,
                                  ),
                                  const CustomDivider(
                                    symmetricPadding: 20,
                                    dividerHeight: 4,
                                    dividerThickness: 2,
                                  ),
                                  //-----Food Available-----
                                  Row(
                                    children: [
                                      const Icon(Icons.lunch_dining_outlined),
                                      const SizedBox(width: 8),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .foodAvailable,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: -4,
                                    children: [
                                      for (var food
                                          in reviewObject?.foodAvailable ?? [])
                                        Chip(
                                          label: Text("$food"),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                        ),
                                    ],
                                  ),

                                  const CustomDivider(
                                    symmetricPadding: 20,
                                    dividerHeight: 4,
                                    dividerThickness: 2,
                                  ),
                                  //-----Additional Review-----
                                  ReviewDetailsField(
                                    icon: const Icon(Icons.comment_outlined),
                                    title: AppLocalizations.of(context)!
                                        .additionalReview,
                                    content: reviewObject?.additionalReview ??
                                        AppLocalizations.of(context)!
                                            .noAdditionalReview,
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: 50,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.list_view,
        renderOverlay: false,
        children: [
          //-----Delete button-----
          SpeedDialChild(
            child: const Icon(Icons.delete),
            label: AppLocalizations.of(context)!.deleteReviewButton,
            backgroundColor: Colors.redAccent,
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Center(
                      child: Text(
                        AppLocalizations.of(context)!.deleteReviewButton,
                      ),
                    ),
                    content: Text(
                      AppLocalizations.of(context)!.deleteReviewDialogMessage,
                    ),
                    actions: [
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(AppLocalizations.of(context)!.no),
                          ),
                          TextButton(
                            onPressed: () async {
                              await DatabaseService.deleteReview(reviewObject!);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    // ignore: use_build_context_synchronously
                                    AppLocalizations.of(context)!
                                        .reviewDeletedSnackbar,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  backgroundColor: Colors.green[100],
                                ),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.yes,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
          //-----Edit button-----
          SpeedDialChild(
            child: const Icon(Icons.edit),
            label: AppLocalizations.of(context)!.editReviewButton,
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReviewFormScreen(review: reviewObject),
                ),
              );
              _getReview();
            },
          ),
          //-----Search Restaurant button-----
          SpeedDialChild(
            child: const Icon(Icons.search),
            label: AppLocalizations.of(context)!.searchRestaurantOnlineButton,
            onTap: () async {
              final url = Uri.parse(
                'https://www.google.com/search?q=${reviewObject?.restaurantName} restaurant',
              );
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                throw Exception('Could not launch $url');
              }
            },
          ),
          //-----Search Location button-----
          SpeedDialChild(
            child: const Icon(Icons.location_on_sharp),
            label: AppLocalizations.of(context)!.searchLocationOnlineButton,
            onTap: () async {
              final url = Uri.parse(
                'https://www.google.com/maps/search/${reviewObject?.location}',
              );
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                throw Exception('Could not launch $url');
              }
            },
          ),
        ],
      ),
    );
  }
}
