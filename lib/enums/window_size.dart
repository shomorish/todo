enum WindowSizeType {
  compact(599),
  medium(839),
  expanded(double.maxFinite);

  final double _maxWidth;

  const WindowSizeType(this._maxWidth);

  static WindowSizeType fromWidth(double width) {
    if (width <= compact._maxWidth) {
      return compact;
    } else if (width <= medium._maxWidth) {
      return medium;
    } else {
      return expanded;
    }
  }

  bool operator <(WindowSizeType other) => _maxWidth < other._maxWidth;
  bool operator <=(WindowSizeType other) =>
      this == other || _maxWidth < other._maxWidth;

  bool operator >(WindowSizeType other) => _maxWidth > other._maxWidth;
  bool operator >=(WindowSizeType other) =>
      this == other || _maxWidth > other._maxWidth;
}
