[org 0x7c00]
_start:
    jmp main                         ; Jump to the main bootloader code
    times (3 - ($ - _start)) db 0    ; Fill to ensure the BPB starts at the correct position

    ; BPB for a 2.88MB floppy (FAT12)
    OEMname:            db "MYBOOT  "   ; OEM name (8 bytes)
    bytesPerSector:     dw 512          ; Bytes per sector
    sectPerCluster:     db 1            ; Sectors per cluster
    reservedSectors:    dw 1            ; Reserved sectors
    numFAT:             db 2            ; Number of FAT tables
    numRootDirEntries:  dw 240          ; Number of root directory entries
    numSectors:         dw 5760         ; Total sectors (small value)
    mediaType:          db 0xF0         ; Media descriptor
    numFATsectors:      dw 9            ; Sectors per FAT
    sectorsPerTrack:    dw 36           ; Sectors per track
    numHeads:           dw 2            ; Number of heads
    numHiddenSectors:   dd 0            ; Hidden sectors
    numSectorsHuge:     dd 0            ; Large sector count (not used for floppy)
    driveNum:           db 0            ; Drive number
    reserved:           db 0x00         ; Reserved
    signature:          db 0x29         ; Boot signature
    volumeID:           dd 0x54428E71   ; Volume ID (randomly chosen)
    volumeLabel:        db "NO NAME    " ; Volume label (11 bytes, space-padded)
    fileSysType:        db "FAT12   "   ; Filesystem type (8 bytes, space-padded)

main:
;dl always contains what disk is the boot disk, we wanna save this (after testing, i've found that al & ah also often contain values on startup, but idk what for and google says they're unreliable)
mov [BOOT_DISK], dl

mov ah, 0x0e
;check that boot_disk == dl like it should, and that dl does not equal 0
cmp dl, [BOOT_DISK]
jne dl_err
jmp not_dl_err
dl_err:
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
jmp $
not_dl_err:

;check that the bios recognises our disk (it should, if we're here)
mov bx, 0x0475      ;the address of the "number of disks" section of the BDA,, it's just one byte

mov byte al, [bx]
cmp al, 0
jz bios_disk_recognition_error
jmp not_bios_disk_recognition_error
;this only runs if the BIOS Data Area (BDA) section for the number of disks is equal to zero (which should literally NEVER happen). Doesn't stop execution, but the warning is visible for if/when the disk read error pops up
bios_disk_recognition_error:
mov al, 'B'
int 0x10
mov al, 'I'
int 0x10
mov al, 'O'
int 0x10
mov al, 'S'
int 0x10
mov al, ' '
int 0x10
mov al, 'e'
int 0x10
mov al, 'r'
int 0x10
mov al, 'r'
int 0x10
not_bios_disk_recognition_error:


cmp dl, 0
jz dl_is_zero
jmp dl_not_zero
dl_is_zero:
mov al, 'd'
int 0x10
mov al, 'l'
int 0x10
mov al, '='
int 0x10
mov al, '0'
int 0x10
;jmp $
dl_not_zero:

            ; NOTE: the below segment of commented out code is here only for debugging, its not very good either so just ignore it
;mov ah, 0x0e
;mov al, 'd'
;int 0x10
;mov al, 'l'
;int 0x10
;mov al, ''
;int 0x10
;mov al, '!'
;int 0x10
;mov al, '='
;int 0x10
;mov al, '0'
;int 0x10
;
;mov al, 0x0A    ;print a newline
;int 0x10
;mov al, 0x0D
;int 0x10
;mov al, 0x0A    ;print a newline
;int 0x10
;mov al, 0x0D
;int 0x10
;
;sub_64_from_al:
;mov al, 'd'
;int 0x10
;mov al, 'l'
;int 0x10
;mov al, ''
;int 0x10
;mov al, '-'
;int 0x10
;mov al, ' '
;int 0x10
;mov al, '6'
;int 0x10
;mov al, '4'
;int 0x10
;mov al, ':'
;int 0x10
;mov al, 0x0A    ;print a newline
;int 0x10
;mov al, 0x0D
;int 0x10
;;sub 64
;mov al, dl
;sub al, 64
;;print
;mov ah, 0x0e
;int 0x10       ; Print the character
;;newlines
;mov al, 0x0A    ;print a newline
;int 0x10
;mov al, 0x0D
;int 0x10
;mov al, 0x0A    ;print a newline
;int 0x10
;mov al, 0x0D
;int 0x10
;
;comparisons:
;mov dl, [BOOT_DISK]
;
;cmp dl, 0
;jz null
;cmp dl, 128
;je dl_equals_128
;cmp dl, 0x20
;jle less_than_32
;cmp dl, 32
;jge greater_than_32
;jmp $
;
;null:
;mov al, 'n'
;int 0x10
;mov al, 'u'
;int 0x10
;mov al, 'l'
;int 0x10
;mov al, 'l'
;int 0x10
;jmp load_disk
;
;dl_equals_128:
;mov al, 'd'
;int 0x10
;mov al, 'l'
;int 0x10
;mov al, '='
;int 0x10
;mov al, '1'
;int 0x10
;mov al, '2'
;int 0x10
;mov al, '8'
;int 0x10
;jmp load_disk
;
;less_than_32:
;mov al, 'd'
;int 0x10
;mov al, 'l'
;int 0x10
;mov al, '<'
;int 0x10
;mov al, '='
;int 0x10
;mov al, '3'
;int 0x10
;mov al, '2'
;int 0x10
;jmp load_disk
;
;greater_than_32:
;mov al, 'd'
;int 0x10
;mov al, 'l'
;int 0x10
;mov al, '>'
;int 0x10
;mov al, ' '
;int 0x10
;mov al, '3'
;int 0x10
;mov al, '2'
;int 0x10
;jmp load_disk
;
;simple_display:
;mov al, dl
;int 0x10
;
;
;load_disk:
;
;mov al, 0x0A    ;print a newline
;int 0x10
;mov al, 0x0D
;int 0x10

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
disk_load:
mov bx, BOOT2_LOCATION     ;location to load into memory
mov ah, 0x02    ;ah must be 2. i do not know why ah must be 2. but ah must be 2.
mov al, 0x25    ;number of sectors we want to read
mov ch, 0x00    ;cylinder #
mov dh, 0x00    ;head #
mov cl, 0x02    ;sector #
mov dl, [BOOT_DISK]     ;disk ID (ig thats what you call it)

int 0x13         ; Interrupt for disk read
jc alt_disk_load    ; Jump if carry flag is set (error)
jmp no_error     ; Continue if no error


no_error:
;jmp $ ;safety sake

jmp BOOT2_LOCATION

;to try different methods of loading the disk. If none work, continues directly into read_error; if any DO work, jumps to no_error
alt_disk_load:
;we can attempt again here, perhaps with `int 0x13 & ah=0x42 drive#=0x80`?

;we know the carry flag was set... saving other flags set after AH=0x02 failed
mov [0x600], ah     ;return code (http://www.techhelpmanual.com/205-bios_disk_error_codes.html)
mov [0x601], al     ;actual sectors read count

; find info on drive emulation for our drive -- INT 13h AH=4Bh (https://en.wikipedia.org/wiki/INT_13H#INT_13h_AH=48h:_Extended_Read_Drive_Parameters) <-- FINISH
mov [0x602], si     ;save the value of si
mov si, 0x700       ;DS:SI: points to an empty structure for result. (must be 13h in size) (DS is already 0, we set it way up there ^) (the data structure will be 0x13 bytes long, ie 19-20 bytes i think)
mov al, 0x01        ;i do not know why this must be 01
mov dl, [BOOT_DISK]
mov ah, 0x4B
int 0x13
mov si, [0x602]
;interpret the data we threw into [0x700], do something with it ig to print more info to console?


;attempt extended read with INT 13h AH=42h, who knows maybe it'll work

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


BOOT_DISK: db 0
BOOT2_LOCATION equ 0xC00
times 510-($-$$) db 0
dw 0xaa55