import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget _buildIngredientRow(String ingredient, String measure) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ingredient,
          style: GoogleFonts.openSans(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          measure,
          style: GoogleFonts.openSans(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        )
      ],
    ),
  );
}

Widget printIngredients(dynamic data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (data?.strIngredient1 != "" &&
          data?.strMeasure1 != "" &&
          data?.strIngredient1 != null &&
          data?.strMeasure1 != null)
        _buildIngredientRow(data!.strIngredient1, data!.strMeasure1),
      if (data?.strIngredient2 != "" &&
          data?.strMeasure2 != "" &&
          data?.strIngredient2 != null &&
          data?.strMeasure2 != null)
        _buildIngredientRow(data!.strIngredient2, data!.strMeasure2),
      if (data?.strIngredient3 != "" &&
          data?.strMeasure3 != "" &&
          data?.strIngredient3 != null &&
          data?.strMeasure3 != null)
        _buildIngredientRow(data!.strIngredient3, data!.strMeasure3),
      if (data?.strIngredient4 != "" &&
          data?.strMeasure4 != "" &&
          data?.strIngredient4 != null &&
          data?.strMeasure4 != null)
        _buildIngredientRow(data!.strIngredient4, data!.strMeasure4),
      if (data?.strIngredient5 != "" &&
          data?.strMeasure5 != "" &&
          data?.strIngredient5 != null &&
          data?.strMeasure5 != null)
        _buildIngredientRow(data!.strIngredient5, data!.strMeasure5),
      if (data?.strIngredient6 != "" &&
          data?.strMeasure6 != "" &&
          data?.strIngredient6 != null &&
          data?.strMeasure6 != null)
        _buildIngredientRow(data!.strIngredient6, data!.strMeasure6),
      if (data?.strIngredient7 != "" &&
          data?.strMeasure7 != "" &&
          data?.strIngredient7 != null &&
          data?.strMeasure7 != null)
        _buildIngredientRow(data!.strIngredient7, data!.strMeasure7),
      if (data?.strIngredient8 != "" &&
          data?.strMeasure8 != "" &&
          data?.strIngredient8 != null &&
          data?.strMeasure8 != null)
        _buildIngredientRow(data!.strIngredient8, data!.strMeasure8),
      if (data?.strIngredient9 != "" &&
          data?.strMeasure9 != "" &&
          data?.strIngredient9 != null &&
          data?.strMeasure9 != null)
        _buildIngredientRow(data!.strIngredient9, data!.strMeasure9),
      if (data?.strIngredient10 != "" &&
          data?.strMeasure10 != "" &&
          data?.strIngredient10 != null &&
          data?.strMeasure10 != null)
        _buildIngredientRow(data!.strIngredient10, data!.strMeasure10),
      if (data?.strIngredient11 != "" &&
          data?.strMeasure11 != "" &&
          data?.strIngredient11 != null &&
          data?.strMeasure11 != null)
        _buildIngredientRow(data!.strIngredient11, data!.strMeasure11),
      if (data?.strIngredient12 != "" &&
          data?.strMeasure12 != "" &&
          data?.strIngredient12 != null &&
          data?.strMeasure12 != null)
        _buildIngredientRow(data!.strIngredient12, data!.strMeasure12),
      if (data?.strIngredient13 != "" &&
          data?.strMeasure13 != "" &&
          data?.strIngredient13 != null &&
          data?.strMeasure13 != null)
        _buildIngredientRow(data!.strIngredient13, data!.strMeasure13),
      if (data?.strIngredient14 != "" &&
          data?.strMeasure14 != "" &&
          data?.strIngredient14 != null &&
          data?.strMeasure14 != null)
        _buildIngredientRow(data!.strIngredient14, data!.strMeasure14),
      if (data?.strIngredient15 != "" &&
          data?.strMeasure15 != "" &&
          data?.strIngredient15 != null &&
          data?.strMeasure15 != null)
        _buildIngredientRow(data!.strIngredient15, data!.strMeasure15),
      if (data?.strIngredient16 != "" &&
          data?.strMeasure16 != "" &&
          data?.strIngredient16 != null &&
          data?.strMeasure16 != null)
        _buildIngredientRow(data!.strIngredient16, data!.strMeasure16),
      if (data?.strIngredient17 != "" &&
          data?.strMeasure17 != "" &&
          data?.strIngredient17 != null &&
          data?.strMeasure17 != null)
        _buildIngredientRow(data!.strIngredient17, data!.strMeasure17),
      if (data?.strIngredient18 != "" &&
          data?.strMeasure18 != "" &&
          data?.strIngredient18 != null &&
          data?.strMeasure18 != null)
        _buildIngredientRow(data!.strIngredient18, data!.strMeasure18),
      if (data?.strIngredient19 != "" &&
          data?.strMeasure19 != "" &&
          data?.strIngredient19 != null &&
          data?.strMeasure19 != null)
        _buildIngredientRow(data!.strIngredient19, data!.strMeasure19),
      if (data?.strIngredient20 != "" &&
          data?.strMeasure20 != "" &&
          data?.strIngredient20 != null &&
          data?.strMeasure20 != null)
        _buildIngredientRow(data!.strIngredient20, data!.strMeasure20),
    ],
  );
}
