import 'package:flutter/material.dart';

class PizzaMarketTile extends StatelessWidget {
  const PizzaMarketTile({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            SizedBox(
              width: 320,
              height: constraints.maxHeight,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: constraints.maxHeight * .8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffdedede),
                ),
              ),
            ),
            Positioned.fill(
                bottom: 8,
                left: 16,
                right: 16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                      width: 250,
                      decoration: const BoxDecoration(color: Colors.purple),
                    )),
                    Expanded(
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(children: [
                              TextSpan(
                                  text: "Buono sconto Amazon 50€\n",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.black)),
                              TextSpan(
                                  text: "per il primo qualificato",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black)),
                            ]))),
                    const Text(
                        "nobitiis remolorem et Tur? Uga. Pis magnisit qui apit, et repelendia dita consecatur, quatem ea que mod ex.",
                        style: TextStyle(color: Colors.black))
                  ],
                ))
          ],
        );
      },
    );
  }
}
