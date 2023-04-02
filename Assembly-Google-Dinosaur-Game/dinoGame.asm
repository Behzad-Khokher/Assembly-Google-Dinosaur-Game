;Project By Behzad And Maham
;Jumping Dino Game using graphics 

[org 0x0100]
jmp start	

; HEX BIN COLOR
; 0 0000 black
; 1 0001 blue
; 2 0010 green
; 3 0011 cyan
; 4 0100 red
; 5 0101 magenta
; 6 0110 brown
; 7 0111 light gray
; 8 1000 dark gray
; 9 1001 light blue
; A 1010 light green
; B 1011 light cyan
; C 1100 light red
; D 1101 light magenta
; E 1110 yellow
; F 1111 white 

; Note 	Frequency 	Frequency #
; C 	130.81 	9121
; C# 	138.59 	8609
; D 	146.83 	8126
; D# 	155.56 	7670
; E 	164.81 	7239
; F 	174.61 	6833
; F# 	185.00 	6449
; G 	196.00 	6087
; G# 	207.65 	5746
; A 	220.00 	5423
; A# 	233.08 	5119
; B 	246.94 	4831
; Middle C 	261.63 	4560
; C# 	277.18 	4304
; D 	293.66 	4063
; D# 	311.13 	3834
; E 	329.63 	3619
; F 	349.23 	3416
; F# 	369.99 	3224
; G 	391.00 	3043
; G# 	415.30 	2873
; A 	440.00 	2711
; A# 	466.16 	2559
; B 	493.88 	2415
; C 	523.25 	2280
; C# 	554.37 	2152
; D 	587.33 	2031
; D# 	622.25 	1917
; E 	659.26 	1809
; F 	698.46 	1715
; F# 	739.99 	1612
; G 	783.99 	1521
; G# 	830.61 	1436
; A 	880.00 	1355
; A# 	923.33 	1292
; B 	987.77 	1207
; C 	1046.50 	1140

floor_x: dw 360
floor_y: dw 160

cloud_x: dw 50
cloud_y: dw 20

score_string: db "Score:"
x_pos: dw 8
score: dw 0
temp: db 0
sound_F: dw 5423;1917;5423

; Dino Variables: 	
dino_temp: dw 0
dino_x_pos: dw 35
dino_y_pos: dw 100

dino_y_pos_default: dw 100

dino_x_max: dw 80

dino_jump_height: dw 60

dino_in_air_time: db 2; 0.90 seconds 
dino_jump_status: db 0 ; 0 for ground; 1 for air

seconds_before_dino_jump: dw 0
seconds_after_dino_jump: db 0

; Fireball Variables---------------------------------------
fireball_x_pos: dw 300
fireball_y_pos: dw 100

fireball_y_pos_array: db 100,126,144

fireball_x_pos_default: dw 300
fireball_y_pos_default: dw 126

fireball_speed: dw 7
fireball_hit_bool: db 0

; System Variables
sound_status: db 0

system_time: db 0 ;Stores 0.01 of a seconds; 0.05seconds => system_time = 5


window_width: dw 140h ; 320(pixels)
window_height: dw 0C8h; 200(pixels)

background_color: dw 7 ;7,8,

string1: db'Press Any Key To Start'		
titleS: db'--Asteroid Dash--'		
instructions: db '-Press J to Jump -Press D to Reset'	
instructions2: db'Avoid This Fireball:'
madeBy: db 'Made By: Maham(19L-2279) | Behzad(19L-2744)'


displayPixel:		push bp
					mov bp,sp 
					push ax 
					push cx 
					push dx
					
					mov ah, 0ch 
					mov al, byte[bp+8]; color
					mov cx,[bp+6]; x position
					mov dx,[bp+4]; y position
					int 10h
					
					pop dx 
					pop cx 
					pop ax
					pop bp
					ret 6

displayPixel2:	; Displays a 2 by 2 single colored filled Pixel at X,Y Position 
				;(X,Y) represetns the top left of 2 by 2 pixel
				; push order: color,X,Y
				push bp 
				mov bp,sp 
				
				push ax 
				push bx 
				push cx 
				push dx  
				
				mov bx,[bp+6] ;X
				mov dx,[bp+4] ;Y 
				mov ax,[bp+8] ; color 
				mov ah,0
				mov cx,2 ; height
				
				.loopOut		push cx ; Vertical Loop
							push bx
							mov cx,2 ; width
							.loopIn:; Horizontal Loop
									push ax
									
									push bx 
									push dx 
									call displayPixel
									inc bx 
									loop .loopIn
							inc dx 
							pop bx
							pop cx 
							loop .loopOut
							
				pop dx 
				pop cx 
				pop bx 
				pop ax 
				pop bp
				ret 6					

