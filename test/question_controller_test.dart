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
      body: everyElement(endsWith("?")));
  });
}