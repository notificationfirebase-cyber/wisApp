
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class AppColor{
  static const Color primaryColor=Color(0xFF3e92cc);
  static const Color secondryColor=Color(0xFFBFA14A);
  static const Color lightBlueColor=Color(0xFF0d6efd);


}

class AppFSize{
  static const double mediumFont=15.0;
  static const double largeFont=20.0;
  static const double smallFont=12.0;
}

class AppImage{

  static const String splashLogo="assets/images/splashLogo.png";
  static const String appIcon="assets/images/wisAppIcon.png";
  static const String satellite="assets/images/satellite.png";
  static const String wosAppIcon="assets/images/school_name.png";


}

class AppStyles {
  static  TextStyle headerTextStyle = GoogleFonts.poppins(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static  TextStyle bodyTextStyle = GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 14,
  );
}
/*
class Helper{
  static Future<void> checkInternet(Future<void> Function() onConnected) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          await onConnected(); // Internet is really available
          return;
        }
      } on SocketException catch (_) {
        // Still no real internet
      }
    }

    ToastMessage.msg("Please check your internet connection");
  }

///Ix
*/
/*  static Future<void> checkInternet(Future<dynamic> callback) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      callback.asStream();
      // callback.call();
    } else {
      Fluttertoast.showToast(msg: "Check Internet connection");
    }
  }*//*


 */
/* static Widget CustomCNImage(String imageURL, double cHeight, double cWidth){
    return CachedNetworkImage(
      imageUrl: imageURL,//"",//"https://img.freepik.com/free-photo/close-up-portrait-brunette-smiling-woman-looking-confident-front-standing-hoodie-against-white-wall_176420-39066.jpg?t=st=1737785621~exp=1737789221~hmac=e5648802111562bfcb27f8ed3e9c8d2ca70f826e407a1b9007a98e326b455929&w=1380",
      imageBuilder: (context, imageProvider) => Container(
        width: cHeight, // Must be 2 * radius to fit
        //height: cWidth, // Must be 2 * radius to fit
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            *//*
*/
/*  colorFilter:
                               ColorFilter.mode(Colors.red, BlendMode.colorBurn)*//*
*/
/*
          ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
        ),
      ),
      errorWidget: (context, url, error) =>ClipOval(
        child: Container(
          width: 80, // Must be 2 * radius to fit
          height: 80, // Must be 2 * radius to fit
          color: Colors.white,
          child: Icon(Icons.person, size: 40,),
        ),
      ),
    );
  }


  static Widget CustomCNImageBig(String imageURL, double cHeight, double cWidth){
    return CachedNetworkImage(
      imageUrl: imageURL,//"",//"https://img.freepik.com/free-photo/close-up-portrait-brunette-smiling-woman-looking-confident-front-standing-hoodie-against-white-wall_176420-39066.jpg?t=st=1737785621~exp=1737789221~hmac=e5648802111562bfcb27f8ed3e9c8d2ca70f826e407a1b9007a98e326b455929&w=1380",
      imageBuilder: (context, imageProvider) => Container(
        width: cHeight, // Must be 2 * radius to fit
        //height: cWidth, // Must be 2 * radius to fit
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            *//*
*/
/*  colorFilter:
                               ColorFilter.mode(Colors.red, BlendMode.colorBurn)*//*
*/
/*
          ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[300],

          ),
        ),
      ),
      errorWidget: (context, url, error) =>Center(
        child: Container(
          width: 200, // Must be 2 * radius to fit
          height: 200, // Must be 2 * radius to fit
          color: Colors.white,
          child: Image.asset(AppImage.img_logo),
        ),
      ),
    );
  }
*//*

  static Map<String, String> splitName(String fullName) {
    List<String> nameParts = fullName.trim().split(' ');

    if (nameParts.length == 1) {
      return {
        'firstName': nameParts[0],
        'lastName': '',
      };
    }

    String firstName = nameParts.sublist(0, nameParts.length - 1).join(' ');
    String lastName = nameParts.last;

    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }


  static Widget customDivider({
    required color
}){
    return SizedBox(
      height: 10,
      child: Divider(
        color: color,
        height: 10,
      ),
    );
  }

  static String capitalizeEachWord(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join(' ');
  }
  static String formatDate(String dateTime) {


    try {
      // Parse the input date-time string
      DateTime parsedDateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SS").parse(dateTime);

      // Format to "dd-MM-yyyy, HH:mm a"
      return DateFormat("dd-MM-yyyy, HH:mm a").format(parsedDateTime);
    } catch (e) {
      return "Invalid Date Format";
    }
  }
  static String convertToIso8601(String dateString) {
    try {
      // Parse the input date in "MM/dd/yyyy" format
      DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(dateString);

      // Convert to ISO 8601 format with UTC
      return parsedDate.toIso8601String(); // returns "2025-04-01T00:00:00.000Z"
    } catch (e) {
      return "Invalid Date Format";
    }
  }
  static String convertFromIso8601(String? isoDateString) {
    try {
      if (isoDateString == null || isoDateString.isEmpty) {
        return ""; // or whatever fallback you want
      }

      DateTime parsedDate = DateTime.parse(isoDateString);
      return DateFormat("yyyy-MM-dd").format(parsedDate.toLocal());
    } catch (e) {
      return "Invalid Date";
    }
  }

  static String convertDateTime(String dateTimeStr) {
    try {
      // Parse the input date-time string
      DateTime parsedDateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(dateTimeStr);

      // Subtract one day
     // parsedDateTime = parsedDateTime.subtract(Duration(days: 1));

      // Format to "dd-MM-yyyy, HH:mm a"
      return DateFormat("dd-MM-yyyy, HH:mm a").format(parsedDateTime);
    } catch (e) {
      return "Invalid Date Format";
    }
  }

  static String birthdayFormat(String dateTime) {
    // Split the string at 'T' to get the date part
    String datePart = dateTime.split('T')[0];

    // Split the date into year, month, and day
    List<String> parts = datePart.split('-');

    // Get the current year
    String currentYear = DateTime.now().year.toString();

    // Return the date in DD-MM-YYYY format with the current year
    return '${parts[2]}-${parts[1]}-$currentYear';
  }
 */
