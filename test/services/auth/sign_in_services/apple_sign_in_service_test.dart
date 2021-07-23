import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasestarter/services/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class MockAppleCredentials extends Mock implements AppleCredentials {}

// ignore: must_be_immutable
class MockAuthorizationCredentialAppleID extends Mock
    implements AuthorizationCredentialAppleID {}

void main() {
  group('AppleSignInService', () {
    AppleCredentials mockAppleCredentials;
    AuthorizationCredentialAppleID mockAuthorizationCredential;

    AppleSignInService subject;

    setUp(() {
      mockAppleCredentials = MockAppleCredentials();
      mockAuthorizationCredential = MockAuthorizationCredentialAppleID();

      when(mockAuthorizationCredential.identityToken).thenReturn('idToken');

      subject = AppleSignInService(appleCredentials: mockAppleCredentials);
    });

    test('throwsAssertionError when appleCredentials is null', () {
      expect(
        () => AppleSignInService(appleCredentials: null),
        throwsAssertionError,
      );
    });

    group(
      '.getFirebaseCredential',
      () {
        test('completes when appleCredentials.getAppleCredentials succeeds',
            () {
          when(
            mockAppleCredentials.getAppleCredentials(
              scopes: [
                AppleIDAuthorizationScopes.email,
                AppleIDAuthorizationScopes.fullName,
              ],
              token: anyNamed('token'),
            ),
          ).thenAnswer((_) async => mockAuthorizationCredential);

          expect(subject.getFirebaseCredential(), completes);
        });

        test('fails when appleCredentials.getAppleCredentials throws', () {
          when(
            mockAppleCredentials.getAppleCredentials(
              scopes: [
                AppleIDAuthorizationScopes.email,
                AppleIDAuthorizationScopes.fullName,
              ],
              token: anyNamed('token'),
            ),
          ).thenThrow(Exception());

          expect(
            subject.getFirebaseCredential(),
            throwsA(isA<FirebaseAuthException>()),
          );
        });
      },
    );

    group('.signOut', () {
      test('completes', () {
        expect(subject.signOut(), completes);
      });
    });
  });
}
