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
    
    ; Main loop
    mov cx, 10   ; Number of temperature readings
    
    loop_start:
        call readTemperature
        
        ; Display temperature
        mov ah, 09h
        mov dx, offset msg
        int 21h
        
        mov ah, 09h
        mov dx, offset temp
        int 21h
        
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

end main
