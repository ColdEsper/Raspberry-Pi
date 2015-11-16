 .data
.balign 4
 message: .asciz "Type a number: "
.balign 4
 scan_format : .asciz "%d"
.balign 4
 message2: .asciz "Length of the Hailstone sequence for %d is %d\n"

.text
.balign 4
 .global main

 main:
 /* keep lr */
 push {ip,lr}
 ldr r0, =message
 /* first parameter of printf: &message */
 bl printf
 /* call printf */
 ldr r0, =scan_format
 /* first parameter of scanf: &scan_format */
 mov r1, sp
 /* second parameter of scanf:
 address of the top of the stack */
 bl scanf
 /* call scanf */
 ldr r0, [sp]
 /* first parameter of collatz:
 the value stored (by scanf) in the top of the stack */
 /* call collatz */
 bl collatz
 pop {ip,lr}
 bx lr
