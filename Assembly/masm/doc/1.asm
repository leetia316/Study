assume cs:code,ds:data,ss:stack

data segment

	     db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
	     db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
	     db '1993','1994','1995'
	;以上是表示21年的21个字符串 year

	     dd 16,22,382,1356,2390,8000,16000,24486,50065,9749,14047,19751
	     dd 34598,59082,80353,11830,18430,27590,37530,46490,59370
	;以上是表示21年公司总收入的21个dword数据	sum

	     dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
	     dw 1154,1443,1525,1780

data ends

table segment

	;0123456789ABCDEF
	      db 21 dup ('year summ ne ?? ')
		
table ends

stack segment stack
	      db 128 dup (0)
stack ends

code segment

	start:       mov  ax,stack
	             mov  ss,ax
	             mov  sp,128

	             call set_table

	             call clear_screen

	             call show_table

	             mov  ax,4C00H
	             int  21H

	;============
	show_table:  mov  bx, table
	             mov  ds, bx
	             mov  si, 0

	             mov  bx, 0B800H
	             mov  es, bx
	             mov  di, 160*3

	             mov  cx, 21

	showTable:   call show_year
	             call show_summ
	             call show_ne
	             call show_average

	             add  di, 160
	             add  si, 16
	             loop showTable

	             ret

	;============
	show_average:push ax
	             push bx
	             push cx
	             push dx
	             push ds
	             push es
	             push si
	             push di

	             mov  ax, ds:[si+13]
	             mov  dx, 0

	             add  di, 40*2
	             call short_div

	             pop  di
	             pop  si
	             pop  es
	             pop  ds
	             pop  dx
	             pop  cx
	             pop  bx
	             pop  ax
	             ret

	;============
	show_ne:     push ax
	             push bx
	             push cx
	             push dx
	             push ds
	             push es
	             push si
	             push di

	             mov  ax, ds:[si+10]
	             mov  dx, 0

	             add  di, 30*2
	             call short_div

	             pop  di
	             pop  si
	             pop  es
	             pop  ds
	             pop  dx
	             pop  cx
	             pop  bx
	             pop  ax
	             ret
	;============
	show_summ:   push ax
	             push bx
	             push cx
	             push dx
	             push ds
	             push es
	             push si
	             push di

	             mov  ax, ds:[si+5]
	             mov  dx, ds:[si+7]

	             add  di, 20*2
	             call short_div

	             pop  di
	             pop  si
	             pop  es
	             pop  ds
	             pop  dx
	             pop  cx
	             pop  bx
	             pop  ax
	             ret

	;============
	short_div:   mov  cx, 10
	             div  cx
	             add  dl, 30H
	             mov  es:[di], dl
	             mov  cx, ax
	             jcxz shortDivRet
	             mov  dx, 0
	             sub  di, 2
	             jmp  short_div

	shortDivRet: ret
	;============
	show_year:   push ax
	             push cx
	             push ds
	             push es
	             push si
	             push di

	             mov  cx, 4
	             add  di, 3*2

	showYear:    mov  al, ds:[si]
	             mov  es:[di], al
	             add  di, 2
	             inc  si
	             loop showYear

	             pop  di
	             pop  si
	             pop  es
	             pop  ds
	             pop  cx
	             pop  ax
	             ret
	;============
	clear_screen:mov  bx, 0B800H
	             mov  es, bx

	             mov  bx, 0
	             mov  dx, 0700H
	             mov  cx, 2000

	clearScreen: mov  es:[bx], dx
	             add  bx, 2
	             loop clearScreen

	             ret
	;============
	set_table:   mov  bx, data
	             mov  ds, bx
	             mov  si, 0

	             mov  bx, table
	             mov  es, bx
	             mov  di, 0

	             mov  bx, 21*4*2

	             mov  cx, 21


	setTable:    call input_table
	             add  si, 4
	             add  bx, 2
	             add  di, 16
	             loop setTable
            
	             ret

	;============
	input_table: push ds:[si+0]
	             pop  es:[di+0]
	             push ds:[si+2]
	             pop  es:[di+2]

	             mov  ax, ds:[si+21*4+0]
	             mov  dx, ds:[si+21*4+2]

	             mov  es:[di+5], ax
	             mov  es:[di+7], dx

	             push ds:[bx]
	             pop  es:[di+10]

	             div  word ptr ds:[bx]

	             mov  es:[di+13], ax

	             ret
code ends

end start