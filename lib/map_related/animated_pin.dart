import 'package:flutter/cupertino.dart';

class AnimatedPin extends StatefulWidget {
  final Widget child;

  const AnimatedPin({Key? key,required this.child}) : super(key: key);
  @override
  _AnimatedPinState createState() => _AnimatedPinState();
}

class _AnimatedPinState extends State<AnimatedPin> with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller=AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat();
    super.initState();
  }
  @override
  void dispose() {
      _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return JumpingContainer(controller: _controller, child: widget.child);
  }
}
class JumpingContainer extends AnimatedWidget{
  final Widget child;
  AnimationController controller;
    JumpingContainer({Key? key, required this.controller,required this.child}) : super(key: key,listenable: controller);
    Animation<double> get _progress=>listenable as Animation<double>;


  @override
  Widget build(BuildContext context) {
    return Transform.translate(offset: Offset(0,-10+_progress.value * 10),child: child,);
  }

}
