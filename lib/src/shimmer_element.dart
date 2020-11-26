part of idkit_shimmer;

class ShimmerElement extends SingleChildRenderObjectWidget {
  const ShimmerElement(
    Widget child,
    this.durection,
    this.direction,
    this.gradient,
  ) : super(child: child);

  final double durection;
  final Direction direction;
  final Gradient gradient;

  @override
  ShimmerRenderObject createRenderObject(BuildContext context) {
    return ShimmerRenderObject(direction, gradient, durection);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant ShimmerRenderObject renderObject) {
    renderObject.direction = direction;
    renderObject.gradient = gradient;
    renderObject.duration = durection;
  }
}
