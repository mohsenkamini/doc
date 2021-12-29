# EC Cryptography
## Private Key
### Generate a private ECDSA key
```bash
openssl ecparam -name prime521v1 -genkey -noout -out private.ec.key
```
### Convert and encrypt the private key with a pass phrase:
```bash
openssl pkcs8 -topk8 -in private.ec.key -out private.pem
```
You can now securely delete private.ec.key as long as you remember the pass phrase.

## Public Key
### Generate public ECDSA key
```bash
openssl ec -in private.pem -pubout -out public.pem
```
