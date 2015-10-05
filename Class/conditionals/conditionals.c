#include<stdio.h>

int main () {
	int ifRet = 0;
	int caseRet = 0;
	int ifElseRet = 0;
	int day = 1;
	//monday
	if (day == 1) {
		ifRet = 11;
	}
	//tuesday
	if (day == 2) {
		ifRet = 5;
	}
	//wednesday
	if (day == 3) {
		ifRet = 11;
	}
	//thursday
	if (day == 4) {
		ifRet = 5;
	}
	//friday
	if (day == 5) {
		ifRet = 1;
	}

	if (day == 1) {
		ifElseRet = 11;
	} else if (day == 2) {
		ifElseRet = 5;
	} else if (day == 3) {
		ifElseRet = 11;
	} else if (day == 4) {
		ifElseRet = 5;
	} else if (day == 5) {
		ifElseRet = 1;
	}

	switch (day) {
	case 1:
		caseRet = 11;
		break;
	case 2:
		caseRet = 5;
		break;
	case 3:
		caseRet = 11;
		break;
	case 4:
		caseRet = 5;
		break;
	case 5:
		caseRet = 1;
		break;
	}

	printf("if val returned %d\n",ifRet);
	printf("if-else val returned %d\n",ifElseRet);
	printf("case val returned %d\n",caseRet);
	return 0;
}
