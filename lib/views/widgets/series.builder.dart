import 'package:flutter/material.dart';

enum SeriesType { column, row }

class SeriesBuilder extends StatelessWidget {
  final SeriesType type;
  final List<Widget>? children;
  final double gap;
  final bool isScrollable;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const SeriesBuilder({
    super.key,
    this.type = SeriesType.column,
    this.children,
    this.gap = 0.0,
    this.isScrollable = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  List<Widget> _generateChildren() {
    List<Widget> children = [];
    this.children?.forEach((element) {
      children.addAll([
        element,
        SizedBox(
          width: type == SeriesType.row ? gap : 0.0,
          height: type == SeriesType.column ? gap : 0.0,
        )
      ]);
    });
    return children;
  }

  Widget _buildColumn() {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: _generateChildren(),
    );
  }

  Widget _buildRow() {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: _generateChildren(),
    );
  }

  _buildListView(Widget child) {
    if (isScrollable) {
      return ListView(
        children: [child],
      );
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    return _buildListView(
        type == SeriesType.column ? _buildColumn() : _buildRow());
  }
}
