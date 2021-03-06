#ifndef _OW_CRYPT_H
#define _OW_CRYPT_H

#ifndef __GNUC__
#undef __const
#define __const const
#endif

#if __FreeBSD__
	#include <sys/param.h>
	#if __FreeBSD_version >= 1200000
		#define __SKIP_GNU
	#endif
#endif

#ifndef __SKIP_GNU
extern char *crypt(__const char *key, __const char *setting);
extern char *crypt_r(__const char *key, __const char *setting, void *data);
#endif

#ifndef __SKIP_OW
extern char *crypt_rn(__const char *key, __const char *setting,
	void *data, int size);
extern char *crypt_ra(__const char *key, __const char *setting,
	void **data, int *size);
extern char *crypt_gensalt(__const char *prefix, unsigned long count,
	__const char *input, int size);
extern char *crypt_gensalt_rn(__const char *prefix, unsigned long count,
	__const char *input, int size, char *output, int output_size);
extern char *crypt_gensalt_ra(__const char *prefix, unsigned long count,
	__const char *input, int size);
#endif

#endif
