import 'harness/app.dart';
import 'package:aqueduct_quiz/model/question.dart';

Future main() async {
  TestApplication app = new TestApplication();

  setUpAll(() async {
    await app.start();

    var questions = [
      new Question()
        ..description = "What is your name?",
      new Question()
        ..description = "What is your quest?",
      new Question()
        ..description = "What is your favorite color?",
      new Question()
        ..description = "What is the capital of Assyria?",
      new Question()
        ..description = "What is the airspeed velocity of an unladen swallow?",
    ];

    await Future.forEach(questions, (q) {
      var query = new Query<Question>()
          ..values = q;
      return query.insert();
    });
  });

  tearDownAll(() async {
    await app.stop();
  });

  test("/questions returns list of questions", () async {
    var request = app.client.request("/questions");

    expectResponse(
      await request.get(),
      200,
      body: allOf([
        hasLength(greaterThan(0)),
        everyElement(containsPair("description", endsWith("?")))
      ]));
  });

  test("/questions/index returns a single question", () async {
    var request = app.client.request("/questions/1");

    expectResponse(
      await request.get(),
      200,
      body: allOf([
        hasLength(greaterThan(0)),
        containsPair("description", endsWith("?"))
      ]));
  });

  test("/questions/index out of range returns 404", () async {
    var request = app.client.request("/questions/100");

    expectResponse(
      await request.get(),
      404);
  });

  test("/questions?random=true returns a single question", () async {
    var request = app.client.request("/questions?random=true");

    expectResponse(
      await request.get(),
      200,
      body: allOf([
        hasLength(greaterThan(0)),
        containsPair("description", endsWith("?"))
      ]));
  });

  test("/questions?random=false returns list of questions", () async {
    var request = app.client.request("/questions?random=false");

    expectResponse(
        await request.get(),
        200,
        body: allOf([
          hasLength(greaterThan(0)),
          everyElement(containsPair("description", endsWith("?")))
        ]));
  });

}