/* static String formatTimeAgo(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inDays >= 1) {
      // If more than a day, show formatted date & time
      return DateFormat('dd-MM-yyyy, h:mm a').format(dateTime);
    } else {
      // Show relative time like "5 min ago"
      return timeago.format(dateTime, locale: 'en');
    }
  }*//*

  static String formatCallDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    List<String> parts = [];

    if (hours > 0) parts.add("${hours}h");
    if (minutes > 0) parts.add("${minutes}m");
    if (remainingSeconds > 0 || parts.isEmpty) parts.add("${remainingSeconds}s");

    return parts.join(" ");
  }

  static String attendanceDateFormat(String dateTime) {
    // Split the string at 'T' to get the date part
    String datePart = dateTime.split('T')[0];

    // Split the date into year, month, and day
    List<String> parts = datePart.split('-');

    // Get the current year
    String currentYear = DateTime.now().year.toString();

    // Return the date in DD-MM-YYYY format with the current year
    // return '${parts[2]}-${parts[1]}-$currentYear';
    return '$currentYear-${parts[1]}-${parts[2]}';
  }

  static String convertUnixTo12HourFormat(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('h:mm:ss a').format(dateTime); // local time
  }


  static String convertListToCsvSafe(List<String?> items) {
    return items
        .where((item) => item != null && item.trim().isNotEmpty)
        .map((e) => e!.trim())
        .join(',');
  }



  static void ApiReq(String url, dynamic data) {
    print("🛰️ [API Request] ➡️ $url\n📝 Payload: $data\n-----------------------------");
  }

  /// 📥 Logs API Response
  static void ApiRes(String url, dynamic response) {
    print("🎁 [API Response] ⬅️ $url\n📄 Response: $response\n=============================");
  }

  static String cleanText(String text) {
    return text.trim().isEmpty ? "" : text.trim();
  }
  static void debugJsonTypes(dynamic json, [String parentKey = ""]) {
    if (json is Map<String, dynamic>) {
      json.forEach((key, value) {
        final fullKey = parentKey.isEmpty ? key : "$parentKey.$key";
        print("I am here-->1");
        debugJsonTypes(value, fullKey);
      });
    } else if (json is List) {
      for (int i = 0; i < json.length; i++) {
        print("I am here-->2");
        debugJsonTypes(json[i], "$parentKey[$i]");
      }
    } else {
      print("$parentKey -> ${json.runtimeType} -> $json");
    }
  }
  static int calculateAge(String dobString) {
    DateTime dob = DateTime.parse(dobString); // parse from API
    DateTime today = DateTime.now();

    int age = today.year - dob.year;

    // If birthday hasn’t occurred yet this year → subtract 1
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }

    return age;
  }


  static String formatStringToSerialNumbers(String input, {String separator = ','}) {
    // Split string by separator, trim spaces, and remove empty parts
    final parts = input.split(separator).map((e) => e.trim()).where((e) => e.isNotEmpty).toList();

    // Map with serial numbers
    final formatted = parts.asMap().entries.map((entry) {
      final index = entry.key + 1;
      final value = entry.value.toUpperCase(); // if you want everything in caps
      return "($index) $value";
    }).join('\n');

    return formatted;
  }

  static String capitalizeWords(String input) {
    if (input.isEmpty) return input;

    return input
        .split(' ') // split by spaces
        .map((word) {
      if (word.trim().isEmpty) return word; // keep multiple spaces intact
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    })
        .join(' ');
  }

  static int? parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }



  static String? utrNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please Enter UTR Number";
    }

    String utr = value.trim();

    // UTR usually 12 to 22 characters
    if (utr.length < 12 || utr.length > 22) {
      return "Enter a valid UTR Number (12–22 characters)";
    }

    // Only alphanumeric (banks use mix of letters + numbers)
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(utr)) {
      return "UTR must be alphanumeric";
    }

    return null;
  }
  static String? confirmPasswordMatchValidation(
      String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }


*/
/*class HelperClass {


  static Future<DocumentCamImage?> pickImage({BuildContext? context}) async {
    final picker = ImagePicker();

    if (context == null) {
      // If no context is passed, use gallery directly
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return DocumentCamImage(file: File(pickedFile.path));
      }
      return null;
    }

    // If context is provided, show camera/gallery dialog
    final result = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (_) => _buildImagePickerSheet(),
    );

    if (result != null) {
      final pickedFile = await picker.pickImage(source: result);
      if (pickedFile != null) {
        return DocumentCamImage(file: File(pickedFile.path));
      }
    }

    return null;
  }

  static Widget _buildImagePickerSheet() {
    return SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text("Take Photo"),
            onTap: () => Navigator.of(Get.context!).pop(ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text("Choose from Gallery"),
            onTap: () => Navigator.of(Get.context!).pop(ImageSource.gallery),
          ),
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text("Cancel"),
            onTap: () => Navigator.of(Get.context!).pop(),
          ),
        ],
      ),
    );
  }

  static Future<DocumentCamImage?> pickImageFromCamera() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) {
      return DocumentCamImage(file: File(picked.path), isLocal: true);
    }
    return null;
  }

  static Future<DocumentCamImage?> pickImageFromGallery() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      return DocumentCamImage(file: File(picked.path), isLocal: true);
    }
    return null;
  }

}*//*




}
*/


