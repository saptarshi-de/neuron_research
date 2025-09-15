#include <stdio.h>
#include "hocdec.h"
extern int nrnmpi_myid;
extern int nrn_nobanner_;
#if defined(__cplusplus)
extern "C" {
#endif

extern void _adapt_reg(void);
extern void _cal_reg(void);
extern void _KCa_reg(void);
extern void _VecStim_reg(void);

void modl_reg() {
  if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
    fprintf(stderr, "Additional mechanisms from files\n");
    fprintf(stderr, " \"adapt.mod\"");
    fprintf(stderr, " \"cal.mod\"");
    fprintf(stderr, " \"KCa.mod\"");
    fprintf(stderr, " \"VecStim.mod\"");
    fprintf(stderr, "\n");
  }
  _adapt_reg();
  _cal_reg();
  _KCa_reg();
  _VecStim_reg();
}

#if defined(__cplusplus)
}
#endif
