import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:myTranslator/models/Quiz.dart';

class QuizPage extends StatefulWidget {
  final Quiz quiz;

  QuizPage({Key key, @required this.quiz}) : super(key: key);

  @override
  _QuizPageState createState() {
    return _QuizPageState();
  }
}

class _QuizPageState extends State<QuizPage> {
  Quiz _quiz;

  final _cardStackKey = GlobalKey<QuizCardStackState>();
  List<QuizCard> _questionCards;

  @override
  void initState() {
    super.initState();
    _quiz = widget.quiz;

    _questionCards = List.generate(widget.quiz.questions.length, (int index) {
      return QuizCard(question: widget.quiz.questions[index], index: index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz: ${_quiz.title}")),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
              flex: 3, child: QuizCardStack(_cardStackKey, _questionCards)),
          Expanded(
            child: Center(
              child: RaisedButton(
                child: Text("Next"),
//                onPressed: _hasAnswered == true ? () => _onNextClicked() : null,
                onPressed: () => _onNextClicked(),
                color: Colors.green,
                textColor: Colors.white,
              ),
            ),
            flex: 1,
          )
        ],
      )),
    );
  }

  void _onNextClicked() {
    //Go to next question
    _cardStackKey.currentState.animateToNextCard();
  }
}

class QuizCardStack extends StatefulWidget {
  final List<QuizCard> cards;
  final Function animationDoneCallback;

  QuizCardStack(Key key, this.cards, [this.animationDoneCallback]) : super(key: key);

  @override
  QuizCardStackState createState() {
    return QuizCardStackState();
  }
}

//TODO: LOOK AT https://medium.com/flutterpub/flutter-animation-basics-explained-with-stacked-cards-9d34108403b8 for animation
class QuizCardStackState extends State<QuizCardStack>
    with SingleTickerProviderStateMixin {
  List<QuizCard> _quizCards;

  AnimationController _controller;
  CurvedAnimation _curvedAnimation;
  Animation<Offset> _translateAnimation;
  int currentIndex;

  @override
  void initState() {
    super.initState();
    //TODO: SOmething is wrong with the currentIndex value
    currentIndex = 0;
    _quizCards = widget.cards;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _translateAnimation = Tween(begin: Offset(0, 0), end: Offset(-1000, 0))
        .animate(_curvedAnimation)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {

    var reversedList = _quizCards.reversed.toList();

    return Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: reversedList.map<Widget>((QuizCard card) {
          return Center(
              child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: Transform.translate(
                      offset: _getTranslateTransformationOffset(card),
                      child: card)));
        }).toList());
  }

  /// Translate the card to the left out of the screen
  Offset _getTranslateTransformationOffset(QuizCard card) {
    if (card.index == currentIndex) {
      return _translateAnimation.value;
    }

    return Offset(0, 0);
  }

  void animateToNextCard() {
    _controller.forward().whenComplete(() {
      setState(() {
        _controller.reset();
        QuizCard removedCard = _quizCards[0];
        _quizCards.remove(removedCard);
        if(_quizCards.isNotEmpty){
          currentIndex = _quizCards[0].index;
        }
        if (widget.animationDoneCallback != null) {
          widget.animationDoneCallback(_quizCards.isEmpty);
        }
      });
    });
  }
}

class QuizCard extends StatefulWidget {
  final QuizQuestion question;
  final int index;

  QuizCard({@required this.question, this.index});

  @override
  QuizCardState createState() {
    return QuizCardState();
  }
}

class QuizCardState extends State<QuizCard> {
  QuizQuestion _question;
  bool _hasAnswered;
  int _positionButtonClicked;

  @override
  void initState() {
    super.initState();
    _question = widget.question;
    _hasAnswered = false;
    _positionButtonClicked = -1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      _question.question,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: StaggeredGridView.countBuilder(
                    itemCount: _question.answers.length,
                    crossAxisCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimatedOpacity(
                          duration: Duration(milliseconds: 500),
                          opacity: _hasAnswered == true
                              //it's the question is answered, then only keep the right answer
                              //And where the user clicked
                              ? _question.answers[index].isRightAnswer == true
                                  ? 1
                                  : index == _positionButtonClicked ? 1 : 0
                              : 1,
                          child: RaisedButton(
                            child: Text(_question.answers[index].answer),
                            onPressed: () => _onAnswerClicked(index),
                            color: _hasAnswered
                                ? _question.answers[index].isRightAnswer == true
                                    ? Colors.green
                                    : index == _positionButtonClicked
                                        ? Colors.red
                                        : Colors.white30
                                : Colors.white30,
                          ));
                    },
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    staggeredTileBuilder: (int index) {
                      return StaggeredTile.count(1, 0.5);
                    },
                  ),
                  flex: 3,
                ),
                Expanded(
                  child: AnimatedOpacity(
                      opacity: _hasAnswered == true ? 1 : 0,
                      duration: Duration(milliseconds: 500),
                      child: Center(
                        child: Text(
                          _positionButtonClicked > -1 &&
                                  _question.answers[_positionButtonClicked]
                                          .isRightAnswer ==
                                      true
                              ? "Correct!!!"
                              : "Wrong answer",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )),
                  flex: 1,
                )
              ]),
            )));
  }

  void _onAnswerClicked(int position) {
    setState(() {
      _hasAnswered = true;
      _positionButtonClicked = position;
    });
  }
}