displayPixel3:	; Displays a 2 by 2 single colored filled Pixel at X,Y Position 
				;(X,Y) represetns the top left of 2 by 2 pixel
				; push order: color,X,Y
				push bp 
				mov bp,sp 
				
				push ax 
				push bx 
				push cx 
				push dx  
				
				mov bx,[bp+6] ;X
				mov dx,[bp+4] ;Y 
				mov ax,[bp+8] ; color 
				mov ah,0
				mov cx,3 ; height
				
				.loopOut		push cx ; Vertical Loop
							push bx
							mov cx,3 ; width
							.loopIn:; Horizontal Loop
									push ax
									
									push bx 
									push dx 
									call displayPixel
									inc bx 
									loop .loopIn
							inc dx 
							pop bx
							pop cx 
							loop .loopOut
							
				pop dx 
				pop cx 
				pop bx 
				pop ax 
				pop bp
				ret 6	
				
displayPixel5:	; Displays a 5 by 5 single colored filled Pixel at X,Y Position 
				;(X,Y) represetns the top left of 5 by 5 pixel
				; push order: color,X,Y
				push bp 
				mov bp,sp 
				
				push ax 
				push bx 
				push cx 
				push dx  
				
				mov bx,[bp+6] ;X
				mov dx,[bp+4] ;Y 
				mov ax,[bp+8] ; color 
				mov ah,0
				mov cx,5 ; height
				
				.loopOut		push cx  ; Vertical Loop
							push bx
							mov cx,5 ; width
							.loopIn: ; Horizontal Loop
									push ax
									
									push bx 
									push dx 
									call displayPixel
									inc bx 
									loop .loopIn
							inc dx 
							pop bx
							pop cx 
							loop .loopOut
							
				pop dx 
				pop cx 
				pop bx 
				pop ax 
				pop bp
				ret 6		
						

displayBitmap3:	; Displays a bitmap graphic
				; Every Pixel is a 2 x 2
				; Displays Bitmap graphic with top left cordinates(X,Y)
				; push order: bitmap, width, height,X, Y
				push bp ; push bitmap, width, heights,X, Y,
				mov bp,sp 
				push ax 
				push bx 
				push cx 
				push dx 
				push si 
				
				
				mov dx,[bp+4] ;Y 
				mov bx,[bp+6] ;X
				mov si,[bp+12] ; bitmap location
				
				mov cl,[bp+8] ; height
				mov ch,0
				
			.OuterLoop:				
				push cx
				mov cl,[bp+10]
				mov ch,0
				mov bx,[bp+6]
				.InnerLoop: 	lodsb ; will load bitmap(si) to al
							mov ah,0
							push ax
							push bx 
							push dx 
							call displayPixel3
							add bx,3
							
							loop .InnerLoop
							
							pop cx
							add dx ,3
				 .loopEnd:	loop .OuterLoop
				 
				 pop si 
				 pop dx 
				 pop cx 
				 pop bx
				 pop ax
				 pop bp
				 ret 10

displayBitmap1:	; Displays a bitmap graphic
				; Every Pixel is a 1 x 1
				; Displays Bitmap graphic with top left cordinates(X,Y)
				; push order: bitmap, width, height,X, Y
				push bp ; push bitmap, width, heights,X, Y,
				mov bp,sp 
				push ax 
				push bx 
				push cx 
				push dx 
				push si 
				
				
				mov dx,[bp+4] ;Y 
				mov bx,[bp+6] ;X
				mov si,[bp+12] ; bitmap location
				
				mov cl,[bp+8] ; height
				mov ch,0
				
			.OuterLoop:				
				push cx ; Save Height
				mov cl,[bp+10] ; Save Width
				mov ch,0
				mov bx,[bp+6]; 
				.InnerLoop: 	lodsb ; will load bitmap(si) to al
							mov ah,0
							push ax
							push bx 
							push dx 
							call displayPixel2
							add bx,1
							
							loop .InnerLoop
							
							pop cx
							add dx ,1
				 .loopEnd:	loop .OuterLoop
				 
				 pop si 
				 pop dx 
				 pop cx 
				 pop bx
				 pop ax
				 pop bp
				 ret 10						 
				 
