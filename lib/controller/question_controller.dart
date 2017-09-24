import '../aqueduct_quiz.dart';

class QuestionController extends HTTPController {
  var questions = [
    "What is your name?",
    "What is your quest?",
    "What is your favorite color?",
    "What is the capital of Assyria?",
    "What is the airspeed velocity of an unladen swallow?"
  ];

  @httpGet
  Future<Response> getAllQuestions() async {
    return new Response.ok(questions);
  }

  @httpGet
  Future<Response> getQuestionAtIndex(@HTTPPath("index") int index) async {
    return (index < 0 || index >= questions.length)
      ? new Response.notFound()
      : new Response.ok(questions[index]);
  }
}