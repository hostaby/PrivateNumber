
#if !defined (__VG_OCLENGINE_H__)
#define __VG_OCLENGINE_H__

#include "pattern.h"

typedef struct _vg_ocl_context_s vg_ocl_context_t;

extern vg_ocl_context_t *vg_ocl_context_new(
	vg_context_t *vcp, int platformidx, int deviceidx,
	int safe_mode, int verify,
	int worksize, int nthreads, int nrows, int ncols,
	int invsize);
extern void vg_ocl_context_free(vg_ocl_context_t *vocp);

extern vg_ocl_context_t *vg_ocl_context_new_from_devstr(
	vg_context_t *vcp, const char *devstr, int safemode, int verify)
;

extern void vg_ocl_enumerate_devices(void);

#endif /* !defined (__VG_OCLENGINE_H__) */
