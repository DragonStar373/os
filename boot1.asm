[org 0x7c00]
BOOT2_LOCATION equ 0xC00



mov [BOOT_DISK], dl

;check that it worked:
cmp dl, [BOOT_DISK]
jne ruh_roh
jmp not_ruh_roh
ruh_roh:
mov ah, 0x0e
mov al, 'd'
int 0x10
mov al, 'l'
int 0x10
mov al, ' '
int 0x10
mov al, 'e'
int 0x10
mov al, 'r'
int 0x10
mov al, 'r'
int 0x10
mov al, 'o'
int 0x10
mov al, 'r'
int 0x10
jmp $
not_ruh_roh:

mov ah, 0x0e

cmp dl, 0
jz dl_is_zero
jmp dl_not_zero
dl_is_zero:
mov ah, 0x0e
mov al, 'd'
int 0x10
mov al, 'l'
int 0x10
mov al, '='
int 0x10
mov al, '0'
int 0x10
jmp $
dl_not_zero:
mov ah, 0x0e
mov al, 'd'
int 0x10
mov al, 'l'
int 0x10
mov al, ''
int 0x10
mov al, '!'
int 0x10
mov al, '='
int 0x10
mov al, '0'
int 0x10

mov al, 0x0A    ;print a newline
int 0x10
mov al, 0x0D
int 0x10
mov al, 0x0A    ;print a newline
int 0x10
mov al, 0x0D
int 0x10

sub_64_from_al:
mov al, 'd'
int 0x10
mov al, 'l'
int 0x10
mov al, ''
int 0x10
mov al, '-'
int 0x10
mov al, ' '
int 0x10
mov al, '6'
int 0x10
mov al, '4'
int 0x10
mov al, ':'
int 0x10
mov al, 0x0A    ;print a newline
int 0x10
mov al, 0x0D
int 0x10
;sub 64
mov al, dl
sub al, 64
;print
mov ah, 0x0e
int 0x10       ; Print the character
;newlines
mov al, 0x0A    ;print a newline
int 0x10
mov al, 0x0D
int 0x10
mov al, 0x0A    ;print a newline
int 0x10
mov al, 0x0D
int 0x10

comparisons:
mov dl, [BOOT_DISK]

cmp dl, 0
jz null
cmp dl, 128
je dl_equals_128
cmp dl, 0x20
jle less_than_32
cmp dl, 32
jge greater_than_32
jmp $

null:
mov al, 'n'
int 0x10
mov al, 'u'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
jmp load_disk

dl_equals_128:
mov al, 'd'
int 0x10
mov al, 'l'
int 0x10
mov al, '='
int 0x10
mov al, '1'
int 0x10
mov al, '2'
int 0x10
mov al, '8'
int 0x10
jmp load_disk

less_than_32:
mov al, 'd'
int 0x10
mov al, 'l'
int 0x10
mov al, '<'
int 0x10
mov al, '='
int 0x10
mov al, '3'
int 0x10
mov al, '2'
int 0x10
jmp load_disk

greater_than_32:
mov al, 'd'
int 0x10
mov al, 'l'
int 0x10
mov al, '>'
int 0x10
mov al, ' '
int 0x10
mov al, '3'
int 0x10
mov al, '2'
int 0x10
jmp load_disk

simple_display:
mov al, dl
int 0x10


load_disk:

mov al, 0x0A    ;print a newline
int 0x10
mov al, 0x0D
int 0x10

; 1) load the disk


xor ax, ax	;clear ax
mov es, ax	;ensures es is 0, so that we are not offsetting our memory location for loading the next sector
mov ds, ax		;idrk what this is for
mov bp, 0x8000		;idrk what this is for
mov sp, bp		;idrk what this is for

;mov ah, 2	;ah contains the (sector?)
;mov al, 20	;# of sectors to load			; I CHANGED THIS TO 20
;mov bx, KERNEL_LOCATION	;location in memory to load disk (or bin) contents
;mov ch, 0	;cyl #
;mov cl, 2	;sector # (same as ah?)
;mov dh, 0	;head #
;mov dl, [BOOT_DISK]	;drive #


