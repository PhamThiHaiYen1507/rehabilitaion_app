import 'package:either_dart/either.dart';
import 'package:finplus/core/exceptions/api_exception.dart';

typedef ApiResponseData<T> = Either<ApiException<T>, T>;
