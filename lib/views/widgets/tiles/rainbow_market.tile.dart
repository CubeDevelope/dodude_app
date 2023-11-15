import 'package:app/utils/constants.dart';
import 'package:app/views/widgets/doduce_button.dart';
import 'package:flutter/material.dart';

class RainbowMarketTile extends StatelessWidget {
  const RainbowMarketTile({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            SizedBox(
              height: constraints.maxHeight,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: constraints.maxHeight * .8,
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffdedede),
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            Positioned.fill(
                bottom: 8,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    Container(
                      width: constraints.maxWidth * .8,
                      height: 110,
                      decoration: const BoxDecoration(color: Colors.purple),
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Iphone 14 Red",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Text(
                                "Fulintessina, et, ina, octurbis mum nica ti,Ublii pul vis, C. Ublicae morebusuni.",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Ottenibile con:",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              DodudeButton(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                title: "1000",
                                icon: AppIcons.pizza,
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                    const Text("Richiedi ora", style: TextStyle(
                      color: Colors.black
                    ),)
                  ],
                ))
          ],
        );
      },
    );
  }
}
