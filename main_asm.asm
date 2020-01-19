extern printf
extern scanf
extern input_array_func				;make input_array_func visible
extern output_array_func			;make output_array_func visible
extern output_original_array	;make output_original_array visible
extern sort_func							;make sort_array visible
global main_asm

;*************
segment .data
;*************
;define your data
title 								db 		"Welcome to Array Processing programmed by Dion Pieterse", 10, 0
thank_you_msg					db		"Thank you. This is the array:", 10, 0
sort_array_msg				db	10, 		"Next the array will sorted by pointers.", 10, 10, 0
after_sorting_msg			db		"The array after sorting by pointers is:", 10, 0
array_wo_sorting_msg	db	10,	"The array without sorting by pointers is still present:", 10, 0
single_print_fmt			db	"%lf", 10, 0
hex_fmt								db	"%016lx", 10, 0

;*************
segment .bss
;*************
;reserve data for later
align 16
num_value_array 	resb 800;array to hold values
pdata_array		resb 800;array of pointers
size_of_input_array resq 1

;*************
segment .text
;*************
main_asm:
	push	rbp
	mov	rbp, rsp

;backup all the registers (maybe main stored some values)
	push	rbx
	push	rcx
	push	rdx
	push	rsi
	push	rdi
	push	r8
	push 	r9
	push	r10
	push	r11
	push	r12
	push	r13
	push	r14
	push	r15
	pushf

;**************************
;*** start program code ***
;**************************

	mov	qword	rax, 0
	mov		rdi, title
	call		printf

	;call the input_array_func and pass it the array and size
	mov		rdi, num_value_array
	mov		rsi, 5
	call		input_array_func
	;place the return value from input_array_func in r15
	mov		r15, rax

	;create loop to transfer pointer value into pdata array
	mov	qword	r14, 0
	mov		r11, num_value_array

	transfer_pointer_data_loop:
	cmp		r14, r15
	jge		exit_pointer_data_loop
	mov		[pdata_array + 8*r14], r11
	add		qword r11, 8
	inc		r14
	jmp		transfer_pointer_data_loop
	exit_pointer_data_loop:

	;thank the user message
	mov	qword	rax, 0
	mov		rdi, thank_you_msg
	call		printf

	;call output function
	mov		rdi, pdata_array
	mov		rsi, r15
	call		output_array_func

	;display sort array message
	mov	qword	rax, 0
	mov		rdi, sort_array_msg
	call		printf

	;call sort function
	mov		rdi, pdata_array
	mov		rsi, r15
	call		sort_func

	;display after sorting message
	mov	qword	rax, 0
	mov		rdi, after_sorting_msg
	call		printf

	;call output function
	mov		rdi, pdata_array
	mov		rsi, r15
	call		output_array_func

	;array without sorting message
	mov	qword	rax, 0
	mov		rdi, array_wo_sorting_msg
	call		printf

	;call output_original_array function
	mov		rdi, num_value_array
	mov		rsi, r15
	call		output_original_array

	;send first value back to driver
	movsd		xmm0, [num_value_array]


;************************
;*** end program code ***
;************************
	popf
	pop		r15
	pop		r14
	pop		r13
	pop		r12
	pop		r11
	pop		r10
	pop		r9
	pop		r8
	pop		rdi
	pop		rsi
	pop		rdx
	pop		rcx
	pop		rbx
	pop		rbp
	ret
