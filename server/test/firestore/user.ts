import { FirestoreTest } from './firestore';

export class UserTest extends FirestoreTest {
  validUser = {
    nickname: 'Nick',
    fullName: 'Full',
    photoUrl: 'https://example.com/fake.png',
    agreedToTermsAt: this.now,
  };
}
