// Package
package com.ed25519react;


// Imports
import androidx.annotation.NonNull;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;


// Classes

// Ed25519 React module class
@ReactModule(name = Ed25519ReactModule.NAME)
public class Ed25519ReactModule extends ReactContextBaseJavaModule {

	// Name
	public static final String NAME = "Ed25519React";
	
	// Static
	static {
	
		// Try
		try {
		
			// Load library
			System.loadLibrary("cpp");
		}
		
		// Catch errors
		catch(Exception error) {
		
		}
	}

	// Constructor
	public Ed25519ReactModule(ReactApplicationContext reactContext) {
	
		// Delegate constructor
		super(reactContext);
	}

	// Get name
	@Override
	@NonNull
	public String getName() {
	
		// Return name
		return NAME;
	}
	
	// Public key from secret key
	@ReactMethod
	public void publicKeyFromSecretKey(String secretKey, Promise promise) {

		// Try
		try {

			// Resolve promise to native public key from secret key
			promise.resolve(nativePublicKeyFromSecretKey(secretKey));
		}

		// Catch errors
		catch(Exception error) {

			// Reject promise
			promise.reject("Error", error);
		}
	}
	
	// Sign
	@ReactMethod
	public void sign(String message, String secretKey, Promise promise) {

		// Try
		try {

			// Resolve promise to native sign
			promise.resolve(nativeSign(message, secretKey));
		}

		// Catch errors
		catch(Exception error) {

			// Reject promise
			promise.reject("Error", error);
		}
	}
	
	// Verify
	@ReactMethod
	public void verify(String message, String signature, String publicKey, Promise promise) {

		// Try
		try {

			// Resolve promise to native verify
			promise.resolve(nativeVerify(message, signature, publicKey));
		}

		// Catch errors
		catch(Exception error) {

			// Reject promise
			promise.reject("Error", error);
		}
	}
	
	// Native public key from secret key prototype
	private static native String nativePublicKeyFromSecretKey(String secretKey);
	
	// Native sign
	private static native String nativeSign(String message, String secretKey);
	
	// Native verify
	private static native boolean nativeVerify(String message, String signature, String publicKey);
}
