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
  ; командой outstr. Поэтому размер на 1 байт больше: 20*8 + 19 + 1
  sentence db 180 dup (' ')
  sentence_length dw 0
  heap db 200 dup (0)

  node struc
   elem db 8 dup (' ')
   next dd 1 dup (0)
  node ends

  heap_offset dw 0
  heap_size db 0
  list dw 0

data ends
code segment
assume cs:code,ds:data,ss:stk
start:
  mov ax,data
  mov ds,ax

  ; Получим текст
  call far ptr get_sentence
  lea di, sentence

  mov heap_size, 0
  mov bl, 0 ; Если здесь 1, то это было последнее слово

import_word:
  lea si, heap
  add si, heap_offset
import_char:
  mov ax, 0
  mov al, ','
  cmp [di], al
  je next_word
  mov al, '.'
  cmp [di], al
  je process_last_word
  outch [di]
  mov al, byte ptr [di]
  mov [si], al

  jmp next_char

process_last_word:
  mov bl, 1
  jmp next_word

next_char:
  inc si
  inc di
  jmp import_char
next_word:
  ; Посчитаем, больше какого количества имеющихся строк текущая строка больше
  mov dx, 0 ; В dx будем хранить количетсво строк, которые меньше текущей
  mov ax, 0
next_string:
  cmp ax, heap_offset
  jge end_count_calc

  ; Пройдёмся в цикле по текущей строке и сравним её с одной из имеющихся строк
  push di
  push si

  lea si, heap
  add si, heap_offset ; si указывает на начало текущей строки
  lea di, heap
  add di, ax ; di указывает на начало строки, с которой сравниваем текущую

  mov cl, 0 ; Счётчик для прохода по 8 символам строк
compare_current:
  mov ch, byte ptr [di]
  cmp [si], ch
  jl current_less
  cmp [si], ch
  je current_equal
  inc dx
  mov cl, 9
  jmp current_next

current_less:
  mov cl, 9
  jmp current_next
current_equal:
  jmp current_next
current_next:
  inc si
  inc di
  inc cl
  cmp cl, 8
  jl compare_current

  pop si
  pop di

  add ax, 10
  jmp next_string
end_count_calc:
  outch '('
  outint dx
  outch ')'
  ; Теперь у нас в dx количество строк, которые меньше текущей
  ; Значит, мы можем воткнуть текущую строку в нужное место в списке
  ; Если heap_offset == 0, то это самая первая строка, и мы просто ставим её в начало кучи
  ; При этом вместо адреса следующей строки записываем 0
  cmp heap_offset, 0
  jne not_first_string
  ; Итак, у нас первая строка
  lea cx, heap
  mov list, cx
  push di
  lea di, heap
  add di, 8
  mov [di], word ptr 0
  pop di
  jmp append_finish
  
not_first_string:
  ; Строка начинается в heap_offset. Запомним её адрес.
  ; Нам нельзя портить si, di, bx, dx, отправим в стек пока что
  push di
  push si
  push bx
  push ax

  mov ax, 0; Это порядковый номер строки в куче
  lea di, list; Это адрес указателя на первую строку в куче
  outch 'L'
  outint word ptr di
  outch 'S'
  outword word ptr [di]
append_next_string:
  outch '+'
  cmp ax, dx
  je do_append
  inc ax
  ; di указывает на адрес начала текущей строки
  mov bx, word ptr [di] ; в bx - адрес начала строки из кучи
  add bx, 8; в bx - адрес, где записан адрес следующей строки в куче
  mov di, bx
  outch 'A'
  outword di
  jmp append_next_string


do_append:
; di указывает на начало той строки, перед которой надо добавить текущую
; теперь di должен начать указывать на начало текущей строки
; а текущая строка должна указывать на то, на что раньше указывал di
  outch 'D' ; Адрес, который должен ссыться на нашу строку
  outword di
  lea si, heap
  add si, heap_offset
  add si, 8
  ; в si у нас - адрес следующей строки после текущей.
  mov cx, word ptr [di]
  mov [si], cx ; теперь после нашей текущей строки идёт следующая по счёту из кучи
  outch 'N'
  outword word ptr [si]

  lea cx, heap
  add cx, heap_offset ; теперь cx указывает на нашу текущую строку
  outch 'C'
  outword cx
  mov [di], cx
  pop ax
  pop bx
  pop si
  pop di

append_finish:
  ; Итак, мы воткнули строку, куда надо. Либо работает со следующей, либо завершаем это всё и печатаем результат
  cmp bl, 1
  je list_finish
  inc si
  inc di
  add heap_offset, 10
  jmp import_word

list_finish:
  ; Теперь пришло время напечатать результат
  newline
  newline
  mov di, list
print_next_word:
  mov ax, 0
print_next_char:
  outch [di]
  inc di
  inc ax
  cmp ax, 8
  jl print_next_char
  outch '-'
  outword word ptr [di]
  mov ax, 0
  cmp ax, word ptr [di]
  je print_finished
  mov ax, word ptr [di]
  mov di, ax
  jmp print_next_word

print_finished:
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
  mov [bx], dl
  inc bx
  cmp dl, '.'
  je input_end
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


code ends

end start
