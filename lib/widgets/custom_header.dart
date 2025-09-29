import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHeader extends StatelessWidget {
  final bool showBack;
  final VoidCallback? onBack;
  final bool showHelp;
  final VoidCallback? onHelp;

  const CustomHeader({
    super.key,
    this.showBack = false,
    this.onBack,
    this.showHelp = false,
    this.onHelp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          if (showBack)
            IconButton(
              onPressed: onBack ?? () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: AppConstants.textColor,
              ),
            )
          else
            const SizedBox(width: 40), // Espacio para balance

          const Expanded(
            child: Text(
              AppConstants.appName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppConstants.primaryColor,
                fontFamily: 'Public Sans',
              ),
            ),
          ),

          if (showHelp)
            IconButton(
              onPressed: onHelp,
              icon: const Icon(
                Icons.help_outline,
                color: AppConstants.textColor,
              ),
            )
          else
            const SizedBox(width: 48), // Para balance visual
        ],
      ),
    );
  }
}