// Header guard
#ifndef ED25519_REACT_H
#define ED25519_REACT_H


// Header files
#include <vector>

using namespace std;


// Function prototypes

// Public key from secret key
vector<uint8_t> publicKeyFromSecretKey(const uint8_t *secretKey, size_t secretKeySize);

// Sign
vector<uint8_t> sign(const uint8_t *message, size_t messageSize, const uint8_t *secretKey, size_t secretKeySize);

// Verify
bool verify(const uint8_t *message, size_t messageSize, const uint8_t *signature, size_t signatureSize, const uint8_t *publicKey, size_t publicKeySize);


#endif
