import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../common/helper.dart';
import '../controller/login_controller.dart';




class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await controller.onBackPressed();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color.alphaBlend(
            Colors.white.withOpacity(0.5),
            AppColor.primaryColor,
          ),         // appBar: _buildAppBar(controller),
          body: _buildBody(controller),
        ),
      ),
    );
  }


  Widget _buildBody(LoginController controller) {
    return Stack(
      // mainAxisSize: MainAxisSize.max,
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: ClipRRect(
            child: WebViewWidget(
              controller: controller.webViewController,
            ),
          ),
        ),
        // Progress bar
        Obx(() => controller.isLoading.value
            ?  const Center(
              child: CircularProgressIndicator(
                color: AppColor.secondryColor,
                strokeWidth: 2.5,
              ),
            )
            : const SizedBox.shrink()),

        // WebView

      ],
    );
  }
}