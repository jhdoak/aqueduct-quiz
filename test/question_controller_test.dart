import 'harness/app.dart';

Future main() async {
  TestApplication app = new TestApplication();

  setUpAll(() async {
    await app.start();
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
        everyElement(endsWith("?"))
      ]));
  });

  test("/questions/index returns a single question", () async {
    var request = app.client.request("/questions/1");

    expectResponse(
      await request.get(),
      200,
      body: allOf([
        hasLength(greaterThan(0)),
        endsWith("?")
      ]));
  });

  test("/questions/index out of range returns 404", () async {
    var request = app.client.request("/questions/100");

    expectResponse(
      await request.get(),
      404);
  });

}