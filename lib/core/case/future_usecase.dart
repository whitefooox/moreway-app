abstract class FutureUseCase<Input, Output> {
  const FutureUseCase();

  Future<Output> call(Input input);
}