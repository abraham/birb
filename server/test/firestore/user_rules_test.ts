import * as firebase from '@firebase/testing';
import { suite, test } from 'mocha-typescript';
import { UserTest as UserTest } from './user';
import * as uuid from 'uuid';

@suite
class User extends UserTest {
  @test
  async 'can create self'() {
    const uid = this.user().uid;
    const user = this.db({ uid }).collection('users').doc(uid);
    await firebase.assertSucceeds(user.set(this.validUser));
  }

  @test
  async 'can not create someone else'() {
    const user = this.db(this.user()).collection('users').doc(uuid.v4());
    await firebase.assertFails(user.set(this.validUser));
  }

  @test
  async 'can not create'() {
    const user = this.db().collection('users').doc(uuid.v4());
    await firebase.assertFails(user.set(this.validUser));
  }

  @test
  async 'can read self'() {
    const uid = this.user().uid;
    const user = this.db({ uid }).collection('users').doc(uid);
    await firebase.assertSucceeds(user.get());
  }

  @test
  async 'can not read someone else'() {
    const user = this.db(this.user()).collection('users').doc(uuid.v4());
    await firebase.assertFails(user.get());
  }

  @test
  async 'can not read'() {
    const user = this.db().collection('users').doc(uuid.v4());
    await firebase.assertFails(user.get());
  }
}

[
  'http://example.com/fake.png',
  'https:///example.com/fake.png',
  'https://',
  'https',
  'example.com/fake.png',
].forEach(value => {
  @suite(`UserField photoUrl with ${value}`) class UserField extends UserTest {
    @test
    async 'is not valid'() {
      const uid = this.user().uid;
      const user = this.db({ uid }).collection('users').doc(uid);
      await firebase.assertFails(user.set({
        ...this.validUser,
        ...{ photoUrl: value },
      }));
    }
  }
});

[
  'nickname',
  'fullName',
  'photoUrl',
].forEach(field => {
  [
    ' value ',
    '',
    null,
  ].forEach(value => {
    @suite(`UserField ${field} with ${value}`) class UserField extends UserTest {
      @test
      async 'is not valid'() {
        const uid = this.user().uid;
        const user = this.db({ uid }).collection('users').doc(uid);
        await firebase.assertFails(user.set({
          ...this.validUser,
          ...{ [field]: value },
        }));
      }
    }
  });
});