/*
class ToastMessage {
  static void msg(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
        backgroundColor: AppColor.secondaryColor,
        textColor: Colors.white);
  }

  static void alertmsg(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
        backgroundColor: AppColor.primaryColor,
        textColor: Colors.white);
  }

  static void msgRed(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
        backgroundColor: Colors.red,
        textColor: AppColor.appWhite);
  }
  static void msgPrimary(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
        backgroundColor: AppColor.primaryColor,
        textColor: AppColor.secondaryColor);
  }
}
*/

class MultipartFieldHelper {
  /// Adds a field if [value] is not null and not equal to "string"
  /// If invalid, assigns "null" (as string)
  static void addField(Map<String, String> fields, String key, String? value) {
    if (value != null && value != "string") {
      fields[key] = value;
    } else {
      fields[key] = "null";
    }
  }

  static void addFieldWithoutNull(Map<String, String> fields, String key, String? value) {
    if (value != null && value != "string") {
      fields[key] = value;
    } else {
      fields[key] = "";
    }
  }

  /// Overloaded version with default fallback (optional)
  static void addFieldWithDefault(
      Map<String, String> fields,
      String key,
      String? value, {
        String fallback = "0",
      }) {

    if (value != null && value != "" && value != "null") {
      fields[key] = value;
    } else {
      fields[key] = fallback;
    }
  }


}