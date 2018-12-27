import * as firebase from '@firebase/testing';
import * as admin from 'firebase-admin';
import * as fs from 'fs';
import * as uuid from 'uuid';

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

  db(auth?: admin.auth.Auth) {
    return this.app(auth).firestore();
  }

  private app(auth?: admin.auth.Auth) {
    return firebase
      .initializeTestApp({
        projectId: this.projectId,
        auth
      });
  }
}
