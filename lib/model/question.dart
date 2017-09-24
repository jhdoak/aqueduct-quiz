import '../aqueduct_quiz.dart';

class Question extends ManagedObject<_Question> implements _Question {}

class _Question {
  @managedPrimaryKey
  int index;

  String description;
}