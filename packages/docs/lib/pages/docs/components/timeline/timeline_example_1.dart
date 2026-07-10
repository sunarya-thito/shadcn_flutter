import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a static Timeline with entries showing time, title, and content.

class TimelineExample1 extends StatelessWidget {
  const TimelineExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Timeline(
      // Each TimelineData item renders a time, title, and detailed content.
      // Styling/layout comes from the Timeline widget; content is plain widgets.
      data: [
        TimelineData(
          time: const Text('2022-01-01'),
          title: const Text('First event'),
          content: const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Odio euismod lacinia at quis risus sed vulputate odio ut. Quam viverra orci sagittis eu volutpat odio facilisis mauris.'),
        ),
        TimelineData(
          time: const Text('2022-01-02'),
          title: const Text('Second event'),
          content: const Text(
              'Aut eius excepturi ex recusandae eius est minima molestiae. Nam dolores iusto ad fugit reprehenderit hic dolorem quisquam et quia omnis non suscipit nihil sit libero distinctio. Ad dolorem tempora sit nostrum voluptatem qui tempora unde? Sit rerum magnam nam ipsam nesciunt aut rerum necessitatibus est quia esse non magni quae.'),
        ),
        TimelineData(
          time: const Text('2022-01-03'),
          title: const Text('Third event'),
          content: const Text(
            'Sit culpa quas ex nulla animi qui deleniti minus rem placeat mollitia. Et enim doloremque et quia sequi ea dolores voluptatem ea rerum vitae. Aut itaque incidunt est aperiam vero sit explicabo fuga id optio quis et molestiae nulla ex quae quam. Ab eius dolores ab tempora dolorum eos beatae soluta At ullam placeat est incidunt cumque.',
          ),
        ),
      ],
    );
  }
}
