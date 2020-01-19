extern printf
extern scanf
global output_array_func

;*************
segment .data
;*************
;define your data
title 						db "Running output array function...", 10, 0
output_heading		db	"Index      Physical Address       Decimal Value", 10, 0
print_fmt					db	"  %d        %016lx         %lf", 10, 0
print_dble				db "%lf", 10, 0


;*************
segment .bss
;*************
;reserve data for later
align 16
num_array resb 800
;*************
segment .text
;*************
output_array_func:
	push	rbp
	mov		rbp, rsp

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

;receive parameter values passed into function
mov			r8,  rdi				;for raw address of array
mov			r13, rdi				;collect array start address
mov			r15, rsi				;collect size of array

mov	qword	rax, 0
mov			rdi, output_heading
push r8
push r8
call		printf
pop r8
pop r8

mov	qword	r14, 0					;zero out loop counter
mov	qword	r12, 0					; initialize index count


print_loop:
cmp		r14, r15
jge		exit_print
mov	qword	rax, 1
mov		rdi, print_fmt
mov		rsi, r12						;index count
mov		rdx, [r8]						;display raw physical address
mov		r11, [r13 + r14*8]	;deref ptr val once, give me ptr to val in r12
movsd		xmm0, [r11]				;deref ptr again to get actual val stored.
push r8										;the push 8 is needed twice to align with 16 bytes and avoid corruption from printf in GPR r8
	push r8									;the push 8 is needed twice to align with 16 bytes and avoid corruption from printf in GPR r8
	call		printf
	pop r8									;the push 8 is needed twice to align with 16 bytes and avoid corruption from printf in GPR r8
	pop r8									;the push 8 is needed twice to align with 16 bytes and avoid corruption from printf in GPR r8
	inc			r12							;increment index count
	;move to next value
	add			qword r8, 8
	inc			r14							;increment loop count
	jmp			print_loop
	exit_print:


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
