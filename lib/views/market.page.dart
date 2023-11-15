import 'package:app/utils/constants.dart';
import 'package:app/views/widgets/tiles/pizza_market.tile.dart';
import 'package:app/views/widgets/tiles/rainbow_market.tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  int page = 0;

  Widget _buildPage() {
    if (page == 0) {
      return ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: const [
          PizzaMarketTile(),
          PizzaMarketTile(),
          PizzaMarketTile(),
          PizzaMarketTile(),
        ].expand((element) => [element, SizedBox(width: 16,)]).toList(),
      );
    }
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: .6,
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: const [
        RainbowMarketTile(),
        RainbowMarketTile(),
        RainbowMarketTile(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    setState(() {
                      page = 0;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    height: 50,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: page == 0 ? Colors.white10 : Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                    child: SvgPicture.asset(
                      AppIcons.pizza.toAssetPath,
                      width: 24,
                      height: 24,
                    ),
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    setState(() {
                      page = 1;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    height: 50,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: page == 1 ? Colors.white10 : Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                    child: SvgPicture.asset(
                      AppIcons.rainbow.toAssetPath,
                      width: 24,
                      height: 24,
                    ),
                  ),
                )),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "punti karma".toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    "Berem popublis nes inatui et, quost factudem sentium de forterunum hiliceps,Catustus? quium det? Iferfin\n",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    "IL TUO PUNTEGGIO: 50 punti karma!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: _buildPage(),
            )
          ],
        ),
      ),
    );
  }
}
