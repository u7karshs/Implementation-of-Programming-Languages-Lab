;-------------------------------------
; NAME: UTKARSH SRIVASTAVA (226201003)
; SET-A-Q13
; ASM code to find GCD two numbers
; Execution instructions are in README 
;-------------------------------------
;gcd(a,b)
;	{ while(b !=0) {
;		temp = b;	
;		b=a%b;
;		a=temp; }	
;		return a;
;	}
;-------------------------------------
									;Data segment
segment .data							;Declaring initialized data or constants eg file name
	a: dq 2							;Declare variable a
	b: dq 2							;Declare variable b
	fmt_s: dq "Enter two numbers for GCD:",10,0	;String prompt for user i/p, 10 for newline
	fmt: dq "The GCD is: %lld",10,0			;String o/p with results
	fmt_in: dq "%lld", 0					;Type specifier to store Scanned i/p

segment .text							;section of the executable instructions							;
	global main							;Declared for linker lable entry point (gcc)
	extern printf						;Define print function
	extern scanf						;Define scan function

	main:								;linker main function entry point
	push RBP							;Pushing extended base pointer
	mov RAX , 0							;User prompt to enter two numbers
	mov RDI, fmt_s						;	by RAX=0 and RSI=RBX
	mov RSI, RBX						;	storing fmt_s in RDI
	call printf							;	printing to console

	mov RAX, 0							;Scanning first number
	mov RSI, a							;Storing in variable a (define Byte)
	mov RDI, fmt_in						;console o/p to read (%lld) type specifier
	call scanf							;Reading from user (console)

	mov RAX, 0							;Scanning Second number
	mov RSI, b							;storing in variable b (define Byte)
	mov RDI, fmt_in						;Scannig (%lld) type specifier
	call scanf							;Reading from user (console)

	mov RAX , 0							;Initializing rax=0
	mov RBX, 0							;Initializing rbx=0
	mov RAX, [a]						;Storing containt [a] memory i.e rax=a
	mov RBX, [b]						;Storing containt [b] memory i.e rbx=b

	WHILE:							;Iteration (while loop) to calculate GCD
		mov RDX, 0						;Initializing rdx to zero
		idiv RBX						;Division between two signed numbers (RAX / RBX)
		cmp RDX, 0						;RDX store remainder(RAX % RBX), comparing with zero
		jz LAST						;Jump at Zero to LAST lable
		mov RAX, RBX					;Divisor (RBX) store in RAX
		mov RBX, RDX					;Remainder (RDX) stored in RBX
		jmp WHILE						;Uncontdition Jump to WHILE

	LAST:								;LAST (lable)
		mov RAX , 0						;Console o/p Printing 'The GCD is:'
		mov RDI, fmt					;	by RAX=0 and RSI=RBX
		mov RSI, RBX					;	storing fmt_s in RDI
		call printf						;	printing to console [a]
	
	mov RAX, 0							;Initializing rax=0
	pop RBP							;Poping base pointer
	ret								;Returning to kernel (sys_call)