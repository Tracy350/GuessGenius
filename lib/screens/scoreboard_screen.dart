import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScoreboardScreen extends StatelessWidget {
  const ScoreboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splashbg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 500,
              width: double.infinity, // Makes it take full width
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(
                    0.8), // Slight opacity for a better background blend
                borderRadius:
                    BorderRadius.circular(16), // Rounded corners for modern UI
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 30,
                    ),
                    const SizedBox(height: 20),
                    _buildScoreCard(
                        position: '1st', name: 'Tracy', score: '56'),
                    const SizedBox(height: 10),
                    _buildScoreCard(
                        position: '2nd', name: 'Tracy', score: '56'),
                    const SizedBox(height: 10),
                    _buildScoreCard(
                        position: '3rd', name: 'Tracy', score: '45'),
                    const SizedBox(height: 10),
                    _buildScoreCard(
                        position: '4th', name: 'Tracy', score: '45'),
                    const SizedBox(height: 10),
                    _buildScoreCard(
                        position: '5th', name: 'Tracy', score: '45'),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScoreCard(
      {required String position, required String name, required String score}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$position: ',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.orange,
            ),
          ),
          Text(
            name,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          Text(
            score,
            style: GoogleFonts.montserrat(
              color: Colors.grey,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
