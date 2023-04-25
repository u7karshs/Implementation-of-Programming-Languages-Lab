;-----------------------------------------------
; UTKARSH SRIVASTAVA (226201003)
; SET-B-Q3
; ASM code to replace non-printable character
; Execution instructions are in README 
;-----------------------------------------------
; 'test.txt' file's data are processed 
;  filename = test.txt
;  Directory same as '.asm' file
;  encode = UTF-8 (save as)
;
; 'End-Of-Line' and 'Enter', both are considered
;   to be non-printable
;-----------------------------------------------
							


global main				;Declared for linker lable entry point (gcc)
extern fopen			;Define file open function
extern fclose			;Define file close function
extern fgetc			;Define fgetc function to read character from file
extern fputc			;Define fputc function to write character from file
extern printf			;Define print function

segment .data			;Declaring initialized data or constants eg file name
	name db "test.txt",0	;Define byte file name as test.text
	mode db "r+",0		;Define mode as r+, to read and write
	fp dq 0			;file pointer to read
	fp1 dq 0			;file pointer to write
	fmt_out: dq "%c", 0	;Character type specifier to write character


segment .text			;section of the executable instructions
main:					;linker main function entry point
	push rbp			;Pushing extended base pointer

	lea rdi,[name]		;Loading effective address of file (test.txt)
	lea rsi,[mode]		;Load effective address of mode to operate
	call fopen			;Calling file open function 
	mov [fp],rax		;loading file pointer to [fp]

	lea rdi,[name]		;Loading effective address of file (test.txt)
	lea rsi,[mode]		;Load effective address of mode to operate
	call fopen			;Calling file open function 
	mov [fp1],rax		;loading file pointer to [fp]

more:	mov rdi,[fp]		;moving file pointer to rdi
	call fgetc			;reading first character 
	cmp eax,-1			;comparing with end of file i.e -1
	je done			;If equal jump to done
	cmp eax,32			;Now, comparing with 32 (demical equivalent of space)
	jle ps			;If less than or equal jump to ps
	cmp eax,126			;comparing with 126 (last considered printable character)
	jg ps				;If greater then jump to ps

pt:					;Declaring pt (lable)
	mov rdi,rax			;moving containt of rax to rdi (i.e read character)
	mov rsi,[fp1]		;moving write file pointer to rsi
	call fputc			;calling fpuctc to write to file
	mov rdi,fmt_out		;printing the character to console
	mov esi,eax			;moving eax to esi
	xor eax,eax			;fliping set bits of eax
	call printf			;calling print function
	jmp more			;Uncontdition Jump to more
	
ps:					;If the character in non-printable
	mov eax,'*'			;Replacing it with '*'
	jmp pt			;Uncontdition Jump to pt


done:					;call fclose final lable (done)
pop rbp				;Poping base pointer
ret					;Returning to kernel (sys_call)