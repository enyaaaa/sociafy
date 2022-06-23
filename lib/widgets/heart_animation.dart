import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeartAnimation extends StatefulWidget {

  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;

  const HeartAnimation({Key? key,
    required this.child,
    required this.isAnimating,
    this.duration = const Duration(milliseconds: 150),
    this.onEnd,
  }) : super(key: key);

  @override
  State<HeartAnimation> createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation>
    with SingleTickerProviderStateMixin{

  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState(){
    super.initState();

    final halfDuration = widget.duration.inMilliseconds ~/ 2;
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: halfDuration)
    );

    scale = Tween<double>(begin:1, end:1.2).animate(controller);
  }

  @override
  void didUpdateWidget(HeartAnimation oldWidget){
    super.didUpdateWidget(oldWidget);

    if(widget.isAnimating != oldWidget.isAnimating){
      doAnimation();
    }
  }

  Future doAnimation() async{
    if (widget.isAnimating){
      await controller.forward();
      await controller.reverse();
      await Future.delayed(Duration(milliseconds: 400));

      if(widget.onEnd != null){
        widget.onEnd!();
      }
    }
  }

  @override
  void disposr(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
    scale: scale,
    child: widget.child,
  );
}
