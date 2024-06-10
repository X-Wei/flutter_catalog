// 1. Import this:
import 'package:freezed_annotation/freezed_annotation.dart';

// 2. Declare this:
part 'my_api_state.freezed.dart';

// 3. Annotate the class with @freezed
@freezed
// 4. Declare the class as abstract and add `with _$ClassName`
abstract class MyApiState with _$MyApiState {
  // 5. Create a `const factory` constructor for each valid state
  factory MyApiState.success(List<String> data) = SuccessState;
  factory MyApiState.error(String errorMsg) = ErrorState;
  factory MyApiState.loading() = LoadingState;
}

// ! To run code generation:
// ! $ flutter pub run build_runner build --delete-conflicting-outputs