displayBitmap2:	; Displays a bitmap graphic
				; Every Pixel is a 2 x 2
				; Displays Bitmap graphic with top left cordinates(X,Y)
				; push order: bitmap, width, height,X, Y
				push bp ; push bitmap, width, heights,X, Y,
				mov bp,sp 
				push ax 
				push bx 
				push cx 
				push dx 
				push si 
				
				
				mov dx,[bp+4] ;Y 
				mov bx,[bp+6] ;X
				mov si,[bp+12] ; bitmap location
				
				mov cl,[bp+8] ; height
				mov ch,0
				
			.OuterLoop:				
				push cx ; Save Height
				mov cl,[bp+10] ; Save Width
				mov ch,0
				mov bx,[bp+6]; 
				.InnerLoop: 	lodsb ; will load bitmap(si) to al
							mov ah,0
							push ax
							push bx 
							push dx 
							call displayPixel2
							add bx,2
							
							loop .InnerLoop
							
							pop cx
							add dx ,2
				 .loopEnd:	loop .OuterLoop
				 
				 pop si 
				 pop dx 
				 pop cx 
				 pop bx
				 pop ax
				 pop bp
				 ret 10				 

displayBitmap5:	; Displays a bitmap graphic
				; Every Pixel is a 5 x 5
				; Displays Bitmap graphic with top left cordinates(X,Y)
				; push order: bitmap, width, height,X, Y
				push bp 
				mov bp,sp 
				push ax 
				push bx 
				push cx 
				push dx 
				push si 
				
				
				mov dx,[bp+4] ;Y 
				mov bx,[bp+6] ;X
				mov si,[bp+12] ; bitmap location
				
				mov cl,[bp+8] ; height
				mov ch,0
				
			.OuterLoop:				
				push cx; save height
				mov cl,[bp+10]; width
				mov ch,0
				mov bx,[bp+6]
				.InnerLoop: 	lodsb ; will load bitmap(si) to al
							mov ah,0
							push ax
							push bx 
							push dx 
							call displayPixel5
							add bx,5
							
							loop .InnerLoop
							
							pop cx
							add dx ,5
				 .loopEnd:	loop .OuterLoop
				 
				 pop si 
				 pop dx 
				 pop cx 
				 pop bx
				 pop ax
				 pop bp
				 ret 10
				 				 
				 
coverBitmap5:	push bp ;color,width, heights,X, Y,
				mov bp,sp 
				pusha
				
				
				mov dx,[bp+4] ;Y 
				mov bx,[bp+6] ;X
				mov cx,[bp+8] ; height
				
			.OuterLoop:				
				push cx
				mov cx,[bp+10] ; width
				mov bx,[bp+6]
				.InnerLoop: 
							mov ax,[bp+12]
							push ax
							push bx 
							push dx 
							call displayPixel5
							add bx,5
							
							loop .InnerLoop
							
							pop cx
							add dx ,5
				 .loopEnd:	loop .OuterLoop
				 
				 popa 
				 pop bp 
				 ret 10
				 
coverBitmap1:	push bp ;color,width, heights,X, Y,
				mov bp,sp 
				pusha
				
				
				mov dx,[bp+4] ;Y 
				mov bx,[bp+6] ;X
				mov cx,[bp+8] ; height
				
			.OuterLoop:				
				push cx
				mov cx,[bp+10] ; width
				mov bx,[bp+6]
				.InnerLoop: 
							mov ax,[bp+12]
							push ax
							push bx 
							push dx 
							call displayPixel
							add bx,2
							
							loop .InnerLoop
							
							pop cx
							add dx ,2
				 .loopEnd:	loop .OuterLoop
				 
				 popa 
				 pop bp 
				 ret 10				 

coverBitmap2:	push bp ;color,width, heights,X, Y,
				mov bp,sp 
				pusha
				
				
				mov dx,[bp+4] ;Y 
				mov bx,[bp+6] ;X
				mov cx,[bp+8] ; height
				
			.OuterLoop:				
				push cx
				mov cx,[bp+10] ; width
				mov bx,[bp+6]
				.InnerLoop: 
							mov ax,[bp+12]
							push ax
							push bx 
							push dx 
							call displayPixel2
							add bx,2
							
							loop .InnerLoop
							
							pop cx
							add dx ,2
				 .loopEnd:	loop .OuterLoop
				 
				 popa 
				 pop bp 
				 ret 10


coverDino5:		push word[background_color]
				push word[dino_width]
				push word[dino_height]
				push word[dino_x_pos]
				push word[dino_y_pos]
				call coverBitmap5
				ret
				
coverFireBall2:	push word[background_color]
				push word[fireBallHeight]
				push word[fireBallWidth]
				push word[fireball_x_pos]
				push word[fireball_y_pos]
				call coverBitmap2
				ret				

