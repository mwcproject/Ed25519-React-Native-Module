// Header files
#include "./ed25519-react.h"

// Ed25519 namespace
namespace Ed25519 {

	// Header files
	#include "../Ed25519-NPM-Package-master/main.cpp"
}

using namespace std;


// Supporting function implementation

// Public key from secret key
vector<uint8_t> publicKeyFromSecretKey(const uint8_t *secretKey, size_t secretKeySize) {

	// Check if getting public key from secret key failed
	vector<uint8_t> publicKey(Ed25519::publicKeySize());
	if(!Ed25519::publicKeyFromSecretKey(publicKey.data(), secretKey, secretKeySize)) {
	
		// Throw error
		throw runtime_error("Getting public key from secret key failed");
	}
	
	// Return public key
	return publicKey;
}

// Sign
vector<uint8_t> sign(const uint8_t *message, size_t messageSize, const uint8_t *secretKey, size_t secretKeySize) {

	// Check if signing message failed
	vector<uint8_t> signature(Ed25519::signatureSize());
	if(!Ed25519::sign(signature.data(), message, messageSize, secretKey, secretKeySize)) {
	
		// Throw error
		throw runtime_error("Signing message failed");
	}
	
	// Return signature
	return signature;
}

// Verify
bool verify(const uint8_t *message, size_t messageSize, const uint8_t *signature, size_t signatureSize, const uint8_t *publicKey, size_t publicKeySize) {

	// Check if signature failed to verify
	if(!Ed25519::verify(message, messageSize, signature, signatureSize, publicKey, publicKeySize)) {
	
		// Return false
		return false;
	}
	
	// Return true
	return true;
}
