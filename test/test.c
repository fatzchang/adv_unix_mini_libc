#include "libmini.h"

int main() {
	struct sigaction act, oldact;
	int rtn = sigaction(SIGABRT, &act, &oldact);
	rtn++;
	return 0;
}


// set env LD_LIBRARY_PATH=.
// file test/test