[bits 16]
[org 0x7c00]

; =============================================================================
; СЕКТОР 1: STAGE 1
; =============================================================================
stage1_start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti
    mov [boot_drive], dl
    xor ax, ax
    mov dl, [boot_drive]
    int 0x13
    jc .err
    mov ah, 0x02
    mov al, 4
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [boot_drive]
    mov bx, 0x7E00
    int 0x13
    jnc jump_to_stage2
.err:
    mov si, msg_disk_err
.err_loop:
    lodsb
    test al, al
    jz $
    mov ah, 0x0E
    int 0x10
    jmp .err_loop
jump_to_stage2:
    mov dl, [boot_drive]
    jmp 0x0000:0x7E00
boot_drive db 0
msg_disk_err db "Disk Error!",0
times 510-($-$$) db 0
dw 0xaa55

; =============================================================================
; СЕКТОР 2+: STAGE 2
; =============================================================================
stage2_start:
    cld
    mov [sys_drive], dl
    mov ah, 0x02
    mov al, 1
    mov ch, 0
    mov cl, 6
    mov dh, 0
    mov dl, [sys_drive]
    mov bx, stored_pass
    int 0x13
    call xor_crypt
    call init_mode_green
    cmp word [stored_sig], 0x5359
    je show_splash

do_installer:
    call init_mode_green
    mov si, tui_install_win
    call print
    mov si, msg_prompt_pass
    call print
    mov di, stored_pass
    mov cx, 14
    mov dl, '*'
    call read_line
    mov word [stored_sig], 0x5359
    call xor_crypt
    mov ah, 0x03
    mov al, 1
    mov ch, 0
    mov cl, 6
    mov dh, 0
    mov dl, [sys_drive]
    mov bx, stored_pass
    int 0x13
    call xor_crypt
    mov si, msg_saving
    call print
    mov ah, 0x00
    int 0x16

show_splash:
    call init_mode_green
    mov si, logo
    call print
    mov si, splash_image
    call print
    mov si, msg_load
    call print
    mov cx, 20
.bar_loop:
    push cx
    mov ah, 0x0E
    mov al, 0xDB
    int 0x10
    mov ax, 0x8600
    mov cx, 0x0001
    mov dx, 0x86A0
    int 0x15
    pop cx
    loop .bar_loop
    mov si, newline
    call print
    mov si, msg_boot
    call print
    mov ax, 0x8600
    mov cx, 0x0001
    mov dx, 0x86A0
    int 0x15

do_lockscreen:
    call init_mode_green
    mov si, tui_lock_win
    call print
    mov si, msg_prompt_pass
    call print
    mov di, input_pass
    mov cx, 14
    mov dl, '*'
    call read_line
    mov si, input_pass
    mov di, stored_pass
    call strcmp
    jnc .failed
    call init_mode_green
    mov si, msg_welcome
    call print
    jmp next_prompt
.failed:
    mov si, msg_denied
    call print
    mov ah, 0x00
    int 0x16
    jmp do_lockscreen

next_prompt:
    mov di, cmd_buffer
    mov si, prompt
    call print
keyboard_loop:
    mov ah, 0x00
    int 0x16
    cmp al, 8
    je backspace
    cmp al, 13
    je enter_pressed
    cmp al, 27
    je next_prompt
    cmp di, cmd_buffer + 30
    jge keyboard_loop
    mov [di], al
    inc di
    mov ah, 0x0E
    int 0x10
    jmp keyboard_loop
backspace:
    cmp di, cmd_buffer
    je keyboard_loop
    dec di
    mov byte [di], 0
    mov si, bs_str
    call print
    jmp keyboard_loop