delay:				push cx
					mov cx,0xFFFF
					.back: loop .back
					
					pop cx 
					ret		

setBackground:	push bp
				mov bp,sp 
				pusha
				
				mov ax, 0xA000
				mov es,ax 
				xor di,di ; di = 0
				mov cx,	64000
				mov al,[bp+4]
				.loop  stosb 
					   loop .loop
				popa
				pop bp 
				ret 2
				

initializeVideoMode:	mov	ax, 0013h  ; AH=00h is BIOS.SetVideoMode, AL=13h is 320x200 mode -256 per pixel (VGA)
						int  10h
						ret

getSystemTime:			;Return: CH = hour CL = minute DH = second DL = 1/100 seconds
						mov ax, 0x2C00 ; AH = 2C BIOS.getSystemTime
						int 21h	
						ret

setSystemTime:		;Pass time in dl ; return in AL 
						;AL = 0 : System Time Not Change
						;AL = 1 : System Time Changed 
						mov al,0
						cmp dl,[system_time]
						je .end ; System Time Not Changed
						mov [system_time], dh ;Update Time if changed	
						mov al,1
			.end:		ret
						
showDinoAnimated:	push bp 
					mov bp,sp 
					push ax 
					push bx
					
					mov bx,dino3
					cmp byte[dino_jump_status],1
					je .showDino
					
					mov al,byte[bp+4]
					cmp al,1
					je .dinoA 
					jne .dinoB
					
		.dinoA:		mov bx,dino1
					jmp .showDino
		
		.dinoB:		mov bx,dino2
		
		.showDino:	push bx;word bitmap
					push word [dino_width]
					push word [dino_height]
					push word [dino_x_pos]
					push word [dino_y_pos]
					call displayBitmap3
					
					pop bx
					pop ax
					pop bp 
					ret 2
					
showFireball:		push bp 
					mov bp,sp 
					push ax 
					push bx
					
					mov al,byte[bp+4]
					cmp al,1
					je .fireBallA 
					jne .fireBallB
					
		.fireBallA:	mov bx,fireBall1
					jmp .showDino
		
		.fireBallB:	mov bx,fireBall2
		
		.showDino:	push bx;word bitmap
					push word [fireBallWidth]
					push word [fireBallHeight]
					push word [fireball_x_pos]
					push word [fireball_y_pos]
					call displayBitmap2
					
					pop bx
					pop ax
					pop bp 
					ret 2

moveFireball:		push ax 
					mov ax , [fireball_x_pos]
					sub ax , [fireball_speed]
					mov [fireball_x_pos], ax 
					pop ax 
					ret

resetFireball:		push ax 
					mov ax, [fireball_x_pos_default]
					mov [fireball_x_pos], ax
					mov ax, [fireball_y_pos_default]
					mov [fireball_y_pos], ax
					pop ax 
					ret 				
					
dinoJump:			push ax 
					mov ax , [dino_y_pos]
					sub ax , [dino_jump_height]
					mov [dino_y_pos], ax 
					pop ax 
					ret 

dinoReset:			push ax 
					mov ax, [dino_y_pos_default]
					mov [dino_y_pos], ax
					pop ax 
					ret 
					
generateFireballPosition:	pusha 
							
							mov ah,[system_time]
							xor dx,dx 
							xor cx,cx
							mov cx,9 ; Three possible positions of fireball 
							div cx 
							;DX will contain position 0,1,2
							xor bx,bx 
							cmp dx,4
							jbe .position0
							cmp dx,7
							jbe .position1
							cmp dx, 10
							jbe .position2
							
			.position0:		mov bl,[fireball_y_pos_array + 0]
							mov [fireball_y_pos_default],bx
							
							jmp .end1

			.position1:		mov bl,[fireball_y_pos_array + 1]
							mov [fireball_y_pos_default],bx
							jmp .end1
			
			.position2:		mov bl,[fireball_y_pos_array + 2]
							mov [fireball_y_pos_default],bx

				.end1:		
							popa
							ret
							
								
							
					
checkFireballCollision:		; Returns in AL = 0 If no Collision else AL = 1
							push bx
							mov al,0
							cmp byte[dino_jump_status], 1
							je .end ; If status = 1, jump to end
								mov bx, [dino_x_max]
								cmp [fireball_x_pos], bx
								;if !(fireball_x_pos < dino_x_max) jmp end 
								jnbe .end
								mov bx, [dino_x_pos]
								sub bx,2
								cmp bx, [fireball_x_pos]
								jnae .set 
								jmp .end
								
				.set:			mov al,1
	
				.end:		pop bx
							ret
			
