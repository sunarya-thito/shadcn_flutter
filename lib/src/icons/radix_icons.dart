import 'package:flutter/widgets.dart';

/// A curated collection of Radix UI icons for Flutter applications.
///
/// [RadixIcons] provides access to the Radix Icons library, a set of crisp,
/// pixel-perfect icons designed specifically for modern user interfaces.
/// These icons are crafted by the Radix UI team with careful attention to
/// consistency, clarity, and usability across different screen densities.
///
/// The icon set emphasizes simplicity and functionality, making it an excellent
/// choice for professional applications that require clean, recognizable iconography.
/// All icons follow consistent design principles with uniform stroke weights
/// and optical alignment.
///
/// ## Design Philosophy
/// - **Minimal & Clean**: Simple, uncluttered designs that communicate clearly
/// - **Consistent Weight**: Uniform stroke width across all icons
/// - **Pixel Perfect**: Optimized for crisp rendering at standard UI sizes
/// - **Semantic Clarity**: Icons that clearly represent their intended function
///
/// ## Usage Examples
/// ```dart
/// // Basic icon usage
/// Icon(RadixIcons.home)
/// 
/// // Customized appearance
/// Icon(
///   RadixIcons.gear,
///   size: 18,
///   color: Colors.grey.shade600,
/// )
/// 
/// // In app bars
/// AppBar(
///   actions: [
///     IconButton(
///       onPressed: () => {},
///       icon: Icon(RadixIcons.person),
///     ),
///   ],
/// )
/// 
/// // In lists
/// ListTile(
///   leading: Icon(RadixIcons.folder),
///   title: Text('Documents'),
///   trailing: Icon(RadixIcons.chevronRight),
/// )
/// ```
///
/// ## Common Icon Categories
/// The collection includes essential icons for:
/// - **System Actions**: close, minimize, maximize, settings
/// - **Navigation**: arrows, chevrons, home, back
/// - **Content**: text, image, video, document
/// - **Communication**: chat, mail, phone, notification
/// - **Status**: check, cross, warning, info
/// - **Editing**: pencil, trash, copy, paste
/// - **Media Controls**: play, pause, stop, volume
///
/// ## Best Practices
/// - Use consistent icon sizes throughout your application
/// - Provide semantic labels for accessibility
/// - Consider icon context and user expectations
/// - Test icon clarity at different sizes and themes
///
/// ```dart
/// // Accessible icon usage
/// Semantics(
///   label: 'Settings menu',
///   child: GestureDetector(
///     onTap: () => openSettings(),
///     child: Icon(RadixIcons.gear),
///   ),
/// )
/// ```
///
/// See also:
/// - [LucideIcons] for alternative icon styling
/// - [BootstrapIcons] for a larger icon collection
/// - [Icon] widget for displaying icons
class RadixIcons {
  /// Private constructor to prevent instantiation.
  ///
  /// [RadixIcons] is designed as a static utility class containing only
  /// static icon constants. The class provides icon data through static
  /// properties and is not intended to be instantiated.
  RadixIcons._();