;for disk reading:
;we need to know A) what disk we want to read [stored in dl], B) the CHS (cyl, head, and sector) address we want to read from [boot sector is C=0, H=0, S=1; so we want to start with C=0,H=0,S=2], C) How many sectors we want to read, and D) where in memory we want to load it

mov bx, BOOT2_LOCATION     ;location to load into memory
mov ah, 0x02    ;ah must be 2. i do not know why ah must be 2. but ah must be 2.
mov al, 0x25    ;number of sectors we want to read
mov ch, 0x00    ;cylinder #
mov dh, 0x00    ;head #
mov cl, 0x02    ;sector #
mov dl, [BOOT_DISK]     ;disk ID (ig thats what you call it)

int 0x13         ; Interrupt for disk read
jc read_error    ; Jump if carry flag is set (error)
jmp no_error     ; Continue if no error

read_error:
; Handle error here - this could involve printing an error message and halting
mov ah, 0x0e
mov al, 'D'      ; Display an 'E' for error
int 0x10
mov al, 'i'      ; Display an 'E' for error
int 0x10
mov al, 's'      ; Display an 'E' for error
int 0x10
mov al, 'k'      ; Display an 'E' for error
int 0x10
mov al, ' '      ; Display an 'E' for error
int 0x10
mov al, 'R'      ; Display an 'E' for error
int 0x10
mov al, 'e'      ; Display an 'E' for error
int 0x10
mov al, 'a'      ; Display an 'E' for error
int 0x10
mov al, 'd'      ; Display an 'E' for error
int 0x10
mov al, ' '      ; Display an 'E' for error
int 0x10
mov al, 'E'      ; Display an 'E' for error
int 0x10
mov al, 'r'      ; Display an 'E' for error
int 0x10
mov al, 'r'      ; Display an 'E' for error
int 0x10
mov al, 'o'      ; Display an 'E' for error
int 0x10
mov al, 'r'      ; Display an 'E' for error
int 0x10
jmp $            ; Hang the system or loop back to retry

no_error:
;jmp $ ;safety sake


jmp BOOT2_LOCATION





    ret

;serial_init is a function
serial_init:
    mov dx, 0x3F8 + 1  ; Interrupt enable register
    mov al, 0x00       ; Disable interrupts
    out dx, al

    mov dx, 0x3F8 + 3  ; Line control register
    mov al, 0x80       ; Enable DLAB (Divisor Latch Access Bit)
    out dx, al

    mov dx, 0x3F8      ; Baud rate divisor (low byte)
    mov al, 0x01       ; 115200 baud (divisor = 1)
    out dx, al

    mov dx, 0x3F8 + 1  ; Baud rate divisor (high byte)
    mov al, 0x00
    out dx, al

    mov dx, 0x3F8 + 3  ; Line control register
    mov al, 0x03       ; 8 bits, no parity, one stop bit
    out dx, al

    mov dx, 0x3F8 + 2  ; FIFO control register
    mov al, 0xC7       ; Enable FIFO, clear buffers, 14-byte threshold
    out dx, al

    mov dx, 0x3F8 + 4  ; Modem control register
    mov al, 0x0B       ; Enable IRQs, RTS/DSR set
    out dx, al
    ret

;serial_send is a function
serial_send:
    mov dx, 0x3F8 + 5  ; Line status register
wait_transmit:
    in al, dx
    test al, 0x20      ; Check if Transmit Buffer Empty (bit 5)
    jz wait_transmit   ; Wait if not empty

    mov dx, 0x3F8      ; COM1 Data Register
    mov al, 'A'        ; Example: Send character 'A'
    out dx, al
    ret

;serial_send_string is a function
serial_send_string:
    lodsb               ; Load next byte from string
    test al, al         ; Check for null terminator
    jz done
    call serial_send    ; Send character
    jmp serial_send_string
done:
    ret

BOOT_DISK: db 0
times 510-($-$$) db 0
dw 0xaa55