makeBeep:					mov     al, 182         ; Speaker Prep Code 
							out     43h, al         ; Prepare The Speaker by sending 182 to Port 43h
							mov     ax, word[sound_F]        ; Frequency number (in decimal)
													;  for middle C.
							out     42h, al         ; Output low byte.
							mov     al, ah          ; Output high byte.
							out     42h, al 
							in      al, 61h         ; Turn on note (get value from
													;  port 61h).
							or      al, 00000011b   ; Set bits 1 and 0.
							out     61h, al         ; Send new value.	
							ret 

stopBeep:					 in      al, 61h         ; Turn off note (get value from;  port 61h).
							and     al, 11111100b   ; Reset bits 1 and 0.
							out     61h, al         ; Send new value.
							ret
							

drawLineVertical:	push bp 
					mov bp,sp 
					pusha 
					
					mov bx,[bp+4]
					mov dx,0
					mov cx,200
					
					.loop push 7
						  push bx 
						  push dx 
						  call displayPixel
						  inc dx 
						  loop .loop 
					popa
					pop bp 
					ret 2
					
drawLineHorizontal:	push bp 
					mov bp,sp 
					pusha 
					
					mov dx,[bp+4]
					mov bx,0
					mov cx,320
					
					.loop push 8
						  push bx 
						  push dx 
						  call displayPixel
						  inc bx
						  loop .loop 
					popa
					pop bp 
					ret 2

					

printString:		;push string,length,x,y
					;Pass by refrence:
					;cx = length 
					;dl = x position 
					;dh = y position
					push bp 
					mov bp ,sp
					push es
					push ax
					push bx
					push cx
					push dx 
					
					
					mov cx,[bp+8]
					mov dl,[bp+6]
					mov dh,[bp+4]
					mov ax,[bp+10]
					
					push bp 
					
					mov bp,ax
					push cs
					pop es 
					mov ah,13h ;service to print string
					mov al,0
					mov bh,0
					mov bl,15 ; color 
					int 10h
					pop bp
					
					pop dx
					pop cx
					pop bx
					pop ax
					pop es
					pop bp 
					ret 8
					
printNum: 	
			;Pass by ax: load number in ax
			push bp 
			mov bp,sp
			pusha
			mov ax, [bp+4]
			mov bx, 10 ; use base 10 for division
			mov cx, 0 ; initialize count of digits
			
			nextdigit: mov dx, 0 ; zero upper half of dividend
			div bx ; divide by 10
			add dl, 0x30 ; convert digit into ascii value
			push dx ; save ascii value on stack
			inc cx ; increment count of values
			cmp ax, 0 ; is the quotient zero
			jnz nextdigit ; if no divide it again
			
			
			
			mov dx,cx
			.back:	pop ax 
					mov byte[temp],al
					push temp 
					push 1
					push word[x_pos]
					push 0
					call printString
					inc word[x_pos]
					dec dx 
					cmp dx,0
					jne .back
			popa		
			pop bp		
			ret 2
			
nextPosition:		  push ax 
					  push bx 
					  push dx 
					  inc byte[x_pos]
					  mov dl, [x_pos]
					  mov dh, 0
					  mov ah, 2 ;SERVICE TO SET CURSOR POSITION.
					  mov bh, 0 ;PAGE.
					  int 10h   ;BIOS SCREEN SERVICES.  
					  pop dx 
					  pop bx 
					  pop ax
						ret
			

displayChar:  	 ;pass ascii in al 
				  mov  ah, 9
				  mov  bh, 0
				  mov  bl, 15  ;ANY COLOR.
				  mov  cx, 1  ;HOW MANY TIMES TO DISPLAY CHAR.
				  int  10h
				  ret		

			
printScore:			push score_string
					push 6
					push 0
					push 0 
					call printString
					
					push word[score]
					call printNum
					mov byte[x_pos],8
					
					
					ret
					
showFloorAndMove:	push ax
					
					push floor 
					push word[floorWidth]
					push word[floorHeight]
					push word[floor_x]
					push word[floor_y]
					call displayBitmap1
					
					cmp word[floor_x], 7
					jae .end 

					mov word[floor_x], 300
					
					.end:
					sub word[floor_x],5
					pop ax
					 ret 
					
showCloudAndMove:	push bx
					push dx
					
					mov bx,word[cloud_x]
					mov dx,word[cloud_y]
						
					push cloud 
					push word[cloudWidth]
					push word[cloudHeight]
					push bx
					push dx
					call displayBitmap3
					
					add bx, 100
					
					push cloud 
					push word[cloudWidth]
					push word[cloudHeight]
					push bx
					push dx
					call displayBitmap3
					
					add bx, 90
					
					push cloud 
					push word[cloudWidth]
					push word[cloudHeight]
					push bx
					push dx
					call displayBitmap3

					
					
					dec word[cloud_x]

					
					.end:
					pop dx 
					pop bx
					ret 					
					

