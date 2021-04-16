import 'package:flutter/material.dart';
import 'package:trim/widgets/default_button.dart';

class SubmitReviewScreen extends StatefulWidget {
  @override
  _SubmitReviewScreenState createState() => _SubmitReviewScreenState();
}

class _SubmitReviewScreenState extends State<SubmitReviewScreen> {
  final commentController = TextEditingController();
  int stars = 5;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildImage(width, height),
                  _buildText(),
                  _buildStars(),
                  _buildcommentField(),
                  _buildButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Text('Please tell us your review for enhance the service.',
          style: Theme.of(context).textTheme.headline5),
    );
  }

  Widget _buildImage(double width, double height) {
    return Image.asset(
      'assets/icons/online-review.png',
      width: width / 1.5,
      height: height / 4,
      fit: BoxFit.fill,
    );
  }

  Widget _buildStars() {
    int negativeRate = 5 - stars;
    double size = 35;
    List<Widget> rate = List.generate(
      stars,
      (index) => IconButton(
        icon: Icon(
          Icons.star_rate_rounded,
          color: Colors.yellow[800],
          size: size,
        ),
        onPressed: () {
          setState(() {
            stars = index + 1;
          });
        },
      ),
    );

    rate.addAll(
      List.generate(
        negativeRate,
        (index) => IconButton(
          icon: Icon(Icons.star_outline, size: size, color: Colors.yellow[800]),
          onPressed: () {
            setState(() {
              stars = stars + index + 1;
            });
          },
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: rate,
    );
  }

  Widget _buildcommentField() {
    return Container(
      margin: const EdgeInsets.all(14),
      child: TextField(
        style: Theme.of(context).textTheme.headline6,
        maxLines: 4,
        controller: commentController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: 'Write your comment',
          contentPadding: const EdgeInsets.all(15.0),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: _button('Submit review', Colors.blue, () {
              print(stars);
            }),
          ),
          SizedBox(width: 10),
          Expanded(child: _button('Not now', Colors.black, () {}))
        ],
      ),
    );
  }

  Widget _button(String text, Color color, [Function onPressed]) {
    return ElevatedButton(
      onPressed: onPressed,
      child: FittedBox(child: Text(text)),
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(10).copyWith(left: 20, right: 20),
      ),
    );
  }
}
