import '../aqueduct_quiz.dart';
import 'dart:math';

import '../model/question.dart';

class QuestionController extends HTTPController {
  @httpGet
  Future<Response> getAllQuestions() async {
    var questionQuery = new Query<Question>();
    var databaseQuestions = await questionQuery.fetch();

    return new Response.ok(databaseQuestions);
  }

  @httpGet
  Future<Response> getQuestionAtIndex(@HTTPPath("index") int index) async {
    var questionQuery = new Query<Question>()
      ..where.index = whereEqualTo(index);

    var question = await questionQuery.fetchOne();

    return question == null
        ? new Response.notFound()
        : new Response.ok(question);
  }

  @httpGet
  Future<Response> getRandomQuestion({@HTTPQuery("random") String random}) async {
    var questionQuery = new Query<Question>();
    var questions = await questionQuery.fetch();

    return (random != null && random == "true")
        ? new Response.ok(getRandomQuestionOfList(questions))
        : new Response.ok(questions);
  }

  Question getRandomQuestionOfList(questionList) {
    var randomIndex = new Random().nextInt(questionList.length);
    return questionList[randomIndex];
  }
}