showHomePage:	
				pusha
				
				push 35
				call drawLineHorizontal
				
				push word[background_color]
				push word[fireBallWidth]
				push word[fireBallHeight]
				push bx
				push 150
				call coverBitmap5
				
				mov bx,250 
				mov dx,150
				
				push madeBy ;'Made By:'
				push 8
				push 0
				push 0
				call printString
				
				push madeBy+8 ;'Maham(19L-2744)'
				push 35
				push 0
				push 1
				call printString

				
				
				push titleS
				push 17
				push 50
				push 30 
				call printString
				
				push instructions ;'-Press J to Jump'
				push 16
				push 50
				push 35
				call printString
				
				push instructions ;'-Press J to Jump'
				push 16
				push 50
				push 35
				call printString
				
				push instructions+17 ;'Press D to Reset'
				push 17
				push 50
				push 37
				call printString
				
				push instructions2 ;'Avoid This Fireball:'
				push 20
				push 50
				push 40
				call printString
			delayLoop:
				
				push fireBall1
				push word[fireBallWidth]
				push word[fireBallHeight]
				push bx 
				push dx 
				sub bx,7
				call displayBitmap5
				
				
				push dino1 
				push word[dino_width]
				push word[dino_height]
				push 30
				push 50 
				call displayBitmap5
				
				push dino2
				push word[dino_width]
				push word[dino_height]
				push 30
				push 50 
				call displayBitmap5
				mov dx,150 
				
				
				mov ah,01h; AH = 01 BIOS.KeyStatus
				int 16h
				jnz .end
				
				jmp delayLoop
.end:		popa
			ret 
	


;gameOver: db 'Game Over!!!'	

			
start:	

	call initializeVideoMode
	
	push word[background_color]
	call setBackground

	
	call showHomePage


	call delay
	call delay
	call delay
	push word[background_color]
	call setBackground
	
	check_Time:	
				call getSystemTime ;returns time in dh:dl
				call setSystemTime  ;pass in dl and returns bool in al
				cmp al,0
				je check_Time ; check time again
				
				
				push dx ; Save time: dh:dl value
				
				; Check Dino Status
				.checkDinoStatus
				cmp byte[dino_jump_status], 0 ; status = 0 -> running	/ status = 1 -> jump
				je .checkSound 
						sub dh, [seconds_before_dino_jump+1]
						cmp dh,0
						jna .checkSound
							sub dl,[seconds_before_dino_jump]
							cmp dl, 0xfd;0xfd
							jna .next
							mov byte[dino_jump_status], 0
							call coverDino5
							call dinoReset
				 
				; Check Sound
				.checkSound:
				pop dx
				cmp byte[sound_status], 0; status = 0 -> sound off	/ status = 1 -> sound on
				je .next
					sub dh,[seconds_before_dino_jump+1]
					cmp dh,1
					jnae .next
					mov byte[sound_status], 0
					call stopBeep
					mov word[seconds_before_dino_jump], 0x0000
				
				
				.next:
				;All Animations and Movements Go Here:
				;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
					
					call printScore
					call showFloorAndMove
					call showCloudAndMove
		
					push 159 ; Y
					call drawLineHorizontal

		
				
				
				xor word[dino_temp],1 ; Alternate Between 0 and 1 
				
				push word[dino_temp]
				call showDinoAnimated
				
				.showFireball:
				;call coverFireBall2
				push word[dino_temp]
				call showFireball
				call checkFireballCollision
				cmp al,1
				je hitScreen ;!!! change this
				
				
				
				cmp word[fireball_x_pos], 10
				ja .moveFireball
					inc word[score] 
					call coverFireBall2
					call generateFireballPosition ; Random Position Generator
					call resetFireball
				
				
				
				
				.moveFireball
				call moveFireball

				;-------------------------------------------------------------
				
				;check if key is pressed 
				mov ah,01h; AH = 01 BIOS.KeyStatus
				int 16h
				jnz key_is_pressed
				jmp check_Time
				

				
				key_is_pressed: mov ax,0x0000 ; ah = 00 ; check which key is pressed 
								int 16h
								
								cmp al,106 ; check if 'j' is pressed 
								je j_is_pressed
								cmp al,100 ; check if 'd' is pressed
								je d_is_pressed
								cmp al, 27 ; check if 'esc' key is pressed 
								je end
								jne check_Time
								
								j_is_pressed: 	cmp byte[dino_jump_status], 1 ; Check If Dino Already in air
												je check_Time
												call coverDino5	; Clear Dino
												call dinoJump ; Change Dino x,y position
												call getSystemTime
												mov byte[seconds_before_dino_jump+1], dh ; Save Seconds
												mov byte[seconds_before_dino_jump], dl ; Save 0.01 of Seconds
												mov byte[dino_jump_status], 1
												mov byte[sound_status],1
												call makeBeep
												jmp check_Time
												
								d_is_pressed:	call coverDino5
												mov byte[dino_jump_status], 0
												mov byte[sound_status],0
												call stopBeep
												call dinoReset
				
				jmp check_Time 
				
				
