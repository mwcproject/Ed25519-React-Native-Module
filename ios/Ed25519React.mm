// Header files
#import <Foundation/Foundation.h>
#import <iomanip>
#import <sstream>
#import "ed25519-react.h"
#import "./Ed25519React.h"

using namespace std;


// Constants

// Hex character length
static const size_t HEX_CHARACTER_LENGTH = (sizeof("FF") - sizeof('\0'));

// Bits in a byte
static const int BITS_IN_A_BYTE = 8;


// Function prototypes

// From hex string
static vector<uint8_t> fromHexString(const NSString *hexString);

// To hex string
static const NSString *toHexString(const vector<uint8_t> &input);

// Character to number
static uint8_t characterToNumber(char character);

// To bool
static const NSNumber *toBool(bool input);


// Implementations

// Ed25519 React implementation
@implementation Ed25519React

// Export module
RCT_EXPORT_MODULE()

// Public key from secret key
RCT_EXPORT_METHOD(publicKeyFromSecretKey:(nonnull NSString *)secretKey
	withResolver:(RCTPromiseResolveBlock)resolve
	withReject:(RCTPromiseRejectBlock)reject)
{

	// Try
	try {

		// Get data from secret key
		const vector<uint8_t> secretKeyData = fromHexString(secretKey);

		// Resolve getting public key from secret key
		resolve(toHexString(publicKeyFromSecretKey(secretKeyData.data(), secretKeyData.size())));
	}

	// Catch errors
	catch(const exception &error) {

		// Initialize message
		NSString *message;

		// Try
		try {

			// Set message to error's message
			message = [NSString stringWithUTF8String:error.what()];
		}

		// Catch errors
		catch(...) {

			// Set error to nothing
			message = nullptr;
		}

		// Reject error
		reject(@"Error", message ? message : @"", nil);
	}
}

// Sign
RCT_EXPORT_METHOD(sign:(nonnull NSString *)message
	withSecretKey:(nonnull NSString *)secretKey
	withResolver:(RCTPromiseResolveBlock)resolve
	withReject:(RCTPromiseRejectBlock)reject)
{

	// Try
	try {

		// Get data from message
		const vector<uint8_t> messageData = fromHexString(message);
		
		// Get data from secret key
		const vector<uint8_t> secretKeyData = fromHexString(secretKey);

		// Resolve signing message
		resolve(toHexString(sign(messageData.data(), messageData.size(), secretKeyData.data(), secretKeyData.size())));
	}

	// Catch errors
	catch(const exception &error) {

		// Initialize message
		NSString *message;

		// Try
		try {

			// Set message to error's message
			message = [NSString stringWithUTF8String:error.what()];
		}

		// Catch errors
		catch(...) {

			// Set error to nothing
			message = nullptr;
		}

		// Reject error
		reject(@"Error", message ? message : @"", nil);
	}
}

// Verify
RCT_EXPORT_METHOD(verify:(nonnull NSString *)message
	withSignature:(nonnull NSString *)signature
	withPublicKey:(nonnull NSString *)publicKey
	withResolver:(RCTPromiseResolveBlock)resolve
	withReject:(RCTPromiseRejectBlock)reject)
{

	// Try
	try {

		// Get data from message
		const vector<uint8_t> messageData = fromHexString(message);
		
		// Get data from signature
		const vector<uint8_t> signatureData = fromHexString(signature);
		
		// Get data from public key
		const vector<uint8_t> publicKeyData = fromHexString(publicKey);

		// Resolve if signature verified message
		resolve(toBool(verify(messageData.data(), messageData.size(), signatureData.data(), signatureData.size(), publicKeyData.data(), publicKeyData.size())));
	}

	// Catch errors
	catch(const exception &error) {

		// Initialize message
		NSString *message;

		// Try
		try {

			// Set message to error's message
			message = [NSString stringWithUTF8String:error.what()];
		}

		// Catch errors
		catch(...) {

			// Set error to nothing
			message = nullptr;
		}

		// Reject error
		reject(@"Error", message ? message : @"", nil);
	}
}

@end


// Supporting function implementation

// From hex string
vector<uint8_t> fromHexString(const NSString *hexString) {

	// Check if getting input from hex string failed
	const char *input = [hexString UTF8String];
	if(!input) {

		// Throw error
		throw runtime_error("Getting input from hex string failed");
	}

	// Get input length
	const size_t inputLength = strlen(input);

	// Check if input length is invalid
	if(inputLength % HEX_CHARACTER_LENGTH) {

		// Throw error
		throw runtime_error("Input length is invalid");
	}

	// Initialize result
	vector<uint8_t> result(inputLength / HEX_CHARACTER_LENGTH);

	// Go through all character pairs in the input
	for(size_t i = 0; i < inputLength; i += HEX_CHARACTER_LENGTH) {

		// Set value in result
		result[i / HEX_CHARACTER_LENGTH] = (characterToNumber(input[i]) << BITS_IN_A_BYTE / 2) | characterToNumber(input[i + 1]);
	}

	// Return result
	return result;
}

// To hex string
const NSString *toHexString(const vector<uint8_t> &input) {

	// Initialize result
	ostringstream result;

	// Configure result
	result << hex << setfill('0');

	// Go through all bytes in the input
	for(const uint8_t byte : input) {

		// Append byte to result
		result << setw(HEX_CHARACTER_LENGTH) << static_cast<unsigned>(byte);
	}

	// Check if getting result as a string failed
	const NSString *resultString = [NSString stringWithUTF8String:result.str().c_str()];
	if(!resultString) {

		// Throw error
		throw runtime_error("Getting result as a string failed");
	}

	// Return result string
	return resultString;
}

// Character to number
uint8_t characterToNumber(char character) {

	// Check character
	switch(character) {

		// Zero
		case '0':

			// Return number
			return 0;

		// One
		case '1':

			// Return number
			return 1;

		// Two
		case '2':

			// Return number
			return 2;

		// Three
		case '3':

			// Return number
			return 3;

		// Four
		case '4':

			// Return number
			return 4;

		// Five
		case '5':

			// Return number
			return 5;

		// Six
		case '6':

			// Return number
			return 6;

		// Seven
		case '7':

			// Return number
			return 7;

		// Eight
		case '8':

			// Return number
			return 8;

		// Nine
		case '9':

			// Return number
			return 9;

		// A
		case 'a':
		case 'A':

			// Return number
			return 10;

		// B
		case 'b':
		case 'B':

			// Return number
			return 11;

		// C
		case 'c':
		case 'C':

			// Return number
			return 12;

		// D
		case 'd':
		case 'D':

			// Return number
			return 13;

		// E
		case 'e':
		case 'E':

			// Return number
			return 14;

		// F
		case 'f':
		case 'F':

			// Return number
			return 15;

		// Default
		default:

			// Throw error
			throw runtime_error("Getting character as a number failed");
	}
}

// To bool
const NSNumber *toBool(bool input) {

	// Check if getting input as a bool failed
	const NSNumber *result = [NSNumber numberWithBool:input ? YES : NO];
	if(!result) {

		// Throw error
		throw runtime_error("Getting input as a bool failed");
	}

	// Return result
	return result;
}