enter_pressed:
    mov byte [di], 0
    mov si, newline
    call print
    cmp di, cmd_buffer
    je next_prompt
    mov si, cmd_buffer
    mov di, cmd_help
    call strcmp
    jc do_help
    mov si, cmd_buffer
    mov di, cmd_reboot
    call strcmp
    jc do_reboot
    mov si, cmd_buffer
    mov di, cmd_cls
    call strcmp
    jc do_cls
    mov si, cmd_buffer
    mov di, cmd_progs
    call strcmp
    jc do_progs
    mov si, cmd_buffer
    mov di, cmd_calc
    call strcmp
    jc do_calc
    mov si, cmd_buffer
    mov di, cmd_echo
    call strcmp
    jc do_echo
    mov si, cmd_buffer
    mov di, cmd_date
    call strcmp
    jc do_date
    mov si, cmd_buffer
    mov di, cmd_ver
    call strcmp
    jc do_ver
    mov si, cmd_buffer
    mov di, cmd_whoami
    call strcmp
    jc do_whoami
    mov si, cmd_buffer
    mov di, cmd_info
    call strcmp
    jc do_info
    mov si, msg_unknown
    call print
    jmp next_prompt

do_help:
    mov si, msg_help
    call print
    jmp next_prompt
do_info:
    mov si, msg_info
    call print
    jmp next_prompt
do_reboot:
    jmp 0xFFFF:0000
do_cls:
    call init_mode_green
    jmp next_prompt
do_progs:
    mov si, msg_progs
    call print
    jmp next_prompt
do_calc:
    mov si, msg_calc_prompt
    call print
    mov di, calc_buffer
    mov cx, 20
    xor dl, dl
    call read_line
    call parse_calc
    jmp next_prompt
do_echo:
    mov si, cmd_buffer + 5
    call print
    mov si, newline
    call print
    jmp next_prompt
do_date:
    mov si, msg_date
    call print
    jmp next_prompt
do_ver:
    mov si, msg_version
    call print
    jmp next_prompt
do_whoami:
    mov si, msg_whoami
    call print
    jmp next_prompt

parse_calc:
    mov si, calc_buffer
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx
.skip_spaces:
    lodsb
    cmp al, ' '
    je .skip_spaces
    cmp al, 0
    je .done
    xor bx, bx
.get_num1:
    cmp al, ' '
    je .op_found
    cmp al, '+'
    je .op_found
    cmp al, '-'
    je .op_found
    cmp al, '*'
    je .op_found
    cmp al, '/'
    je .op_found
    cmp al, 0
    je .done
    sub al, '0'
    mov bl, al
    mov ax, bx
    lodsb
    jmp .get_num1
.op_found:
    mov [operation], al
    lodsb
    cmp al, ' '
    je .op_found
    xor cx, cx
.get_num2:
    cmp al, ' '
    je .calc
    cmp al, 0
    je .calc
    sub al, '0'
    mov cl, al
    mov dx, cx
    lodsb
    jmp .get_num2
.calc:
    mov al, [operation]
    cmp al, '+'
    je .add
    cmp al, '-'
    je .sub
    cmp al, '*'
    je .mul
    cmp al, '/'
    je .div
    jmp .done
.add:
    mov ax, bx
    add ax, dx
    call print_num
    jmp .done
.sub:
    mov ax, bx
    sub ax, dx
    call print_num
    jmp .done
.mul:
    mov ax, bx
    mul dx
    call print_num
    jmp .done
.div:
    mov ax, bx
    cmp dx, 0
    je .div_zero
    div dx
    call print_num
    jmp .done
.div_zero:
    mov si, msg_div_zero
    call print
    jmp .done
.done:
    mov si, newline
    call print
    ret
operation db 0

print_num:
    push ax
    push bx
    push cx
    push dx
    mov cx, 0
    mov bx, 10
.convert:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz .convert
.print_digits:
    pop ax
    add al, '0'
    mov ah, 0x0E
    int 0x10
    loop .print_digits
    pop dx
    pop cx
    pop bx
    pop ax
    ret

xor_crypt:
    mov bx, stored_pass
    mov cx, 14
.loop:
    xor byte [bx], 0x5A
    inc bx
    loop .loop
    ret

init_mode_green:
    mov ax, 0x0003
    int 0x10
    mov ax, 0x1000
    mov bl, 0x02
    int 0x10
    ret

print:
    lodsb
    test al, al
    jz .d
    mov ah, 0x0E
    int 0x10
    jmp print
.d:
    ret

read_line:
    xor bx, bx
.loop:
    mov ah, 0x00
    int 0x16
    cmp al, 8
    je .bs
    cmp al, 13
    je .done
    cmp bx, cx
    jge .loop
    mov [di], al
    inc di
    inc bx
    mov ah, 0x0E
    cmp dl, 0
    je .echo
    mov al, dl
