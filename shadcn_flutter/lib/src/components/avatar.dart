
import '../../shadcn_flutter.dart';

class Avatar extends StatefulWidget {
  static String getInitials(String name) {
    // replace all non-alphabetic characters
    name = name.replaceAll(RegExp(r'[^a-zA-Z\s]'), '');
    final List<String> parts = name.split(' ');
    if (parts.isEmpty) {
      // get the first 2 characters (title cased)
      String first = name.substring(0, 1).toUpperCase();
      if (name.length > 1) {
        String second = name.substring(1, 2).toUpperCase();
        return first + second;
      }
      return first;
    }
    // get the first two characters
    String first = parts[0].substring(0, 1).toUpperCase();
    if (parts.length > 1) {
      String second = parts[1].substring(0, 1).toUpperCase();
      return first + second;
    }
    // append with the 2nd character of the first part
    if (parts[0].length > 1) {
      String second = parts[0].substring(1, 2).toUpperCase();
      return first + second;
    }
    return first;
  }

  final String? photoUrl;
  final String initials;
  final Color? backgroundColor;
  final double? size;

  const Avatar({
    Key? key,
    this.photoUrl,
    required this.initials,
    this.backgroundColor,
    this.size,
  }) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    double size = widget.size ?? 40;
    double borderRadius = Theme.of(context).radius * size;
    // use photo if available, use initials if not
    // also if photo is failed to load, use initials
    if (widget.photoUrl?.isNotEmpty ?? false) {
      return SizedBox(
        width: widget.size ?? 40,
        height: widget.size ?? 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.network(
            widget.photoUrl!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              print('Failed to load image: $error');
              print(stackTrace);
              return _buildInitials(borderRadius);
            },
          ),
        ),
      );
    }
    return SizedBox(
      width: widget.size ?? 40,
      height: widget.size ?? 40,
      child: _buildInitials(borderRadius),
    );
  }

  Widget _buildInitials(double borderRadius) {
    return Container(
      width: widget.size ?? 40,
      height: widget.size ?? 40,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Theme.of(context).colorScheme.muted,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: FittedBox(
        fit: BoxFit.fill,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: mergeAnimatedTextStyle(
            duration: kDefaultDuration,
            child: Text(
              widget.initials,
            ),
            style: TextStyle(
              color: Theme.of(context).colorScheme.foreground,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
