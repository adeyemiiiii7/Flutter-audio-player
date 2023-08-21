import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MediaMetadata extends StatelessWidget {
  const MediaMetadata({super.key,
  required this.imageUrl,
  required this.title,
  required this.artist});

  final String imageUrl;
  final String title;
  final String artist;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
          boxShadow:  const [ 
            BoxShadow(
          color: Colors.black12,
          offset: Offset(2,4),
          blurRadius: 4,
            ),
      ],
      borderRadius: BorderRadius.circular(10),
          ),
child: ClipRect(
//borderRadius: BorderRadius.circular(10),
child: CachedNetworkImage       (
imageUrl: imageUrl,
height: 300,
width: 300,
fit: BoxFit.cover,
),
),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight:  FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          artist,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight:  FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ]
  
    );
  }
}