  static const IconData zoomOut = IconData(57344, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData zoomIn = IconData(57345, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData width = IconData(57346, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData viewVertical = IconData(57347, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData viewNone = IconData(57348, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData viewHorizontal = IconData(57349, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData viewGrid = IconData(57350, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData video = IconData(57351, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData vercelLogo = IconData(57352, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData value = IconData(57353, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData valueNone = IconData(57354, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData upload = IconData(57355, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData update = IconData(57356, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData underline = IconData(57357, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData twitterLogo = IconData(57358, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData triangleUp = IconData(57359, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData triangleRight = IconData(57360, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData triangleLeft = IconData(57361, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData triangleDown = IconData(57362, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData trash = IconData(57363, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData transparencyGrid = IconData(57364, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData transform = IconData(57365, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData trackPrevious = IconData(57366, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData trackNext = IconData(57367, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData tokens = IconData(57368, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData timer = IconData(57369, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData thickArrowUp = IconData(57370, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData thickArrowRight = IconData(57371, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData thickArrowLeft = IconData(57372, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData thickArrowDown = IconData(57373, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData text = IconData(57374, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData textNone = IconData(57375, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData textAlignTop = IconData(57376, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData textAlignRight = IconData(57377, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData textAlignMiddle = IconData(57378, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData textAlignLeft = IconData(57379, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData textAlignJustify = IconData(57380, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData textAlignCenter = IconData(57381, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData textAlignBottom = IconData(57382, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData target = IconData(57383, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData table = IconData(57384, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData symbol = IconData(57385, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData iconSwitch = IconData(57386, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData sun = IconData(57387, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData strikethrough = IconData(57388, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData stretchVertically = IconData(57389, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData stretchHorizontally = IconData(57390, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData stopwatch = IconData(57391, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData stop = IconData(57392, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData stitchesLogo = IconData(57393, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData star = IconData(57394, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData starFilled = IconData(57395, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData stack = IconData(57396, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData square = IconData(57397, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData speakerQuiet = IconData(57398, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData speakerOff = IconData(57399, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData speakerModerate = IconData(57400, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData speakerLoud = IconData(57401, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData spaceEvenlyVertically = IconData(57402, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData spaceEvenlyHorizontally = IconData(57403, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData spaceBetweenVertically = IconData(57404, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData spaceBetweenHorizontally = IconData(57405, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData slider = IconData(57406, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData slash = IconData(57407, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData sketchLogo = IconData(57408, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData size = IconData(57409, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData shuffle = IconData(57410, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData share2 = IconData(57411, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData share1 = IconData(57412, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData shadow = IconData(57413, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData shadowOuter = IconData(57414, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData shadowNone = IconData(57415, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData shadowInner = IconData(57416, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData sewingPin = IconData(57417, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData sewingPinSolid = IconData(57418, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData sewingPinFilled = IconData(57419, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData section = IconData(57420, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData scissors = IconData(57421, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData rulerSquare = IconData(57422, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData rulerHorizontal = IconData(57423, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData rows = IconData(57424, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData rowSpacing = IconData(57425, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData rotateCounterClockwise = IconData(57426, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData rocket = IconData(57427, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData resume = IconData(57428, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData reset = IconData(57429, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData reload = IconData(57430, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData reader = IconData(57431, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData radiobutton = IconData(57432, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData quote = IconData(57433, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData questionMark = IconData(57434, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData questionMarkCircled = IconData(57435, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData plus = IconData(57436, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData plusCircled = IconData(57437, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData play = IconData(57438, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData pinTop = IconData(57439, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData pinRight = IconData(57440, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData pinLeft = IconData(57441, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData pinBottom = IconData(57442, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData pilcrow = IconData(57443, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData pieChart = IconData(57444, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData person = IconData(57445, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData pencil2 = IconData(57446, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData pencil1 = IconData(57447, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData pause = IconData(57448, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData paperPlane = IconData(57449, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData padding = IconData(57450, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData overline = IconData(57451, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData outerShadow = IconData(57452, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData openInNewWindow = IconData(57453, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData opacity = IconData(57454, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData notionLogo = IconData(57455, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData move = IconData(57456, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData moon = IconData(57457, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData modulzLogo = IconData(57458, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData mobile = IconData(57459, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData mixerVertical = IconData(57460, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData mixerHorizontal = IconData(57461, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData mix = IconData(57462, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData minus = IconData(57463, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData minusCircled = IconData(57464, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData maskOn = IconData(57465, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData maskOff = IconData(57466, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData margin = IconData(57467, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData magnifyingGlass = IconData(57468, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData magicWand = IconData(57469, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData loop = IconData(57470, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData lockOpen2 = IconData(57471, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData lockOpen1 = IconData(57472, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData lockClosed = IconData(57473, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData listBullet = IconData(57474, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData linkedinLogo = IconData(57475, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData linkNone2 = IconData(57476, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData linkNone1 = IconData(57477, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData linkBreak2 = IconData(57478, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData linkBreak1 = IconData(57479, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData link2 = IconData(57480, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData link1 = IconData(57481, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData lineHeight = IconData(57482, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData lightningBolt = IconData(57483, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData letterSpacing = IconData(57484, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData letterCaseUppercase = IconData(57485, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData letterCaseToggle = IconData(57486, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData letterCaseLowercase = IconData(57487, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData letterCaseCapitalize = IconData(57488, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData layout = IconData(57489, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData layers = IconData(57490, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData laptop = IconData(57491, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData lapTimer = IconData(57492, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData keyboard = IconData(57493, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData justifyStretch = IconData(57494, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData justifyStart = IconData(57495, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData justifyEnd = IconData(57496, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData justifyCenter = IconData(57497, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData instagramLogo = IconData(57498, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData input = IconData(57499, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData innerShadow = IconData(57500, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData infoCircled = IconData(57501, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData image = IconData(57502, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData idCard = IconData(57503, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData iconjarLogo = IconData(57504, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData home = IconData(57505, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData hobbyKnife = IconData(57506, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData height = IconData(57507, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData heart = IconData(57508, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData heartFilled = IconData(57509, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData heading = IconData(57510, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData hand = IconData(57511, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData hamburgerMenu = IconData(57512, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData half2 = IconData(57513, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData half1 = IconData(57514, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData group = IconData(57515, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData grid = IconData(57516, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData globe = IconData(57517, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData githubLogo = IconData(57518, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData gear = IconData(57519, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData framerLogo = IconData(57520, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData frame = IconData(57521, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData fontStyle = IconData(57522, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData fontSize = IconData(57523, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData fontRoman = IconData(57524, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData fontItalic = IconData(57525, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData fontFamily = IconData(57526, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData fontBold = IconData(57527, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData file = IconData(57528, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData fileText = IconData(57529, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData filePlus = IconData(57530, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData fileMinus = IconData(57531, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData figmaLogo = IconData(57532, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData face = IconData(57533, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData eyeOpen = IconData(57534, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData eyeNone = IconData(57535, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData eyeClosed = IconData(57536, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData externalLink = IconData(57537, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData exit = IconData(57538, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData exitFullScreen = IconData(57539, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData exclamationTriangle = IconData(57540, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData eraser = IconData(57541, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData envelopeOpen = IconData(57542, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData envelopeClosed = IconData(57543, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData enter = IconData(57544, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData enterFullScreen = IconData(57545, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData dropdownMenu = IconData(57546, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData drawingPin = IconData(57547, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData drawingPinSolid = IconData(57548, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData drawingPinFilled = IconData(57549, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData dragHandleVertical = IconData(57550, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData dragHandleHorizontal = IconData(57551, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData dragHandleDots2 = IconData(57552, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData dragHandleDots1 = IconData(57553, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData download = IconData(57554, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData doubleArrowUp = IconData(57555, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData doubleArrowRight = IconData(57556, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData doubleArrowLeft = IconData(57557, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData doubleArrowDown = IconData(57558, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData dotsVertical = IconData(57559, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData dotsHorizontal = IconData(57560, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData dot = IconData(57561, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData dotSolid = IconData(57562, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData dotFilled = IconData(57563, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData dividerVertical = IconData(57564, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData dividerHorizontal = IconData(57565, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData discordLogo = IconData(57566, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData disc = IconData(57567, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData dimensions = IconData(57568, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData desktop = IconData(57569, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData dashboard = IconData(57570, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData dash = IconData(57571, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData cursorText = IconData(57572, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData cursorArrow = IconData(57573, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData cube = IconData(57574, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData crumpledPaper = IconData(57575, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData crosshair2 = IconData(57576, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData crosshair1 = IconData(57577, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData crossCircled = IconData(57578, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData cross2 = IconData(57579, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData cross1 = IconData(57580, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData crop = IconData(57581, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData counterClockwiseClock = IconData(57582, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData countdownTimer = IconData(57583, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData corners = IconData(57584, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData cornerTopRight = IconData(57585, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData cornerTopLeft = IconData(57586, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData cornerBottomRight = IconData(57587, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData cornerBottomLeft = IconData(57588, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData copy = IconData(57589, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData cookie = IconData(57590, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData container = IconData(57591, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData componentPlaceholder = IconData(57592, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData componentNone = IconData(57593, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData componentInstance = IconData(57594, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData componentBoolean = IconData(57595, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData component2 = IconData(57596, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData component1 = IconData(57597, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData commit = IconData(57598, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData columns = IconData(57599, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData columnSpacing = IconData(57600, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData colorWheel = IconData(57601, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData codesandboxLogo = IconData(57602, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData code = IconData(57603, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData clock = IconData(57604, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData clipboard = IconData(57605, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData clipboardCopy = IconData(57606, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData circle = IconData(57607, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData circleBackslash = IconData(57608, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData chevronUp = IconData(57609, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData chevronRight = IconData(57610, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData chevronLeft = IconData(57611, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData chevronDown = IconData(57612, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData checkbox = IconData(57613, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData check = IconData(57614, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData checkCircled = IconData(57615, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData chatBubble = IconData(57616, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData caretUp = IconData(57617, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData caretSort = IconData(57618, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData caretRight = IconData(57619, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData caretLeft = IconData(57620, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData caretDown = IconData(57621, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData cardStack = IconData(57622, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData cardStackPlus = IconData(57623, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData cardStackMinus = IconData(57624, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData camera = IconData(57625, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData calendar = IconData(57626, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData button = IconData(57627, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData box = IconData(57628, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData boxModel = IconData(57629, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData borderWidth = IconData(57630, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData borderTop = IconData(57631, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData borderStyle = IconData(57632, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData borderSplit = IconData(57633, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData borderSolid = IconData(57634, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData borderRight = IconData(57635, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData borderNone = IconData(57636, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData borderLeft = IconData(57637, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData borderDotted = IconData(57638, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData borderDashed = IconData(57639, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData borderBottom = IconData(57640, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData borderAll = IconData(57641, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData bookmark = IconData(57642, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData bookmarkFilled = IconData(57643, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData blendingMode = IconData(57644, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData bell = IconData(57645, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData barChart = IconData(57646, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData badge = IconData(57647, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData backpack = IconData(57648, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData avatar = IconData(57649, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData aspectRatio = IconData(57650, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData arrowUp = IconData(57651, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData arrowTopRight = IconData(57652, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData arrowTopLeft = IconData(57653, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData arrowRight = IconData(57654, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData arrowLeft = IconData(57655, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData arrowDown = IconData(57656, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData arrowBottomRight = IconData(57657, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData arrowBottomLeft = IconData(57658, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData archive = IconData(57659, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData angle = IconData(57660, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData allSides = IconData(57661, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData alignVerticalCenters = IconData(57662, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData alignTop = IconData(57663, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData alignStretch = IconData(57664, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData alignStart = IconData(57665, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData alignRight = IconData(57666, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData alignLeft = IconData(57667, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData alignHorizontalCenters = IconData(57668, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData alignEnd = IconData(57669, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData alignCenter = IconData(57670, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData alignCenterVertically = IconData(57671, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData alignCenterHorizontally = IconData(57672, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData alignBottom = IconData(57673, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData alignBaseline = IconData(57674, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData activityLog = IconData(57675, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
  static const IconData accessibility = IconData(57676, fontFamily: 'RadixIcons', fontPackage: 'shadcn_flutter');
}
