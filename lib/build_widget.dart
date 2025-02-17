import 'package:flutter/material.dart';

Widget buildTile(BuildContext context, String title, IconData icon, Widget page) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(16), // More rounded for a modern feel
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          ),
          splashColor: Colors.green.withOpacity(0.3), // Enhanced splash effect
          highlightColor: Colors.transparent, // Clean look with no highlight color
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300), // Longer animation for smooth transition
            curve: Curves.easeInOut, // Smoother animation curve
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade800, Colors.green], // Updated gradient for contrast
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 12,
                  offset: Offset(0, 8),
                  spreadRadius: 2, // Softer, wider shadow
                ),
              ],
              borderRadius: BorderRadius.circular(16), // Consistent rounded corners
            ),
            padding: EdgeInsets.symmetric(vertical: 16,horizontal: 10), // Increased padding for aesthetics and spacing
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedScale(
                  duration: Duration(milliseconds: 150),
                  scale: 1.2, // Slight scale-up effect on press for interaction
                  child: Icon(
                    icon,
                    size: 50, // Larger icon for greater emphasis
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12), // Increased space between icon and text
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14, // Larger text for more impact
                    fontWeight: FontWeight.w700, // Bolder font weight
                    color: Colors.white, // White text for contrast
                    letterSpacing: 1.0, // Slight letter spacing for clarity
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black45,
                        offset: Offset(2.0, 2.0), // Adding a subtle text shadow
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
