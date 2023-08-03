.model small
.stack 100h

.data
msg db 0ah, 0dh, "Temperature: $"
temp db 3 dup('$')

.code
main proc
    mov ax, @data
    mov ds, ax
    
    call initADC
    call initLCD
    
    ; Main loop
    mov cx, 10   ; Number of temperature readings
    
    loop_start:
        call readTemperature
        call displayTemperature
        
        call delay
        
        loop loop_start
    
    ; Exit program
    mov ah, 4ch
    int 21h
    
main endp

; Initialize ADC
initADC proc
    mov dx, 03c2h
    mov al, 11000011b
    out dx, al
    
    ret
initADC endp

; Initialize LCD
initLCD proc
    mov ah, 00h
    mov al, 38h   ; Function set: 8-bit mode, 2-line display, 5x7 font
    int 10h       ; Call BIOS video interrupt
    
    mov ah, 00h
    mov al, 0Fh   ; Display control: Display on, cursor off, blink off
    int 10h       ; Call BIOS video interrupt
    
    mov ah, 00h
    mov al, 06h   ; Entry mode set: Increment cursor, no display shift
    int 10h       ; Call BIOS video interrupt
    
    ret
initLCD endp

; Read temperature
readTemperature proc
    mov ah, 04h   ; ADC input channel 0 (assuming temperature sensor connected to channel 0)
    int 1ah       ; Call the BIOS analog-to-digital conversion function
    
    ; Convert ADC value to temperature (example formula)
    xor bx, bx   ; Clear BX register
    mov bl, al   ; Store ADC value in BL register
    
    mov dl, 0ah  ; Divisor (10)
    xor ah, ah   ; Clear AH register
    div dl       ; Divide BL by DL
    add al, 30h  ; Convert quotient to ASCII digit
    
    mov byte ptr temp, al ; Store first digit of temperature
    
    mov dl, 0ah  ; Divisor (10)
    xor ah, ah   ; Clear AH register
    xor dx, dx   ; Clear DX register (DX = quotient + remainder)
    div dl       ; Divide BL by DL
    
    add al, 30h  ; Convert quotient to ASCII digit
    mov byte ptr temp+1, al ; Store second digit of temperature
    
    add dl, 30h  ; Convert remainder to ASCII digit
    mov byte ptr temp+2, dl ; Store third digit of temperature
    
    ret
readTemperature endp

; Display temperature on LCD
displayTemperature proc
    mov ah, 02h
    mov bh, 00h   ; Display page 0
    xor dh, dh    ; Row 0
    xor dl, dl    ; Column 0
    int 10h       ; Call BIOS video interrupt
    
    mov ah, 13h
    mov al, temp  ; Display first digit of temperature
    int 10h       ; Call BIOS video interrupt
    
    inc dl        ; Move to next column
    mov al, temp+1  ; Display second digit of temperature
    int 10h       ; Call BIOS video interrupt
    
    inc dl        ; Move to next column
    mov al, temp+2  ; Display third digit of temperature
    int 10h       ; Call BIOS video interrupt
    
    ret
displayTemperature endp

; Delay function
delay proc
    mov cx, 0FFFFh
    delay_loop:
        loop delay_loop
    ret
delay endp

end main
