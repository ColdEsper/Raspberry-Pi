.data

.balign 4
message1: .asciz "Type a number: "
.balign 4
message2: .asciz "Read the number %d\n"

.balign 4
scan_pattern: .asciz "%d"

.balign 4
number_read: .word 0

.balign 4
return: .word 0

.text

.global main
main:
	ldr R1,address_of_return
	str LR, [R1]
	ldr R0, address_of_message1

	bl printf
	ldr R0, address_of_scan_pattern
	ldr R1, address_of_number_read
	bl scanf

	ldr R0, address_of_message2
	ldr R1, address_of_number_read
	ldr R1, [R1]
	bl printf

	ldr R0, address_of_number_read
	ldr R0, [R0]

	ldr LR, address_of_return
	ldr LR, [LR]
	bx LR
address_of_message1: .word message1
address_of_message2: .word message2
address_of_scan_pattern: .word scan_pattern
address_of_number_read: .word number_read
address_of_return: .word return

/* extern */
.global printf
.global scanf
