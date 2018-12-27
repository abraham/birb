import * as firebase from '@firebase/testing';
import { suite, test } from 'mocha-typescript';
import { FirestoreTest } from './firestore';

@suite
class Users extends FirestoreTest {
  @test
  async 'can read'() {
    const user = this.db().collection('users').doc('alice');
    await firebase.assertSucceeds(user.get());
  }

  @test
  async 'can not write'() {
    const user = this.db().collection('users').doc('alice');
    await firebase.assertFails(user.set({ nickname: 'alice' }));
  }
}
