import 'package:fpdart/fpdart.dart';
import 'package:personal_project/core/core.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
typedef FutureVoid = Future<void>;