.echo:
    int 0x10
    jmp .loop
.bs:
    test bx, bx
    jz .loop
    dec di
    dec bx
    mov byte [di], 0
    mov si, bs_str
    call print
    jmp .loop
.done:
    mov byte [di], 0
    mov si, newline
    call print
    ret

strcmp:
    push si
    push di
.l:
    lodsb
    scasb
    jne .different
    test al, al
    jnz .l
    pop di
    pop si
    stc
    ret
.different:
    pop di
    pop si
    clc
    ret

; =============================================================================
; ДАННЫЕ (СОКРАЩЕНЫ ДЛЯ ЭКОНОМИИ МЕСТА)
; =============================================================================
sys_drive db 0

logo db 13,10,' ',0xDC,0xDB,0xDB,0xDB,0xDB,13,10,' ',0xDB,13,10
     db ' ',0xDB,13,10,' ',0xDB,13,10,' ',0xDF,0xDB,0xDB,0xDB,0xDB,13,10,0

splash_image db '       .-----------------------.',13,10
             db '       |  ___________________  |',13,10
             db '       | |                   | |',13,10
             db '       | |     SYSTEM OS     | |',13,10
             db '       | |    WELCOME TO     | |',13,10
             db '       | |     THE CORE      | |',13,10
             db '       | |___________________| |',13,10
             db '       |_______________________|',13,10
             db '                   ||           ',13,10
             db '                -------         ',13,10,0

prompt db 13,10,'> ',0
newline db 13,10,0
bs_str db 8,' ',8,0

cmd_help db 'help',0
cmd_reboot db 'reboot',0
cmd_cls db 'cls',0
cmd_progs db 'progs',0
cmd_calc db 'calc',0
cmd_echo db 'echo',0
cmd_date db 'date',0
cmd_ver db 'ver',0
cmd_whoami db 'whoami',0
cmd_info db 'info',0

tui_install_win db '+-----------------------------+',13,10
                db '|     SYSTEM OS INSTALLER     |',13,10
                db '+-----------------------------+',13,10,0

tui_lock_win db '+-----------------------------+',13,10
             db '|      SYSTEM OS LOCKED       |',13,10
             db '+-----------------------------+',13,10,0

msg_prompt_pass db 'Pass: ',0
msg_denied db 13,10,'Denied! Press key...',13,10,0
msg_welcome db 13,10,'Welcome!',13,10,0
msg_boot db 'Ready.',13,10,0
msg_saving db 13,10,'Saving... Press any key',0

msg_help db '+=======HELP=======+',13,10
         db '|help  - this menu |',13,10
         db '|cls   - clear     |',13,10
         db '|reboot - restart  |',13,10
         db '|progs - programs  |',13,10
         db '|calc  - calc      |',13,10
         db '|echo  - print     |',13,10
         db '|date  - date      |',13,10
         db '|ver   - version   |',13,10
         db '|whoami- user      |',13,10
         db '|info  - info      |',13,10
         db '+=================+',13,10,0

msg_unknown db 'Unknown cmd',13,10,0

msg_progs db '+=====PROGS=====+',13,10
          db '| help  progs  |',13,10
          db '| calc  echo   |',13,10
          db '| date  ver    |',13,10
          db '| whoami info  |',13,10
          db '+==============+',13,10,0

msg_calc_prompt db 13,10,'Calc (5+3): ',0
msg_div_zero db 'Err: /0',13,10,0
msg_date db 13,10,'2026-06-17 14:30',13,10,0
msg_version db 13,10,'SYSTEM OS v0.1',13,10,0
msg_whoami db 13,10,'User: system',13,10,0

msg_info db '====================',13,10
         db 'SYSTEM INFORMATION',13,10
         db '====================',13,10
         db 'OS: comOS',13,10
         db 'Version: 0.1',13,10
         db 'Build: 2026',13,10
         db 'Arch: x86 16-bit',13,10
         db '====================',13,10,0

msg_load db 'Loading: ',0

input_pass times 16 db 0
cmd_buffer times 32 db 0
calc_buffer times 20 db 0
stored_pass times 16 db 0
stored_sig times 2 db 0

times 3072-($-$$) db 0