hitScreen:
mov word[sound_F],1140
call makeBeep
push word[background_color]

push 0
call showDinoAnimated
call showFireball
call printScore		
call delay
call delay
call stopBeep		
				
end:

mov ax,0x4c
int 21h	

; All Bitmap Files

		dino1:								   	
    db      7, 7, 7, 7, 7, 7, 7, 7, 7, 4, 4, 4, 0, 0, 7
    db      7, 7, 7, 7, 7, 7, 7, 7, 0, 7, 0, 0, 0, 0, 0
    db      7, 7, 7, 7, 7, 7, 7, 7, 4, 0, 0, 0, 0, 0, 0
	db      7, 7, 7, 7, 7, 7, 7, 7, 0, 0, 0, 7, 7, 7, 7
	db      7, 7, 7, 7, 7, 7, 7, 7, 4, 0, 0, 0, 0, 7, 7
	db      7, 7, 7, 7, 7, 7, 7, 7, 4, 0, 7, 7, 7, 7, 7
    db      4, 7, 7, 7, 7, 7, 7, 7, 4, 0, 7, 7, 7, 7, 7
    db      4, 7, 7, 7, 7, 7, 7, 4, 0, 0, 0, 0, 7, 7, 7
	db      4, 4, 7, 7, 7, 7, 4, 0, 0, 0, 7, 0, 7, 7, 7
	db      4, 0, 4, 7, 7, 4, 0, 0, 0, 0, 7, 7, 7, 7, 7
	db      4, 0, 0, 7, 4, 0, 0, 0, 0, 4, 7, 7, 7, 7, 7
    db      7, 4, 0, 4, 0, 0, 0, 0, 0, 4, 7, 7, 7, 7, 7
    db      7, 4, 0, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 7
	db      7, 7, 4, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 7
	db      7, 7, 7, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 7
	db      7, 7, 7, 0, 7, 7, 7, 7, 0, 0, 7, 7, 7, 7, 7
	db      7, 7, 7, 0, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7
	db      7, 7, 7, 0, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7
	db      7, 7, 7, 0, 0, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7
	
		dino2:								   	
    db      7, 7, 7, 7, 7, 7, 7, 7, 7, 4, 4, 4, 0, 0, 7
    db      7, 7, 7, 7, 7, 7, 7, 7, 0, 7, 0, 0, 0, 0, 0
    db      7, 7, 7, 7, 7, 7, 7, 7, 4, 0, 0, 0, 0, 0, 0
	db      7, 7, 7, 7, 7, 7, 7, 7, 0, 0, 0, 7, 7, 7, 7
	db      7, 7, 7, 7, 7, 7, 7, 7, 4, 0, 0, 0, 0, 7, 7
	db      7, 7, 7, 7, 7, 7, 7, 7, 4, 0, 7, 7, 7, 7, 7
    db      7, 7, 4, 7, 7, 7, 7, 7, 4, 4, 7, 7, 7, 7, 7
    db      7, 4, 7, 7, 7, 7, 7, 4, 0, 0, 0, 0, 7, 7, 7
	db      4, 4, 7, 7, 7, 7, 4, 0, 0, 0, 7, 0, 7, 7, 7
	db      4, 0, 4, 7, 7, 4, 0, 0, 0, 4, 7, 7, 7, 7, 7
	db      4, 0, 0, 7, 4, 0, 0, 0, 0, 4, 7, 7, 7, 7, 7
    db      7, 4, 0, 4, 0, 0, 0, 0, 0, 4, 7, 7, 7, 7, 7
    db      7, 4, 0, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 7
	db      7, 7, 4, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 7
	db      7, 7, 7, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 7
	db      7, 7, 7, 0, 7, 7, 7, 7, 0, 7, 7, 7, 7, 7, 7
	db      7, 7, 7, 0, 0, 0, 7, 7, 0, 7, 7, 7, 7, 7, 7
	db      7, 7, 7, 7, 7, 7, 7, 7, 0, 7, 7, 7, 7, 7, 7
	db      7, 7, 7, 7, 7, 7, 7, 7, 0, 0, 7, 7, 7, 7, 7
	
			dino3:								   	
    db      7, 7, 7, 7, 7, 7, 7, 7, 7, 4, 4, 4, 0, 0, 7
    db      7, 7, 7, 7, 7, 7, 7, 7, 0, 4, 0, 0, 0, 0, 0
    db      7, 7, 7, 7, 7, 7, 7, 7, 4, 0, 0, 0, 0, 0, 0
	db      7, 7, 7, 7, 7, 7, 7, 7, 0, 0, 0, 7, 7, 7, 7
	db      7, 7, 7, 7, 7, 7, 7, 7, 4, 0, 0, 0, 0, 7, 7
	db      7, 7, 7, 7, 7, 7, 7, 7, 4, 0, 7, 7, 7, 7, 7
    db      7, 7, 4, 7, 7, 7, 7, 7, 4, 4, 7, 7, 7, 7, 7
    db      7, 4, 7, 7, 7, 7, 7, 4, 0, 0, 0, 0, 7, 7, 7
	db      4, 4, 7, 7, 7, 7, 4, 0, 0, 0, 7, 0, 7, 7, 7
	db      4, 0, 4, 7, 7, 4, 0, 0, 0, 4, 7, 7, 7, 7, 7
	db      4, 0, 0, 7, 4, 0, 0, 0, 0, 4, 7, 7, 7, 7, 7
    db      7, 4, 0, 4, 0, 0, 0, 0, 0, 4, 7, 7, 7, 7, 7
    db      7, 4, 0, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 7
	db      7, 7, 4, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 7
	db      7, 7, 7, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 7
	db      7, 7, 7, 0, 7, 7, 7, 7, 0, 7, 7, 7, 7, 7, 7
	db      7, 7, 7, 0, 7, 7, 7, 7, 0, 7, 7, 7, 7, 7, 7
	db      7, 7, 7, 0, 0, 7, 7, 7, 0, 0, 7, 7, 7, 7, 7
	db      7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7
	
