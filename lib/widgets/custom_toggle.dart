import 'package:flutter/material.dart';

class IconToggleButton extends StatelessWidget {
  const IconToggleButton(
      {Key? key, required this.isSelected, required this.onPressed})
      : super(key: key);
  final bool isSelected;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSelected ? Colors.white : Colors.black38),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                isSelected == true ? onPressed() : '';
              },
              iconSize: 30.0,
              padding: const EdgeInsets.all(5),
              icon: Padding(
                padding: EdgeInsets.zero,
                child: isSelected == true
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromRGBO(105, 49, 142, 1)),
                        child:
                            const Icon(Icons.light_mode, color: Colors.white),
                      )
                    : Text(
                        "Light\nMode",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? const Color.fromRGBO(105, 49, 142, 1)
                              : Colors.white,
                        ),
                      ),
              ),
            ),
            isSelected == true
                ? Text(
                    'Dark\nMode',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? const Color.fromRGBO(105, 49, 142, 1)
                          : Colors.white,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                    child: IconButton(
                      onPressed: () {
                        onPressed();
                      },
                      iconSize: 30.0,
                      icon: Icon(
                        Icons.dark_mode,
                        color: isSelected
                            ? const Color.fromRGBO(105, 49, 142, 1)
                            : Colors.black,
                      ),
                    ),
                  ),
          ],
        ));
  }
}
