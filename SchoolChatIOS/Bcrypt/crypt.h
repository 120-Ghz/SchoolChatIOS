#include <gnu-crypt.h>

#if defined(_OW_SOURCE) || defined(__USE_OW)
#define __SKIP_GNU
#undef __SKIP_OW
#include <ow-crypt.h>
#undef __SKIP_GNU
#endif
