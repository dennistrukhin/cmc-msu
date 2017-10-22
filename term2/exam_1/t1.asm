include io.asm
stk segment stack
  db 128 dup (?)
stk ends
data segment
  str_input db "Enter your sentence: $"
  str_snt db "Sentence: $"
  str_snt_length db "Length: $"
  current_char db ?
  ; В конце строки при необходимости добавим $, чтобы выводить
  ; командой outstr. Поэтому размер на 1 байт больше
  sentence db 101 dup (52)
  sentence_length dw 0
data ends
code segment
assume cs:code,ds:data,ss:stk
start:
  mov ax,data
  mov ds,ax

  ; Получим текст
  call far ptr get_sentence
  ; Выведем текст на экран
  call far ptr print_orig_sentence
  ; Проверим, обладает ли текст свойством:
  ; Текст оканчивается на заглавную латинскую букву,
  ; которая больше не встречается в тексте
  mov ax, seg sentence
  push ax
  lea ax, sentence
  push ax
  mov ax, sentence_length
  push ax
  call far ptr sentence_has_property_1
  mov ax, 0
  cmp ax, dx
  je rule2

  ; Первое правило: поменять все 1-9 на соответствующие a-...
  mov ax, seg sentence
  push ax
  lea ax, sentence
  push ax
  mov ax, sentence_length
  push ax
  call far ptr rule_1
  jmp program_finish

rule2:
  ; Второе правило: Заменить группы повторяющихся литер одной из них
  mov ax, seg sentence
  push ax
  lea ax, sentence
  push ax
  mov ax, sentence_length
  push ax
  call far ptr rule_2

program_finish:
  call far ptr print_orig_sentence
  finish


get_sentence proc far
  push bp
  mov bp,sp
  push dx
  push bx
  lea dx, str_input
  outstr

  lea bx, sentence
input_start:
  inch current_char
  mov dl, current_char
  cmp dl, '.'
  je input_end
  mov [bx], dl
  inc bx
  jmp input_start
input_end:
  mov [bx], byte ptr '$'

  lea dx, sentence
  sub bx, dx
  mov sentence_length, bx

  pop bx
  pop dx
  pop bp
  ret
get_sentence endp


print_orig_sentence proc far
  push bp
  mov bp,sp
  push dx

  lea dx, str_snt
  outstr
  lea dx, sentence
  outstr
  newline
  ;lea dx, str_snt_length
  ;outstr
  ;outword sentence_length
  ;newline

  pop dx
  pop bp
  ret
print_orig_sentence endp


sentence_has_property_1 proc far
  push bp
  mov bp, sp
  
  push bx
  push ax
  push di
  ; В bp+6 у нас длина строки
  ; В bp+8 у нас адрес начала строки
  mov bx, [bp+8]
  ; Попадём в конец строки
  add bx, [bp+6]
  ; Перейдём в последний символ
  sub bx, 1
  mov di, bx
  mov ax, 0
  ; Нужно вытащить ровно один байт, поэтому отправим в AL, а не в AX
  mov al, [di]
  ; Теперь у нас в AX лежит код последнего символа строки
  ; Убедимся, что последний символ - заглавная буква
  mov dx, 0
  mov bx, 'A'
  cmp ax, bx
  jl propery_finish
  mov bx, 'Z'
  cmp ax, bx
  jg propery_finish
  ; Если мы тут, значит, последний символ - заглавная буква
  ; Убедимся, что кроме неё нет других таких же
  
  mov dx, 1

propery_finish:
  pop di
  pop ax
  pop bx
  pop bp
  ret 6
sentence_has_property_1 endp


rule_1 proc far
  push bp
  mov bp, sp
  
  push cx
  push bx
  push ax
  push di
  push Si
  ; В bp+6 у нас длина строки
  ; В bp+8 у нас адрес начала строки
  mov bx, 0
  mov ax, [bp+6]
  mov si, [bp+8]
change_char:
  ; Прверим, находимся ли мы внутри строки
  cmp bx, ax
  jge end_rule_1

  ; текущий символ
  mov di, si
  add di, bx

  mov cx, 0
  ; Сравним текущий символ с 0 и 9
  mov cl, '9'
  cmp cl, [di]
  jl not_number
  mov cl, '0'
  cmp cl, [di]
  jg not_number
  mov cl, [di]
  sub cl, '0'
  add cl, 'A'
  mov [di], byte ptr cl

not_number:
  inc bx

  jmp change_char

end_rule_1:
  pop si
  pop di
  pop ax
  pop bx
  pop cx
  pop bp
  ret 6
rule_1 endp


rule_2 proc far
  push bp
  mov bp, sp
  
  push cx
  push bx
  push ax
  push di
  push si

  ; В bp+6 у нас длина строки
  ; В bp+8 у нас адрес начала строки
  mov cx, 0
  mov dx, [bp+6]
  mov di, [bp+8]
  mov si, [bp+8]
  ; В di у нас будет последний "правильный" символ рассматриваемоый строки
  ; В si - новый символ, который мы рповеряем на повторяемость

compare_two:
  cmp dx, cx
  je end_rule2
  ; Строка ещё не закончилась
  ; Смотрим на следуюий симсол
  inc si
  mov ax, 0
  mov bx, 0
  mov al, byte ptr [di]
  mov bl, byte ptr [si]
  outint ax
  outch ' ' 
  outint bx
  newline 
  cmp al, bl
  je equal

  inc di
  mov al, byte ptr [si]
  mov [di], byte ptr al
equal:
  sub dx, 1
  jmp compare_two

end_rule2:

  pop si
  pop di
  pop ax
  pop bx
  pop cx
  pop bp
  ret 6
rule_2 endp


code ends

end start
