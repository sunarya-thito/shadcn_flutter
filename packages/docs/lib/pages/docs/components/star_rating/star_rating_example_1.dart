import 'package:shadcn_flutter/shadcn_flutter.dart';

class StarRatingExample1 extends StatefulWidget {
  const StarRatingExample1({super.key});

  @override
  State<StarRatingExample1> createState() => _StarRatingExample1State();
}

class _StarRatingExample1State extends State<StarRatingExample1> {
  // The current rating value (supports fractional values like 1.5 for half-stars).
  double value = 1.5;
  @override
  Widget build(BuildContext context) {
    return StarRating(
      // Control the icon size used for each star.
      starSize: 32,
      value: value,
      onChanged: (value) {
        setState(() {
          // Update the rating when the user taps/drags on the stars.
          this.value = value;
        });
      },
    );
  }
}
