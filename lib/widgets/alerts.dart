import 'package:flutter/material.dart';

abstract class Alerts {
  static Future<void> showModal(
    BuildContext context,
    String title,
    String body, {
    required VoidCallback primaryButtonAction,
    VoidCallback? secondaryButtonAction,
    required String primaryButtonText,
    String? secondaryButtonText,
    bool hideSecondaryButton = false,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF242A32),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    body,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      if (!hideSecondaryButton) ...[
                        Expanded(
                          child: ElevatedButton(
                            onPressed: secondaryButtonAction ??
                                () {
                                  Navigator.of(context).pop();
                                },
                            child: Text(secondaryButtonText ?? "Close"),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                      ],
                      Expanded(
                        child: ElevatedButton(
                          onPressed: primaryButtonAction,
                          child: Text(primaryButtonText),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
