import 'package:flutter/material.dart';

class ValueContainer extends StatelessWidget {
  final double height, width;
  final int size;
  final String title;
  final int value;
  final Icon icon;
  ValueContainer(
      this.height, this.width, this.size, this.title, this.value, this.icon);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.15,
      width: size == 1 ? width * 0.13 : width * 0.145,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: icon,
              ),
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          Container(
            child: Text(
              value.toString(),
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
