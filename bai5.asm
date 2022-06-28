.model small
.stack 100h
.data
    tb1 db 'nhap chuoi so:$' ; cach nhau boi dau phay
    tb2 db 10,13,'so phan tu am:$'
    tb3 db 10,13,'so phan tu duong:$'
    tong dw 1 
    tmp dw ? 
    soAm dw 0 
    soDuong dw ?
    chuoi db 100,0,100 dup(0)
.code
main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,tb1
    int 21h
    
    lea si,chuoi  
    mov cx,0
    nhap:
    mov ah,1
    int 21h
    mov [si],al
    inc cx
    cmp al,13
    je thoat
    inc si
    jmp nhap
    
    thoat:
    lea si,chuoi  
    mov tmp,cx
    tinh:    
    cmp cx,0
    je nhay
    xor ax,ax
    mov al,[si]
    cmp al,44
    je dem
    cmp al,45
    je am
    inc si
    dec cx
    jmp tinh
    
    dem:
    mov ax,tong
    inc ax
    mov tong,ax
    inc si
    dec cx
    jmp tinh
    
    am:
    mov ax,soAm
    inc ax
    mov soAm,ax
    inc si
    dec cx
    jmp tinh
    
    nhay: 
    mov ax,tong
    mov bx,soAm
    sub ax,bx
    mov soDuong,ax 
    
    mov ah,9
    lea dx,tb2
    int 21h
    
    mov ax,soAm
    call ht
    
    mov ah,9
    lea dx,tb3
    int 21h
    
    mov ax,soDuong
    call ht
    
    mov ah,4ch
    int 21h
main endp 

ht proc
    mov bx,10 
    mov cx,0
    chia:
    mov dx,0
    div bx
    inc cx
    push dx
    cmp ax,0
    je ou
    jmp chia
    
    ou:   
    xor dx,dx
    cmp cx,0
    je ex
    pop dx
    add dl,48
    mov ah,2
    int 21h 
    dec cx
    jmp ou
    
    ex:
    ret
ht endp
end main