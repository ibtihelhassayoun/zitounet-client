import 'package:flutter/material.dart';

/// Design System Palette - ZitouNet
class AppColors {
  // Couleurs Principales (Deep Green & Olive)
  static const Color deepGreen = Color(0xFF30360E);       // Titres et arrière-plans foncés
  static const Color deepGreen2 = Color(0xFF1E230A);      // Bande inférieure du footer
  static const Color olive = Color(0xFF787F56);           // Couleur d'accentuation, boutons, icônes
  static const Color oliveLight = Color(0xFF9AA470);      // Variante plus claire d'accentuation

  // Aliases for compatibility
  static const Color oliveDeep = deepGreen;               // 0xFF30360E
  static const Color olivePrimary = olive;                // 0xFF787F56
  static const Color oliveLeaf = oliveLight;              // 0xFF9AA470

  // Couleurs Claires (Beige & Arrière-plans)
  static const Color beige = Color(0xFFE2D4B9);
  static const Color beigeLight = Color(0xFFF5EFE0);      // Arrière-plan principal des pages
  static const Color darkCard = Color(0xFFEDE5D0);        // Cartes ou blocs sur fond clair

  static const Color bgCream = beigeLight;                // 0xFFF5EFE0
  static const Color cardBg = darkCard;                   // 0xFFEDE5D0

  // Couleurs de Texte & Bordures
  static const Color textDark = Color(0xFF30360E);        // Texte principal
  static const Color textLight = Color(0xFFFFFFFF);       // Texte sur fond foncé
  static const Color textMuted = Color(0x9430360E);       // rgba(48, 54, 14, 0.58)
  static const Color darkBorder = Color(0x1A30360E);      // rgba(48, 54, 14, 0.10)
  static const Color border = darkBorder;

  // Statuts & Accents
  static const Color goldPrimary = olive;
  static const Color goldLight = beige;
  static const Color goldDark = deepGreen;

  static const Color statusCompletedBg = beige;
  static const Color statusCompletedText = deepGreen;

  static const Color statusCurrentBg = oliveLight;
  static const Color statusCurrentText = deepGreen2;

  static const Color statusUpcomingBg = darkCard;
  static const Color statusUpcomingText = textMuted;
}
