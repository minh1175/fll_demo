import 'dart:math';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const double _kDismissThreshold = 0.15;

class DismissibleWidget extends StatelessWidget {
  const DismissibleWidget({
    required this.child,
    required this.onDismissed,
    this.onDragStart,
    this.onDragEnd,
    this.onDragUpdate,
    this.dragSensitivity = 0.7,
    this.minScale = .85,
    this.behavior = HitTestBehavior.opaque,
    this.reverseDuration = const Duration(milliseconds: 200),
    Key? key,
  }) : super(key: key);

  final VoidCallback onDismissed;
  final VoidCallback? onDragStart;
  final VoidCallback? onDragEnd;
  final ValueChanged<double>? onDragUpdate;
  final double minScale;
  final Widget child;
  /// スワイプの感度設定設定
  final double dragSensitivity;
  final Duration reverseDuration;
  final HitTestBehavior behavior;

  @override
  Widget build(BuildContext context) {
    return SwipeDismissiblePage(
      onDismissed: onDismissed,
      dragSensitivity: dragSensitivity,
      minScale: minScale,
      onDragStart: onDragStart,
      onDragEnd: onDragEnd,
      onDragUpdate: onDragUpdate,
      reverseDuration: reverseDuration,
      behavior: behavior,
      child: child,
    );
  }
}
class SwipeDismissiblePage extends StatefulWidget {
  const SwipeDismissiblePage({
    required this.child,
    required this.onDismissed,
    required this.dragSensitivity,
    required this.minScale,
    required this.onDragStart,
    required this.onDragEnd,
    required this.onDragUpdate,
    required this.reverseDuration,
    required this.behavior,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onDragStart;
  final VoidCallback? onDragEnd;
  final VoidCallback onDismissed;
  final ValueChanged<double>? onDragUpdate;
  final double minScale;
  final Widget child;
  final double dragSensitivity;
  final Duration reverseDuration;
  final HitTestBehavior behavior;

  @protected
  MultiDragGestureRecognizer createRecognizer(GestureMultiDragStartCallback onStart) {
    return ImmediateMultiDragGestureRecognizer()..onStart = onStart;
  }

  @override
  _SwipeDismissiblePageState createState() =>
      _SwipeDismissiblePageState();
}

class _SwipeDismissiblePageState extends State<SwipeDismissiblePage> with Drag,SingleTickerProviderStateMixin {
  late final GestureRecognizer _recognizer;
  late final AnimationController _moveController;
  final _offsetNotifier = ValueNotifier(Offset.zero);
  Offset _startOffset = Offset.zero;
  int _activeCount = 0;
  bool _dragUnderway = false;
  // 回転率
  double rate = 0.0;
  Offset offSetBuf = Offset(0.0,0.0);

  @override
  void initState() {
    super.initState();
    _moveController =
        AnimationController(duration: widget.reverseDuration, vsync: this);
    _moveController.addStatusListener(statusListener);
    _moveController.addListener(animationListener);
    _recognizer = widget.createRecognizer(_startDrag);
  }
  void animationListener() {
    _offsetNotifier.value = Offset.lerp(
      _offsetNotifier.value,
      Offset.zero,
      Curves.easeInOut.transform(_moveController.value),
    )!;
    widget.onDragUpdate?.call(overallDrag());
  }

  void statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _moveController.value = 0;
    }
  }
  double overallDrag() {
    final size = MediaQuery.of(context).size;
    final distanceOffset = _offsetNotifier.value - Offset.zero;
    final w = distanceOffset.dx.abs() / size.width;
    final h = distanceOffset.dy.abs() / size.height;

    if (distanceOffset.dx > 0){
      // 右にスワイプ
      rate = w;
    } else if (distanceOffset.dx < 0) {
      // 左にスワイプ
      rate = -w;
    }
    return max(w, h);
  }

  /// ドラッグ開始
  Drag? _startDrag(Offset position) {
    if (_activeCount > 1) return null;
    _dragUnderway = true;
    final renderObject = context.findRenderObject()! as RenderBox;
    _startOffset = renderObject.globalToLocal(position);
    return this;
  }

  void _routePointer(PointerDownEvent event) {
    ++_activeCount;
    if (_activeCount > 1) return;
    _recognizer.addPointer(event);
  }

  @override
  void update(DragUpdateDetails details) {
    if (_activeCount > 1) return;
    Offset offSetTmp = details.globalPosition - _startOffset;
    if (offSetTmp.dx == 0){
      offSetBuf = offSetTmp;
    }
    _offsetNotifier.value = (details.globalPosition - _startOffset - offSetBuf) * widget.dragSensitivity;
  }

  @override
  void cancel() {
    _dragUnderway = false;
  }

  @override
  void end(DragEndDetails details) {
    if (!_dragUnderway) return;
    _dragUnderway = false;
    final shouldDismiss = overallDrag() > _kDismissThreshold;
    if (shouldDismiss) {
      widget.onDismissed();
    } else {
      _moveController.animateTo(1);
    }
  }

  void _disposeRecognizerIfInactive() {
    if (_activeCount > 0) return;
    _recognizer.dispose();
  }

  @override
  void dispose() {
    _disposeRecognizerIfInactive();
    _moveController.dispose();
    _offsetNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = ValueListenableBuilder<Offset>(
      valueListenable: _offsetNotifier,
      child: widget.child,
      builder: (_, Offset offset, Widget? child) {
        final k = overallDrag();
        final scale = lerpDouble(1, widget.minScale, k);
        return Container(
          color: Colors.transparent,
          child: AnimatedContainer(duration: Duration(seconds: 20),
            child: Transform(
              transform: Matrix4.rotationZ(rate)
                ..translate(offset.dx, offset.dy)
                ..scale(scale, scale),
              alignment: Alignment.center,
              child:ClipRRect(
                child: child,
              ),
            ),
          ),
        );
      },
    );

    return Listener(
      onPointerDown: _routePointer,
      onPointerUp: (_) => --_activeCount,
      behavior: widget.behavior,
      child: content,
    );
  }
}