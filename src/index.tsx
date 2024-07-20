// Imports
import { NativeModules, Platform } from "react-native";
import { Buffer } from "buffer";


// Check if Ed25519 React module doesn't exist
if(!NativeModules.Ed25519React) {

	// Throw error
	throw new Error("The package '@mwcproject/ed25519-react' doesn't seem to be linked. Make sure: \n\n" + Platform.select({
		ios: "- You have run 'pod install'\n",
		default: ""
	}) + "- You rebuilt the app after installing the package\n- You are not using Expo managed workflow\n");
}


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
	
			// Return getting public key from secret key with Ed25519 React module
			return Buffer.from(await NativeModules.Ed25519React.publicKeyFromSecretKey(secretKey.toString("hex")), "hex");
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
	
			// Return signing message with Ed25519 React module
			return Buffer.from(await NativeModules.Ed25519React.sign(message.toString("hex"), secretKey.toString("hex")), "hex");
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
	
			// Return if signature verified the message with Ed25519 React module
			return await NativeModules.Ed25519React.verify(message.toString("hex"), signature.toString("hex"), publicKey.toString("hex"));
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
