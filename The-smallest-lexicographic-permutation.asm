.data

 v:.space 720
 f:.space 240
 n:.space 4
 m:.space 4
 nrel: .long 3
 str: .space 1001
 chDelim: .asciz " "
 formatPrintf: .asciz "%d "
 formatPrintfc: .asciz "%c"
 chsp: .asciz "\n"
 ok:.long 0
 ok1:.long 0
 i:.long 0
 k:.long 0
 a:.long 0
 
.text

.global main
# trebuie sa folosesc in procedura reg. %ebp
# lista reg. de restaurat: %ebx, %esi, %edi, %ebp, %esp

proc_afisare:
	pusha
	xor %ecx,%ecx	
et_forafisare:

	movl (%esi,%ecx,4 ),%eax
	pushl %ecx
	
	pushl %eax
	pushl $formatPrintf
    	call printf
    	popl %ebx
    	popl %ebx
    	
    	popl %ecx
    	incl %ecx
    	
    	cmp %ecx,nrel
    	je et_rett
    	
    	jmp et_forafisare
et_rett:
	popa
	ret
procedura:
	pusha
	cmp $0, ok
	jne et_proexit
	
	cmp %ecx, nrel
	je et_gata
	
	cmp $0, (%esi,%ecx,4)
	jne et_apel

	
et_else:
	movl $1,%eax
	
et_else1:
	
	cmp n,%eax
	ja et_proexit #nu stiu?
	
	cmp $3, (%edi,%eax,4)
	jne et_forj

	incl %eax
	jmp et_else1

et_forj:
	movl $1, ok1
	movl $1, %edx
et_forj2:
	cmp m,%edx
	jg et_ifok1
	
	#k-j  ecx-edx
	pushl %ecx
	subl %edx,%ecx  #ecx=cx-bx
	
	cmp $0, %ecx
	jae et_if1 # jbe
	
	popl %ecx
	incl %edx
	jmp et_forj2

et_if1:
	cmp (%esi,%ecx,4), %eax
	je et_if2
	
	popl %ecx
	jmp et_if3
et_if2:
	movl $0,ok1
	jmp et_ifok1pop
	
et_if3:
	#k-j  ecx+edx
	pushl %ecx
	addl %edx,%ecx  #ecx=cx+bx
	
	cmp  %ecx,nrel # modificare inv
	jae et_if4 # jle
	
	popl %ecx
	incl %edx
	
	jmp et_forj2

et_if4:
	cmp (%esi,%ecx,4), %eax
	je et_if5
	
	popl %ecx
	incl %edx
	jmp et_forj2
et_if5:
	movl $0,ok1
	jmp et_ifok1pop	
et_ifok1pop:
	popl %ecx
et_ifok1:

	cmp $0, ok1
	jne et_ok1
	
	incl %eax
	jmp et_else1

et_ok1:
	pushl %edx
	movl (%edi,%eax,4),%edx
	incl %edx
	movl %edx,(%edi,%eax,4)
	popl %edx
	movl %eax ,(%esi,%ecx,4)
	
	push %eax
	push %ecx
	#apel
	
	incl %ecx
	pushl %ecx
	call procedura
	popl %ebx
	
	#
	popl %ecx
	popl %eax
	
	pushl %edx
	movl (%edi,%eax,4),%edx
	decl %edx
	movl %edx,(%edi,%eax,4)
	popl %edx
	
	movl $0,(%esi,%ecx,4)
	
	incl %eax
	jmp et_else1
	
et_apel:
	incl %ecx
	
	pushl %ecx
	call procedura
	popl %ebx
	
	#la ret unde se intoarce?
	decl %ecx
	jmp et_proexit
	
et_gata:
	movl $1,ok
	call proc_afisare
	
et_proexit:
	popa
	ret

main:
    lea v,%esi
    lea f,%edi
	
    pushl $str
    call gets
    popl %ebx
    
    #n
    pushl $chDelim
    pushl $str
    call strtok 
    popl %ebx
    popl %ebx
    
    pushl %eax
    call atoi
    popl %ebx

    movl %eax,n
    
    mull nrel
    movl %eax, nrel
    
    #m
    pushl $chDelim
    pushl $0
    call strtok 
    popl %ebx
    popl %ebx
    
    pushl %eax
    call atoi
    popl %ebx

    movl %eax,m
    xor %ecx,%ecx
    
et_forcitire:
    #elemente vector

    cmp %ecx,nrel
    je et_proc
    
    pushl %ecx
    
    pushl $chDelim
    pushl $0
    call strtok
    popl %ebx
    popl %ebx
    
    pushl %eax
    call atoi
    popl %ebx
    
    popl %ecx
     
    movl %eax, (%esi,%ecx,4)
    
    incl %ecx
    
    incl (%edi,%eax,4) # elemente vector frecventa
    jmp et_forcitire

et_proc:
	xor %ecx,%ecx 
	pushl %ecx
	call procedura
	popl %ebx
	
	cmp $0,ok
	je et_minus1
	
	jmp et_exit
	

et_minus1:
    pushl $45
    pushl $formatPrintfc
    call printf
    popl %ebx
    popl %ebx
    
    pushl $1
    pushl $formatPrintf
    call printf
    popl %ebx
    popl %ebx
    
et_exit:
    pushl $0
    pushl $chsp
    call printf
    popl %ebx
    popl %ebx
    
    movl $1,%eax
    xorl %ebx,%ebx
    int $0x80
