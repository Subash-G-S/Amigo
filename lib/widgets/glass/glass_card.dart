import 'dart:ui';

import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {

  final Widget child;

  const GlassCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {

    return ClipRRect(

      borderRadius:
          BorderRadius.circular(28),

      child: BackdropFilter(

        filter: ImageFilter.blur(
          sigmaX: 30,
          sigmaY: 30,
        ),

        child: Container(

          decoration: BoxDecoration(

            color:
                Colors.white.withOpacity(.08),

            borderRadius:
                BorderRadius.circular(28),

            border: Border.all(

              color:
                  Colors.white.withOpacity(.12),

            ),

            boxShadow: [

              BoxShadow(

                color:
                    Colors.black.withOpacity(.25),

                blurRadius: 40,

                offset:
                    const Offset(0, 20),
              ),
            ],
          ),

          child: child,
        ),
      ),
    );
  }
}