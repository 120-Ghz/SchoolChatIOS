#ifndef BCRYPT_H_
#define BCRYPT_H_
#define BCRYPT_HASHSIZE	(64)

#ifdef __cplusplus
extern "C" {
#endif

int bcrypt_gensalt(int workfactor, char salt[BCRYPT_HASHSIZE]);

int bcrypt_hashpw(const char *passwd, const char salt[BCRYPT_HASHSIZE],
		  char hash[BCRYPT_HASHSIZE]);

int bcrypt_checkpw(const char *passwd, const char hash[BCRYPT_HASHSIZE]);

#ifdef __cplusplus
}
#endif

#endif
