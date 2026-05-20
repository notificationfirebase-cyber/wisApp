import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../common/helper.dart';
import '../controller/no_internet_controller.dart'; // ← NEW


class NoInternetScreen extends StatelessWidget {
   NoInternetScreen({super.key});

   final NoInternetController controller = Get.put(NoInternetController());



  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sw * 0.08),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(flex: 2),

                        // ── Logo ──────────────────────────────────────
                        Center(
                          child: Image.asset(
                            AppImage.wosAppIcon,
                            width: sw * 0.42,
                            fit: BoxFit.contain,
                          ),
                        ),

                        SizedBox(height: sh * 0.05),
                        Center(
                          child: Image.asset(
                            AppImage.satellite,
                            width: sw * 0.30,
                            fit: BoxFit.contain,
                          ),
                        ),
                        // ── Satellite icon ─────────────────────────────
                        //_SatelliteDishIcon(size: sw * 0.28),

                        SizedBox(height: sh * 0.04),

                        // ── Title ──────────────────────────────────────
                        Obx(() => Center(
                          child: Text(
                                controller.isServerError.value
                                    ? 'Server Unreachable'
                                    : "You're Offline",
                                style: GoogleFonts.poppins(
                                  color: AppColor.secondryColor,
                                  fontSize: sw * 0.065,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                        )),

                        SizedBox(height: sh * 0.018),

                        // ── Sub-message ────────────────────────────────
                        Obx(() => Center(
                          child: Text(
                                controller.isServerError.value
                                    ? 'Our server is currently unreachable.\nPlease try again in a moment.'
                                    : "Looks like your connection took a break\nDon't worry - your learning journey is still on track.",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: sw * 0.035,
                                  height: 1.6,
                                ),
                                textAlign: TextAlign.center,
                              ),
                        )),

                        SizedBox(height: sh * 0.015),

                        // ── Hint ───────────────────────────────────────
                        Center(
                          child: Text(
                            'Reconnect to continue exploring.',
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontSize: sw * 0.032,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        SizedBox(height: sh * 0.05),

                        // ── Try Again button ───────────────────────────
                        Obx(() => Center(
                          child: ElevatedButton(
                                onPressed: controller.isChecking.value
                                    ? null
                                    : controller.retryConnection,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.secondryColor,
                                  disabledBackgroundColor: AppColor.secondryColor.withValues(alpha: 0.6),                                padding: EdgeInsets.symmetric(
                                    horizontal: sw * 0.12,
                                    vertical: sh * 0.018,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(sw * 0.08),
                                  ),
                                  elevation: 0,
                                ),
                                child: controller.isChecking.value
                                    ? SizedBox(
                                        width: sw * 0.055,
                                        height: sw * 0.055,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: sw * 0.006,
                                        ),
                                      )
                                    : Text(
                                        'Try Again',
                                        style: GoogleFonts.poppins(
                                          color: AppColor.primaryColor,
                                          fontSize: sw * 0.038,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                        )),

                        const Spacer(flex: 3),

                        // ── Footer ─────────────────────────────────────
                        Center(
                          child: Text(
                            'Wheaton Online School \u2022 Learning For Life',
                            style: GoogleFonts.poppins(
                              color: Colors.white38,
                              fontSize: sw * 0.028,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        SizedBox(height: sh * 0.02),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ── Satellite dish — fully relative to canvas size ───────────────────────────
class _SatelliteDishIcon extends StatelessWidget {
  final double size;
  const _SatelliteDishIcon({required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _SatellitePainter()),
    );
  }
}

class _SatellitePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2;

    final dishRadius = w * 0.32;
    final strokeW = w * 0.028;

    final fillPaint = Paint()
      ..color = AppColor.primaryColor
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = AppColor.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round;

    final rimPaint = Paint()
      ..color = AppColor.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW * 0.85;

    // Dish body
    final dishCenter = Offset(cx - w * 0.08, cy + h * 0.08);
    final rect = Rect.fromCenter(
      center: dishCenter,
      width: dishRadius * 2,
      height: dishRadius * 2,
    );
    canvas.drawArc(rect, -2.8, 2.2, true, fillPaint);
    canvas.drawArc(rect, -2.8, 2.2, false, rimPaint);

    // Pole
    canvas.drawLine(
      Offset(cx - w * 0.08, cy + h * 0.38),
      Offset(cx - w * 0.08, cy + h * 0.50),
      strokePaint,
    );

    // Base
    canvas.drawLine(
      Offset(cx - w * 0.22, cy + h * 0.50),
      Offset(cx + w * 0.06, cy + h * 0.50),
      strokePaint,
    );

    // Signal waves
    for (int i = 1; i <= 3; i++) {
      final r = w * (0.10 + i * 0.09);
      final signalCenter = Offset(cx + w * 0.16, cy - h * 0.08);
      canvas.drawArc(
        Rect.fromCenter(center: signalCenter, width: r * 2, height: r * 2),
        -2.3,
        1.0,
        false,
        Paint()
          ..color = AppColor.primaryColor.withAlpha(
            ((1.0 - i * 0.25) * 255).toInt().clamp(0, 255),
          )          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeW * 0.8
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
