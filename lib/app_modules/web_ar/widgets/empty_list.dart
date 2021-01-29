import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1,
      duration: Duration(seconds: 1),
      child: Container(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/empty.svg',
              fit: BoxFit.fill,
            ),
            SizedBox(height: 20),
            Text('Empty',
                style: TextStyle(
                    color: const Color(0xff555459),
                    fontSize: 15,
                    fontWeight: FontWeight.w500)),
            SizedBox(height: 10),
            Text('Object not found',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xff555459),
                  fontSize: 15,
                )),
            SizedBox(height: 10),
          ],
        ),
      )),
    );
  }
}
