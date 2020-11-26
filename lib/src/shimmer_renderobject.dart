part of idkit_shimmer;

/// Render objects.
class ShimmerRenderObject extends RenderProxyBox {
  Direction _direction;
  Gradient _gradient;
  double _durection;
  // Constructor method.
  ShimmerRenderObject(this._direction, this._gradient, this._durection);

  // Gets the current layer of ShimmerRenderObject.
  @override
  ShaderMaskLayer get layer => super.layer;

  // Whether the layer is mixed.
  @override
  bool get alwaysNeedsCompositing => child != null;

  /// Set a new direction of shimmer effect.
  set direction(Direction newValue) {
    if (newValue == _direction) return;
    _direction = newValue;
    markNeedsLayout();
  }

  /// Set up new color control.
  set gradient(Gradient newValue) {
    if (newValue == _gradient) return;
    _gradient = newValue;
    markNeedsLayout();
  }

  /// Set new cycle time.
  set duration(double newValue) {
    if (newValue == _durection) return;
    _durection = newValue;
    markNeedsLayout();
  }

  /// Drawing new content.
  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      // 是否有一个合层图层
      assert(needsCompositing);
      final double width = child.size.width;
      final double height = child.size.height;
      Rect rect;
      double dx, dy;
      // Calculate the size of the layer of shimmer effecr.
      if (_direction == Direction.ltr) {
        dx = -width + 2 * width * _durection - width;
        dy = 0;
        rect = Rect.fromLTWH(dx, dy, 3 * width, height);
      } else if (_direction == Direction.rtl) {
        dx = -2 * width * _durection;
        dy = 0;
        rect = Rect.fromLTWH(dx, dy, 3 * width, height);
      } else if (_direction == Direction.ttb) {
        dx = 0;
        dy = -height + 2 * height * _durection - height;
        rect = Rect.fromLTWH(dx, dy, width, 3 * height);
      } else {
        dx = 0;
        dy = -2 * height * _durection;
        rect = Rect.fromLTWH(dx, dy, width, 3 * height);
      }

      /// 遮罩层的创建
      layer ??= ShaderMaskLayer();
      // 设置应用于对象上的着色器
      layer.shader = _gradient.createShader(rect);
      // 设置遮罩层的大小
      layer.maskRect = offset & size;
      // 将着色器和子对象混合时的模式
      // srcIn:显示原图像，并显示遮罩层和图像重合的位置。
      layer.blendMode = BlendMode.srcIn;
      // 将遮盖层加入Layer中
      context.pushLayer(layer, super.paint, offset);
    } else {
      layer = null;
    }
  }
}
