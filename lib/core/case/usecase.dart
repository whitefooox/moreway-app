abstract class UseCase<Input, Output> {
  const UseCase();

  Output call(Input input);
}