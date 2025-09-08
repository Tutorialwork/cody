import 'package:cody/constants/style_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final String currentRouteName;
  final Function(String) onNewRouteName;

  const Navbar(this.currentRouteName, this.onNewRouteName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        height: kBottomNavigationBarHeight * 1.5,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                  top: 0,
                  left: 40,
                  child: Container(
                    color: currentRouteName == 'codes'
                        ? primaryColor
                        : Colors.white,
                    width: 60,
                    height: 5,
                  )),
              Positioned(
                left: 50,
                child: InkWell(
                  onTap: () => onNewRouteName('codes'),
                  child: const Icon(
                    CupertinoIcons.lock,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ),
              Positioned(
                  top: -30,
                  child: InkWell(
                    onTap: () => onNewRouteName('codes/add'),
                    child: Container(
                      padding: const EdgeInsets.all(smallSize),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: primaryColor,
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  )),
              Positioned(
                  top: 0,
                  right: 40,
                  child: Container(
                    color: currentRouteName == 'password/generator'
                        ? primaryColor
                        : Colors.white,
                    width: 60,
                    height: 5,
                  )),
              Positioned(
                right: 50,
                child: InkWell(
                  onTap: () => onNewRouteName('password/generator'),
                  child: const Icon(
                    Icons.key,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
