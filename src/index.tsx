// Imports
import { NativeModules, Platform } from "react-native";
import { Buffer } from "buffer";


// Constants

// Linking error
const LINKING_ERROR = "The package '@nicolasflamel/ed25519-react' doesn't seem to be linked. Make sure: \n\n" + Platform.select({ ios: "- You have run 'pod install'\n", default: "" }) + "- You rebuilt the app after installing the package\n- You are not using Expo managed workflow\n";

// Ed25519 React
const Ed25519React = NativeModules.Ed25519React ? NativeModules.Ed25519React : new Proxy({}, {
	get() {
		throw new Error(LINKING_ERROR);
	}
});


// Classes

// Ed25519 class
export default class Ed25519 {

	// Operation failed
	public static readonly OPERATION_FAILED = null;

	// Public key from secret key
	static async publicKeyFromSecretKey(
		secretKey: Buffer
	): Promise<Buffer | null> {
	
		// Try
		try {
	
			// Return getting public key from secret key
			return Buffer.from(await Ed25519React.publicKeyFromSecretKey(secretKey.toString("hex")), "hex");
		}
		
		// Catch errors
		catch(
			error: any
		) {
		
			// Return operation failed
			return Ed25519.OPERATION_FAILED;
		}
	}
	
	// Sign
	static async sign(
		message: Buffer,
		secretKey: Buffer
	): Promise<Buffer | null> {
	
		// Try
		try {
	
			// Return signing message
			return Buffer.from(await Ed25519React.sign(message.toString("hex"), secretKey.toString("hex")), "hex");
		}
		
		// Catch errors
		catch(
			error: any
		) {
		
			// Return operation failed
			return Ed25519.OPERATION_FAILED;
		}
	}
	
	// Verify
	static async verify(
		message: Buffer,
		signature: Buffer,
		publicKey: Buffer
	): Promise<boolean | null> {
	
		// Try
		try {
	
			// Return if signature verified the message
			return await Ed25519React.verify(message.toString("hex"), signature.toString("hex"), publicKey.toString("hex"));
		}
		
		// Catch errors
		catch(
			error: any
		) {
		
			// Return operation failed
			return Ed25519.OPERATION_FAILED;
		}
	}
}
