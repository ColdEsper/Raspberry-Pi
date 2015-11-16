/* -- collatz02.s */
 .text
.global collatz
 collatz:
 /* r0 contains the first argument */
 /* Only r0, r1 and r2 are modified,
 so we do not need to keep anything
 in the stack */
 /* Since we do not do any call, we do
 not have to keep lr either */
 mov r1, r0
 /* r1 ← r0 */
 mov r0, #0
 /* r0 ← 0 */
 collatz_loop:
 cmp r1, #1
 /* compare r1 and 1 */
 beq collatz_end
 /* if r1 == 1 branch to collatz_end */
 and r2, r1, #1
 /* r2 ← r1 & 1 */
 cmp r2, #0
 /* compare r2 and 0 */
 bne collatz_odd
 /* if r2 != 0 (this is r1 % 2 != 0) branch to collatz_odd */
 collatz_even:
 mov r1, r1, ASR #1
 /* r1 ← r1 >> 1. This is r1 ← r1/2 */
 b collatz_end_loop
 /* branch to collatz_end_loop */
 collatz_odd:
 add r1, r1, r1, LSL #1
 /* r1 ← r1 + (r1 << 1). This is r1 ← 3*r1 */
 add r1, r1, #1
 /* r1 ← r1 + 1. */
 collatz_end_loop:
 add r0, r0, #1
 /* r0 ← r0 + 1 */
 b collatz_loop
 /* branch back to collatz_loop */
 collatz_end:
 bx lr
