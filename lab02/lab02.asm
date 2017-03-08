# Find longest word in a string
#   in MIPS assembly using MARS
# for MYΥ-402 - Computer Architecture
# Department of Computer Engineering, University of Ioannina
# Aris Efthymiou

        .globl main # declare the label main as global. 
        
        .text 
     
main:
        la         $a0, string         # The address of the string
        addu       $v1, $zero, $a0     # The address of longest word
		add        $t0 , $zero , $zero #t0 = temp variable
		add        $t1 , $zero , $zero #i variable
		add        $t2 , $zero , $zero #t2 = counter
		addi       $t5 , $zero , 32    #used later to search for null
loop:
		add	       $t3 , $a0 , $t1
		lb         $t4 , 0($t3)        #ao[i]
		beq        $t4 , $zero , exitloop  #if ao[i] == 0 (the string is empty)
		beq        $t4 , $t5 , else    #if a0[i] == 32 (null)
		addi       $t2 , $t2 , 1       #increasing the counter and i by 1 so it moves to the next byte
		addi       $t1 , $t1 , 1
		j loop                         #while loop
else:
		slt        $s0 , $t2 , $t0     #if temp < counter , a word with length greater than temp , new max length 
		bne        $s0 , $zero , skip  
		add        $t0 , $t2 , $zero   #temp becomes counter 
		sub        $a1 , $t1 , $t2     #subtracting i-counter to find the starting position of the max word 
		addu       $v1 , $a1 , $a0    
skip:
		addi       $t1 , $t1 , 1
		add        $t2 , $zero , $zero #counter becomes zero so t can start counting the length of the upcoming word
		j loop
exitloop:
		slt        $s0 , $t2 , $t0     #if temp < counter , a word with length greater than temp , new max length 
		bne        $s0 , $zero , exit  
		add        $t0 , $t2 , $zero   #temp becomes counter 
		sub        $a1 , $t1 , $t2     #subtracting i-counter to find the starting position of the max word 
		addu       $v1 , $a1 , $a0            
exit: 
        addiu      $v0, $zero, 10    # system service 10 is exit
        syscall                      # we are outta here.
        
        ###############################################################################
        # Data input.
        ###############################################################################
        .data
string: .asciiz "small  equal long atTheEnd"