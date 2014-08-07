
%ifndef MACRO_INC
 %define MACRO_INC

 %macro invoke 2-*
  %define _fonction_name %1
  %assign _nb_params (%0-1) * 4
  %rep %0-1
    %rotate -1
    push dword %1
  %endrep
  call _fonction_name
  add esp, _nb_params
 %endmacro

 %macro pushx 1-*
  %rep %0
    push %1
    %rotate 1
  %endrep
 %endmacro

 %macro popx 1-*
   %rep %0
     %rotate -1
     pop %1
   %endrep
 %endmacro

 %macro _var_ 1-*
  %assign _space (%0 * 4)
  sub	esp, _space
  %assign _space_cur 4
  %rep %0
    %xdefine %1 ebp - _space_cur
    %rotate 1
    %assign _space_cur _space_cur + 4
  %endrep
 %endmacro

 %macro proc 1-*
  %push context
  global %1
  %1:
  %assign _cur 8
  %rotate 1
  %rep %0-1
    %xdefine %1 ebp + _cur
    %assign _cur _cur + 4
    %rotate 1
  %endrep
  push	ebp
  mov	ebp, esp
 %endmacro

 %macro RET 0
  %ifctx context
    jmp	%$end_proc
  %else
    %error "RET sans 'proc' !"
  %endif
 %endmacro

 %macro endproc 0
  %$end_proc:
  .ENDPROC	nop
  mov	esp, ebp
  pop	ebp
  ret
  %ifctx context
    %pop
  %else
    %error 'fucking error'
  %endif
 %endmacro

 %macro entryproc 0
   proc main
 %endmacro

 %macro IF 3
  %push if
  %assign __curr 1
  cmp	%1, %3
  j%-2	%{$loc}__curr
 %endmacro

 %macro ELSEIF 3
  %ifctx if
   jmp %$end_if
   %{$loc}__curr:
   %assign __curr __curr+1
   cmp	%1, %3
   j%-2	%{$loc}__curr
  %else
   %error "T'as oublie un if !"
  %endif
 %endmacro

 %macro ELSE 0
  %ifctx if
    jmp %$end_if
  %{$loc}__curr:
  %assign __curr __curr+1
  %else
   %error "T'as oublie un if !"
  %endif
 %endmacro

 %macro ENDIF 0
  %ifctx if
    %{$loc}__curr:
    %$end_if:
    %pop
  %else
    %error "T'as oublie un if !"
  %endif
 %endmacro

 ; macro _check_ : .label value [condition]
 %macro _check_ 2-3
  %if %0 > 2
   cmp	 eax, %2
   j%+3	 %1
  %else
   cmp	 eax, %2
   je	 %1
  %endif
 %endmacro

 %macro WHILE 3
  %push while
  %$test_while:
  cmp	%1, %3
  j%-2	%$end_while
 %endmacro

 %macro END_WHILE 0
  %ifctx while
    jmp	%$test_while
    %$end_while:
    %pop
  %else
    %error "T'as oublie un while !"
  %endif
 %endmacro

 %define .endproc .ENDPROC

%endif
