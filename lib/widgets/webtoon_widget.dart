import 'package:flutter/material.dart';
import 'package:toonflix/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    //GestureDetector: 행동을 감지할 수 있음
    //onTap은 클릭을 감지
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              //offset값을 0.0, 1.0으로 주면 수직 방향 슬라이딩
              //1.0, 0.0으로 주면 좌우 방향으로 슬라이딩 됨
              var begin = const Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;
              var tween = Tween(
                begin: begin,
                end: end,
              ).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder:
                (context, animation, secondaryAnimation) =>
                    DetailScreen(title: title, thumb: thumb, id: id),
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              width: 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: Offset(10, 10),
                    color: Colors.black.withValues(alpha: 0.3),
                  ),
                ],
              ),
              child: Image.network(thumb),
            ),
          ),
          SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 22)),
        ],
      ),
    );
  }
}
