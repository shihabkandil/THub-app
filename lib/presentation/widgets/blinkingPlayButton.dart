import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlinkingPlayButton extends StatefulWidget {
  const BlinkingPlayButton({Key? key}) : super(key: key);

  @override
  State<BlinkingPlayButton> createState() => _BlinkingPlayButtonState();
}

class _BlinkingPlayButtonState extends State<BlinkingPlayButton> with TickerProviderStateMixin {

  late AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    lowerBound: 0.65,
    vsync: this,
  )..repeat(reverse:true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: UnconstrainedBox (
        alignment: Alignment.center,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            print(_controller.lowerBound);
            return FadeTransition(
              opacity: _controller,
                    child: Container(
                      width: 165/MediaQuery.of(context).devicePixelRatio,
                      height: 165/MediaQuery.of(context).devicePixelRatio,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child:IconButton(
                  alignment: Alignment.center,
                  icon: Icon(Icons.play_arrow,size: 40,),
                  color: Colors.white,
                  onPressed: null,
                ),
              )
            );
      }
    ),
    ),
    );
  }
}
