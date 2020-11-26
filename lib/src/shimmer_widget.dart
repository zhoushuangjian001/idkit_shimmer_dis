part of idkit_shimmer;

class IDKitShimmer extends StatefulWidget {
  /// Constructor.
  const IDKitShimmer({
    Key key,
    @required this.child,
    @required this.gradient,
    this.direction = Direction.ltr,
    this.duration = const Duration(milliseconds: 1500),
    this.loop = 0,
    this.enable = true,
  }) : super(key: key);

  /// Convenient constructor.
  IDKitShimmer.linearBuild({
    Key key,
    @required this.child,
    @required Color baseColor,
    @required Color highlightColor,
    this.direction = Direction.ltr,
    this.loop = 0,
    this.enable = true,
  })  : duration = const Duration(milliseconds: 1500),
        gradient = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          colors: [baseColor, baseColor, highlightColor, baseColor, baseColor],
          stops: [0.0, 0.35, 0.5, 0.65, 1.0],
        ),
        super(key: key);

  /// The [child] is content of IDKitShimmer.
  final Widget child;

  /// The [gradient] is controls of shimmer effect.
  final Gradient gradient;

  /// The [direction] is shimmer effect trend.
  final Direction direction;

  /// The [duration] is duration of shimmer effect.
  /// Default value is [ltf].
  final Duration duration;

  /// The [loop] is times of shimmer effect appear.
  /// Default value is [0], express infinite cycle.
  final int loop;

  /// The [enable] is shimmer effect available.
  /// Default value is [true].
  final bool enable;

  @override
  _IDKitShimmerState createState() => _IDKitShimmerState();

  /// Debug 模式参数配置
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Gradient>('gradient', gradient,
        defaultValue: null));
    properties.add(EnumProperty<Direction>('direction', direction));
    properties.add(DiagnosticsProperty<Duration>('duration', duration,
        defaultValue: null));
    properties
        .add(DiagnosticsProperty<bool>('enable', enable, defaultValue: null));
  }
}

class _IDKitShimmerState extends State<IDKitShimmer>
    with SingleTickerProviderStateMixin {
  // Control object of animation.
  AnimationController _animationController;
  // Cycle number record object.
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: widget.duration, vsync: this);
    _animationController.addStatusListener((status) {
      if (status != AnimationStatus.completed) {
        return;
      }

      if (widget.loop <= 0) {
        _animationController.repeat();
      } else if (_count < widget.loop) {
        _count++;
        _animationController.forward();
      }
    });
    if (widget.enable) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant IDKitShimmer oldWidget) {
    if (widget.enable) {
      _animationController.forward();
    } else {
      _animationController.stop();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: widget.child,
      builder: (context, child) => ShimmerElement(
        child,
        _animationController.value,
        widget.direction,
        widget.gradient,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

/// Direction of shimmer effect.
enum Direction {
  /// From left to right.
  ltr,

  /// From right to left.
  rtl,

  /// From top to bottom.
  ttb,

  /// From left to right.
  btt,
}
