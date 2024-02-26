import 'package:buyer/viewmodel/auth_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  group('AuthViewModel Test', () {
    late AuthViewModel viewModel;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUserCredential mockUserCredential;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockUserCredential = MockUserCredential();
      viewModel = AuthViewModel();
      viewModel._auth = mockFirebaseAuth;
    });

    test('emailAndPassSignUp method should sign up a user', () async {
      final email = 'test@example.com';
      final password = 'test123';
      final userCredential = mockUserCredential;

      when(mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password))
          .thenAnswer((_) => Future.value(userCredential));

      await viewModel.emailAndPassSignUp();

      verify(mockFirebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).called(1);
    });
  });
}