dino_width: dw 15
dino_height: dw 19


	
			fireBall1:
	db		7, 7, 4, 4, 4, 7, 7, 7, 7, 7, 7, 7, 7
	db		7, 4, 14, 14, 14, 4, 7, 7, 7, 7, 7, 7, 7
	db		4, 14, 14, 4, 14, 14, 4, 7, 7, 7, 7, 7, 7
	db		4, 14, 4, 14, 4, 14, 4, 7, 7, 7, 7, 7, 7
	db		4, 14, 14, 4, 14, 14, 4, 7, 7, 7, 7, 7, 7
	db		7, 4, 14, 14, 14, 4, 7, 7, 7, 7, 7, 7, 7
	db		7, 7, 4, 4, 4, 7, 7, 7, 7, 7, 7, 7, 7
	
			fireBall2:
	db		7, 7, 14, 14, 14, 7, 7, 14, 7, 7, 7, 7, 7
	db		7, 14, 4, 4, 4, 14, 7, 7, 7, 7, 7, 7, 7
	db		14, 4, 4, 14, 4, 4, 14, 7, 7, 7, 7, 7, 7
	db		14, 4, 14, 4, 14, 4, 14, 7, 7, 7, 7, 7, 7
	db		14, 4, 4, 14, 4, 4, 14, 7, 7, 7, 7, 7, 7
	db		7, 14, 4, 4, 4, 14, 7, 7, 7, 7, 7, 7, 7
	db		7, 7, 14, 14, 14, 7, 7, 14, 7, 7, 7, 7, 7
	
	fireBallWidth: dw 13
	fireBallHeight: dw 7
	
			stars:
	db		15
	db		0
	db		15 
	db		0
	db		15
	db		0 
	starsWidth: dw 1
	starsHeight: dw 6
	
			floor:
	db		7,7,7,15,7,7,15,7,15,15, 7, 7,7,7
	floorWidth: dw 13
	floorHeight: dw 1
	
			cloud:
	db 		7,7,7,7,15,7,15,7,7,7
	db 		7,15,15,15,7,15,7,15,7,7	
	db 		15,7,15,7,15,7,15,15,7,7
	db 		15,15,15,15,7,15,7,7,7,7
	db 		7,7,7,7,7,7,7,7,7,7
	cloudWidth: dw 10
	cloudHeight: dw 5


