import * as firebase from '@firebase/testing';
import * as fs from 'fs';
import * as uuid from 'uuid';

interface TestAuth {
  uid: string;
}

export class FirestoreTest {
  projectId = `firestore-emulator-example-${uuid.v4()}`;

  static rules = fs.readFileSync('firestore.rules', 'utf8');

  async before() {
    await firebase.loadFirestoreRules({
      projectId: this.projectId,
      rules: FirestoreTest.rules,
    });
  }

  async after() {
    await Promise.all(firebase.apps().map(app => app.delete()));
  }

  user(): TestAuth {
    return {
      uid: uuid.v4(),
    };
  }

  db(auth?: TestAuth) {
    return this.app(auth).firestore();
  }

  get now() {
    return firebase.firestore.FieldValue.serverTimestamp();
  }

  private app(auth?: TestAuth) {
    return firebase
      .initializeTestApp({
        projectId: this.projectId,
        auth
      });
  }
}
