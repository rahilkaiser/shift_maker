import * as functions
    from "firebase-functions";
import * as admin from "firebase-admin";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

export const helloWorld = functions.region("europe-west3").https.onRequest((request, response) => {
    functions.logger.info("Hello logs!", {structuredData: true});
    response.send("Hello from Firebase!");
});

admin.initializeApp();

export const createWorker = functions.region('europe-west3')
    .firestore.document('workers/{workerId}')
    .onCreate(async (snap, context) => {
        try {
            const data = snap.data();

            functions.logger.log("LOGGER TEST", data);

            const password = Math.random().toString(36).slice(-8);
            const userRecord = await admin.auth().createUser({
                email: data.email,
                password,
            });

            await admin.firestore().doc(`/users/${userRecord.uid}`).set({
                birthDate: data.birthDate,
                createdAt: data.createdAt,
                validUntil: data.validUntil,
                description: data.description,
                docs: data.docs,
                email: userRecord.email,
                forename: data.forename,
                manager: data.manager,
                maxWorkDays: data.maxWorkDays,
                phoneNumber: data.phoneNumber,
                preference: data.preference,
                profileImage: data.profileImage,
                role: data.role,
                surname: data.surname,
            });

            return 200;
        } catch (error) {
            if (error instanceof Error) {
                functions.logger.log("Received AUTH ERROR:", error);
                functions.logger.log("Error message:", error.message);
                functions.logger.log("Error stack trace:", error.stack);
            } else {
                functions.logger.log("Received an unknown error:", error);
            }

            throw new functions.https.HttpsError("unknown", "SuperError");
        }
    });