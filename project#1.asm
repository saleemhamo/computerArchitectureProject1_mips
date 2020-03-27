########################################### Project 1 ########################################### 
####  Done By:
####          Saleem Hamo - 1170381
####          Mohammad Abbas - 1170011

########################################### Data segment ########################################
.data
	command: .space 20               #Command
	command_line: .space 100         #Command entered by user
	command_length: .byte 100 	#max command length used in this project
	
	path: .asciiz "computerArchitecture@project1:~$ "           #current path
	
	
	
	
	string_length: .byte 100    #max string length used in this project
	
	filename: .asciiz "C:\\Users\\hp1\\Desktop\\Mars\\"
	File_name: .space 100       #array of 50 bytes for file name
	String_name: .space 100	  #array of 50 bytes for string name
	textSpace: .space 1050     #space to store strings to be read
	
	new_line: .asciiz "\n"       #new line notaion
	
	#messgaes for user
	msg_enter_file_name: .asciiz "Please enter file name: "
	msg_enter_string_name: .asciiz "Please enter string name: "
	error_message: .asciiz "Wrong input\n"
	
	
	
	#commands
	exit_command: .ascii "exit"
	echo_command: .ascii "echo"
	change_file_name_command: .ascii "File_name"
	change_string_name_command: .ascii "String_name"
	count_lines_command: .ascii "wc -l $File_name"
	count_words_command: .ascii "wc -w $String_name"
	grep_command: .ascii "grep $String_name $File_name"
	count_lines_after_grep_command: .ascii "grep $String_name $File_name | wc -l"
 	
 	#for wcho
 	buffer1: .space 250 
	buffer2: .space 250
	buffer3: .space 250 
	print_to_file_buffer: .space 500
	str_data_end:
	ctr: .word 0
	user_String: .byte 100
 	buffer_file: .asciiz "C:\\Users\\hp1\\Desktop\\Mars\\buffer_file.txt"
 	
########################################### Code segment ########################################  
.text
.globl main
	main:
	##### Read file name
	la    $a0, msg_enter_file_name	   	# display message 
        jal   display_message
        

	la	$a0, File_name 			# $a0 = address of file name
	jal	read
	
	jal adjust_file_name
	##### Read string name
	la    $a0, msg_enter_string_name 	# display message 
        jal   display_message

	
	la	$a0, String_name 		# $a0 = address of string name
	jal	read
	

	##################################################################

	
	Loop:
	
	#display path
	la    $a0, path	   	# path 
        jal   display_message
	
	
	la	$a0, command_line 	# read command
	jal	read
#####################################
		#enter



		la 	 $a0 , command_line  # pointer to the first character in the command line
		li       $t0 , '\n'
		lb       $t1 , ($a0)
		beq      $t1, $t0 , Loop



#################### exit command
		
		la 	 $a0 , command_line    		 # pointer to the first character in the command line
	check_exit:
		
		li       $t2 , 4	
		la 	 $a1 , exit_command      	 # pointer to the command
		L1:	
			beq     $t2 , $zero , else1	
			lb	$t0, ($a0)		# load  byte into $t2
			lb	$t1, ($a1)		# store byte into target
			addiu	$a0, $a0, 1		# increment source pointer
			addiu	$a1, $a1, 1		# increment target pointer
			subi    $t2, $t2, 1     		
			beq	$t0, $t1, L1 	# loop until space char
			j not_exit
	
		else1:
	 
			j exit
###############################################	
	
	not_exit:
	
	
	
#################### echo command
		
		la 	 $a0 , command_line    		 # pointer to the first character in the command line
	check_echo:
		
		li       $t2 , 4	
		la 	 $a1 , echo_command      		 # pointer to the command
		L2:	
			beq     $t2 , $zero , else2	
			lb	$t0, ($a0)		# load  byte into $t2
			lb	$t1, ($a1)		# store byte into target
			addiu	$a0, $a0, 1		# increment source pointer
			addiu	$a1, $a1, 1		# increment target pointer
			subi    $t2, $t2, 1     		
			beq	$t0, $t1, L2 	# loop until space char
			j not_echo
	
		else2:
		
			#addiu	$a0, $a0, 1	       	# increment source pointer
			li	$t2, ' '                # space means end of the command
			lb      $t1 , ($a0)
			bne	$t2, $t1, error 	# loop until space char
	 		addiu	$a0, $a0, 1	       	# increment source pointer
	 		jal echo
	 		
	 		j Loop
	 
###############################################	
	
	not_echo:
	
#################### Change File Name	

		la 	 $a0 , command_line    		 # pointer to the first character in the command line
	
		
		li       $t2 , 9	
		la 	 $a1 , change_file_name_command      	 # pointer to the command
		L3:	
			beq     $t2 , $zero , else3	
			lb	$t0, ($a0)		# load  byte into $t2
			lb	$t1, ($a1)		# store byte into target
			addiu	$a0, $a0, 1		# increment source pointer
			addiu	$a1, $a1, 1		# increment target pointer
			subi    $t2, $t2, 1     		
			beq	$t0, $t1, L3 	        # loop until space char
			j not_change_name
	
		else3:
	 		li	$t2, '='                # space means end of the command
			lb      $t1 , ($a0)
			bne	$t2, $t1, error 	# loop until space char
	 		addiu	$a0, $a0, 1	       	# increment source pointer
	 		
	 		
	 	
	 		jal change_file_name
	 		jal adjust_file_name
			j Loop
		
########################################			
		not_change_name:	
	
	
	
	
#################### Change String Name	

		la 	 $a0 , command_line    		 # pointer to the first character in the command line
	
		
		li       $t2 , 11	
		la 	 $a1 , change_string_name_command      	 # pointer to the command
		L4:	
			beq     $t2 , $zero , else4	
			lb	$t0, ($a0)		# load  byte into $t2
			lb	$t1, ($a1)		# store byte into target
			addiu	$a0, $a0, 1		# increment source pointer
			addiu	$a1, $a1, 1		# increment target pointer
			subi    $t2, $t2, 1     		
			beq	$t0, $t1, L4 	        # loop until space char
			j not_change_string
	
		else4:
	 		li	$t2, '='                # space means end of the command
			lb      $t1 , ($a0)
			bne	$t2, $t1, error 	# loop until space char
	 		addiu	$a0, $a0, 1	       	# increment source pointer
	 		
	 		
	 	
	 		jal change_string_name
	 		
			j Loop
			
########################################			
		not_change_string:	
		
	

#################### count words command
		
		la 	 $a0 , command_line    		 # pointer to the first character in the command line
	check_count_words:
		
		li       $t2 , 18	
		la 	 $a1 , count_words_command      	 # pointer to the command
		L6:	
			beq     $t2 , $zero , else6	
			lb	$t0, ($a0)		# load  byte into $t2
			lb	$t1, ($a1)		# store byte into target
			addiu	$a0, $a0, 1		# increment source pointer
			addiu	$a1, $a1, 1		# increment target pointer
			subi    $t2, $t2, 1     		
			beq	$t0, $t1, L6 	# loop until space char
			j not_count_words
	
		else6:
	 
			jal count_words
			
			j Loop
###############################################	
	
	not_count_words:
		
	
	
	
	

#################### count lines command
		
		la 	 $a0 , command_line    		 # pointer to the first character in the command line
	check_count_lines:
		
		li       $t2 , 16	
		la 	 $a1 , count_lines_command      	 # pointer to the command
		L7:	
			beq     $t2 , $zero , else7	
			lb	$t0, ($a0)		# load  byte into $t2
			lb	$t1, ($a1)		# store byte into target
			addiu	$a0, $a0, 1		# increment source pointer
			addiu	$a1, $a1, 1		# increment target pointer
			subi    $t2, $t2, 1     		
			beq	$t0, $t1, L7 	# loop until space char
			j not_count_lines
	
		else7:
	 
			jal count_lines
			j Loop
###############################################	
	
	not_count_lines:
		
#################### grep command
		
		la 	 $a0 , command_line    		 # pointer to the first character in the command line
	grep_com:
		
		li       $t2 , 28	
		la 	 $a1 , grep_command      	 # pointer to the command
		L8:	
			beq     $t2 , $zero , else8	
			lb	$t0, ($a0)		# load  byte into $t2
			lb	$t1, ($a1)		# store byte into target
			addiu	$a0, $a0, 1		# increment source pointer
			addiu	$a1, $a1, 1		# increment target pointer
			subi    $t2, $t2, 1     		
			beq	$t0, $t1, L8 	# loop until space char
			j not_grep
	
		else8:
	 
			jal grep
			j Loop
###############################################	
	
	not_grep:
				
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	j error
	
	j Loop
	
	
	
	 error:
		la     $a0, error_message	   	# display message 
       		jal    display_message
			
	default:
	j Loop

         ################################################################      
	exit: 
		li $v0, 10  #terminate
	        syscall 
############################################ Procedures #############################################
  
   
    # This procedure prints a mesasge to the screen
    # parameter must be at $a0
    ###########################################	
	display_message:
		 li    $v0,4
       		 syscall
       		 jr     $ra

    
    
    # This procedure reads a string
    # destination must be at $a0
    ###########################################	
	read:
		lb	$a1, string_length   		# $a1 = max string length
		li	$v0, 8				# read string
		syscall
       		jr     $ra

    
    # This procedure reads a string
    # return value is in memmory at command variable
    ###########################################	
	get_command:

	
		la 	 $t0 , command_line  # pointer to the first character in the command line
		la 	 $t1 , command       # pointer to the command
		li	 $t2, ' '            # space means end of the command
	 
		L5:	lb	$t2, ($t0)	# load  byte into $t2
			sb	$t2, ($t1)	# store byte into target
			#addiu	$t0, $t0, 1	# increment source pointer
			addiu	$t1, $t1, 1	# increment target pointer
			bne	$t0, $t3, L5	# loop until space char

     	  	jr     $ra


      
    # echo command
    ###########################################	
    
      echo: 
      
      
      		
      		#normal_echo:
      		
      		#addiu	$a0, $a0, 1	       	# increment source pointer
		li	$t2, '"'                 # space means end of the command
		lb      $t1 , ($a0)
		beq	$t2, $t1, with_qoutations # loop until space char
      		j print
      		
      		 with_qoutations:

      		 addiu	$a0, $a0, 1	       	# increment source pointer
      		 
      		 la $t1 , buffer1 # $t1=buffer1 addres
      		 
li $t0 , '"'
move $t3 , $a0
li $t4, '\0'     #$t4 = NULL
li $t6 , '\n'  # $t6 = line feed 
li $t7 , '\'' # $t7= ( ' )
la $t8 , buffer2 # $t8=buffer2 address
la $t9 , buffer3 # $t9=buffer3 address


lb $t5 , ($t3)
beq $t0 , $t5 , d_qoutation1
d_qoutation1:

lb $t5 , ($t3)  # load the charcter 
beq $t5 , $t0, normal_echo # instruction !! 
beq $t5 , $t7 , s_qoutation # instruction !! 
sb $t5 , ($t1) # store the character in the buffer1
addi $t1 , $t1 , 1 ## pointer to next char
addi $t3 , $t3 , 1  #next character after ( " )
j d_qoutation1

s_qoutation: 
#addi $t1 , $t1 , 1 
sb $t4 , ($t1) 
s_qoutation_loop:
addi $t3 , $t3 , 1  #next character 
lb $t5 , ($t3)  # load the charcter 
beq $t5 , $t7 , s_qoutation2 # second ( ' ) 
sb $t5 , ($t8) # store the character in the buffer2
addi $t8 , $t8 , 1 # pointer to next char
j s_qoutation_loop

s_qoutation2:
sb $t4 , ($t8) 
s_qoutation2_loop:
addi $t3 , $t3 , 1  #next character
lb $t5 , ($t3)  # load the charcter 
beq $t5 , $t0 , NOTHING100 # Finshed ( " ) 
sb $t5 , ($t9) # store in buffer3
addi $t9 ,$t9 , 1 # pointer to next char
j s_qoutation2_loop

NOTHING100: 
sb $t4 , ($t9)




jal check_buffer2



move $s0 , $t0


li $t0 , 1
bne $s0 , $t0 , next_check 

jal count_words

j check_done
next_check:
li $t0 , 2
bne $s0 , $t0 , next_check2 
jal count_lines
j check_done

next_check2:

jal grep_with_pipe

#################################################################
check_done:

move $s1 , $a0

la $a0 , buffer1
li $v0 , 4
syscall 
move $a0 , $s1
li $v0 , 1
syscall 


la $a3 , buffer3 
li $s1 , '\''
li $s2 , '$'
li $s3 , '\n'
li $s4 , '\0'
print_buffer_loop:
lb $t0 , ($a3)
beq $t0 , $s1 , with_single_qoute
beq $t0 , $s4 , print_buufer_done
move $a0 , $t0
li $v0 , 11
syscall
addi $a3 , $a3 ,1
j print_buffer_loop
with_single_qoute:

addi $a3 , $a3 ,1
lb $t0 , ($a3)
bne $t0,$s2,normal_print 
la $a1 , change_file_name_command   # pointer to the command

move $a0 , $a3		# pointer to the first character in the command line
		li       $t2 , 9	
		#la 	 $a1 , count_words_command      	
		L111:	
			beq     $t2 , $zero , else111	
			lb	$t0, ($a0)		# load  byte into $t2
			lb	$t1, ($a1)		# store byte into target
			addiu	$a0, $a0, 1		# increment source pointer
			addiu	$a1, $a1, 1		# increment target pointer
			subi    $t2, $t2, 1     		
			beq	$t0, $t1, L111 	# loop until space char
			j normal_print
	
		else111:
	 		la $a3 , File_name
			addi $a3 , $a3 ,1
			j normal_print
			
###############################################	
	

normal_print:
subi $a3 , $a3 ,1
li $s1 , '\n' 
print_buffer_loop2:
lb $t0 , ($a3)
beq $t0 , $s1 , print_buufer_done
move $a0 , $t0
li $v0 , 11
syscall
addi $a3 , $a3 ,1
j print_buffer_loop2

print_buufer_done:
li $a0 , '\n'
li $v0 , 11
syscall

 j  Loop 
 
 
 
normal_echo:
sb $t4 , ($t1) 

la $a0 , buffer1
li $v0 , 4
syscall
li $a0 , '\0'
li   $v0 ,11
syscall      		 
 jr $ra     		 
      		 print_without_qout:
      		 	move 	$t0, $a0
      		 	lb	$t1, ($a0)
      		 	li 	$t2, '"'
      		 	beq     $t1,$t2,done_with_new_line
      		 	move    $a0 , $t1
      		 	 li    $v0,11
       			 syscall
       			 move $a0 , $t0
       			 addi $a0 , $a0 , 1
       			
       		j print_without_qout	  
      		
      		 
 		
    	print:	 li    $v0,4
       		 syscall
    		j done
    		
    		
    	done_with_new_line:	
    		li $a0 , '\n'
      		 li    $v0,11
       		 syscall
    	done:	
    		
    		jr $ra
    		
    		
    # change file name
    ###########################################	
    change_file_name:
    			li  $t1 , '\0'
    			la $a1  , File_name 
    		change_name_loop:

    			
    			
    			lb $t0 , 0($a0)   			
    			sb $t0 , 0($a1)
    			
    			
    		
    			addiu $a0 , $a0 , 1
    			addiu $a1 , $a1 , 1
    			bne $t0 , $t1 , change_name_loop
 
    		
    		
    		jr     $ra
    		
    		
    		
  # check buffer2
    ###########################################	
  check_buffer2:  
  
  		
  				
  								
    		    		
#################### count words command
		
		la 	 $a0 , buffer2   		 # pointer to the first character in the command line
	check_count_words2:
		
		li       $t2 , 18	
		la 	 $a1 , count_words_command      	 # pointer to the command
		L110:	
			beq     $t2 , $zero , else110	
			lb	$t0, ($a0)		# load  byte into $t2
			lb	$t1, ($a1)		# store byte into target
			addiu	$a0, $a0, 1		# increment source pointer
			addiu	$a1, $a1, 1		# increment target pointer
			subi    $t2, $t2, 1     		
			beq	$t0, $t1, L110 	# loop until space char
			j not_count_words2
	
		else110:
	 		li $t0 , 1
	 		jr     $ra
			#jal count_words
			
			#j Loop
###############################################	
	
	not_count_words2:
		
	
	
	
	

#################### count lines command
		
		la 	 $a0 , buffer2   		 # pointer to the first character in the command line
	check_count_lines2:
		
		li       $t2 , 16	
		la 	 $a1 , count_lines_command      	 # pointer to the command
		L120:	
			beq     $t2 , $zero , else120	
			lb	$t0, ($a0)		# load  byte into $t2
			lb	$t1, ($a1)		# store byte into target
			addiu	$a0, $a0, 1		# increment source pointer
			addiu	$a1, $a1, 1		# increment target pointer
			subi    $t2, $t2, 1     		
			beq	$t0, $t1, L120 	# loop until space char
			j not_count_lines2
	
		else120:
	 		
	 		li $t0 , 2
	 		jr  $ra
			#jal count_lines
			#j Loop
###############################################	
	
	not_count_lines2:
	
	

#################### grep with pipe command
		
		la 	 $a0 , buffer2  	 # pointer to the first character in the command line
	check_grep_with_pipe:
		
		li       $t2 , 36	
		la 	 $a1 ,  count_lines_after_grep_command       	 # pointer to the command
		L122:	
			beq     $t2 , $zero , else122	
			lb	$t0, ($a0)		# load  byte into $t2
			lb	$t1, ($a1)		# store byte into target
			addiu	$a0, $a0, 1		# increment source pointer
			addiu	$a1, $a1, 1		# increment target pointer
			subi    $t2, $t2, 1     		
			beq	$t0, $t1, L122 	# loop until space char
			j not_grep_with_pipe
	
		else122:
	 		
	 		li $t0 , 3
	 		jr  $ra
			#jal count_lines
			#j Loop
###############################################	
				
	not_grep_with_pipe:
	
	
	
    	j error	    		    		    		
	    		    		    		    		    		    		    		    		    		    		    		
 	 jr  $ra  		    		    		    		    		    		    		    		    		    		    		    		    		    		    		    		    		    		    		    		
    # change string name
    ###########################################	
    change_string_name:
    			li  $t1 , '\0'
    			li $t3 , '\n'
    			la $a1  , String_name
    		change_string_loop:

    			
    			
    			lb $t0 , 0($a0)   			
    			sb $t0 , 0($a1)
    			
    			
    		
    			addiu $a0 , $a0 , 1
    			addiu $a1 , $a1 , 1
    			bne $t0 , $t1 , change_string_loop
 
    			sb $t1 , 0($a1)
    		
    		jr     $ra
    		
    		
    		
    		
      # count words
    ###########################################			
    		
    		count_words:
    		
    		li $v0, 13           #open a file
		li $a1, 0            # file flag (read)
		la $a0, filename         # load file name
		add $a2, $zero, $zero    # file mode (unused)
		syscall
		move $a0, $v0        # load file descriptor
		li $v0, 14           #read from file
		la $a1, textSpace        # allocate space for the bytes loaded
		li $a2, 1050         # number of bytes to be read
		syscall  
		
		xor $t1,$t1,$t1             # t1=0
		li $t0 , '\n'
		li $t8 , ' '                #space
		li $t4, '\0'                #$t4 = NULL
		la $a2 , String_name	     # $a2 = pointer to the String name 
		la $a1, textSpace           # $a1 = pointer to the userString 
		
		
		loop10 :
		 
		lb $t5 , ($a1)
		lb $t7 , ($a2)
		
		
		beq $t4 , $t5 , NOTHING1  #null

		beq $t7 , $t5 , check_word
		addi $a1 , $a1 , 1
		
		j loop10
		
		check_word: 
		
		addi $a2 , $a2 , 1          #String
		addi $a1 , $a1 , 1          #Word
		
		lb $t5 , ($a1)
		lb $t7 , ($a2)
		
		beq $t7 , $t0 , increment_counter
		beq $t7 , $t5 , check_word
		
		j loop10
		increment_counter:
		addi $t1,$t1,1
		la $a2 , String_name	     # $a2 = pointer to the String name 
		j loop10
		
		NOTHING1: 
		
		
		move $a0 , $t1
		li $t0 , 1
		beq  $s0,$t0,done100
		li $v0 ,1
		syscall
		la $a0 , '\n'
		li $v0 ,11
		syscall
		
		done100:
    		jr     $ra
    		
    		
    		      # count lines
    ###########################################			
    		
    		count_lines:
    		
		li $v0, 13           #open a file
		li $a1, 0            # file flag (read)
		la $a0, filename         # load file name
		add $a2, $zero, $zero    # file mode (unused)
		syscall
		move $a0, $v0        # load file descriptor
		li $v0, 14           #read from file
		la $a1, textSpace        # allocate space for the bytes loaded
		li $a2, 1050         # number of bytes to be read
		syscall  




		 li $t0 , '\n'
		#addi $t0,$0, 32  # $t0 holds 'space'
		xor $t1,$t1,$t1   # t1=0
		la $t3, textSpace # $t3= pointer to the userString 
		li $t4, '\0'     #$t4 = NULL
		loop : 
		lb $t5 , ($t3)
		beq $t4 , $t5 , NOTHING5
		beq $t0 , $t5 , new_line_label
		addi $t3 , $t3 , 1
		j loop
		new_line_label: 
		addi $t1 , $t1 , 1 #number of words (Spaces)
		addi $t3 , $t3 , 1 # next charcter 
		j loop
		NOTHING5 : 
		addi $a0 , $t1 , 1
		li $t0 , 2
		beq  $s0,$t0,done10
		
		
		li $v0 ,1
		syscall
		li $a0 , '\n'
		li $v0 ,11
		syscall
    		
    		done10:
    		jr     $ra
    		
    		
    		
    	#################################################3
    	adjust_file_name:	
    	
    	la $t0, File_name
    	la $t1, filename
    	li $t3 , '\n'		
	adjust_loop:	
	lb	$t2, 0($t0)	# load  byte into $t2
	beq	$t2, $t3, done_adjust	# loop until NULL char
	sb	$t2, 26($t1)	# store byte into target
	addiu	$t0, $t0, 1	# increment source pointer
	addiu	$t1, $t1, 1	# increment target pointer
	j adjust_loop
	done_adjust:
	li 	$t3 , '\0'
	sb	$t3, 26($t1)	# store byte into target
	jr     $ra
	
	
	    	#################################################3
    	print_new_line:	
    	
    	li $a0, '\n'
    	li $v0, 11
	syscall
	jr     $ra
	
	
	
		
      # grep
    ###########################################			
    		
    		grep:
    		
    		li $v0, 13           #open a file
		li $a1, 0            # file flag (read)
		la $a0, filename         # load file name
		add $a2, $zero, $zero    # file mode (unused)
		syscall
		move $a0, $v0        # load file descriptor
		li $v0, 14           #read from file
		la $a1, textSpace        # allocate space for the bytes loaded
		li $a2, 1050         # number of bytes to be read
		syscall  
		
		xor $t1,$t1,$t1             # t1=0
		li $t0 , '\n'
		li $t8 , ' '                #space
		li $t4, '\0'                #$t4 = NULL
		la $a2 , String_name	     # $a2 = pointer to the String name 
		la $a1, textSpace           # $a1 = pointer to the userString 
		move $t9 , $a1   # pointer to the first char in a line 
		
		
		loop11 :
		
		lb $t5 , ($a1)
		lb $t7 , ($a2)
		
		beq $t5 , $t0 , next_line
		beq $t4 , $t5 , NOTHING2  #null

		beq $t7 , $t5 , check_word1
		addi $a1 , $a1 , 1
		
		j loop11
		
		check_word1: 
		
		addi $a2 , $a2 , 1          #String
		addi $a1 , $a1 , 1          #Word
		
		lb $t5 , ($a1)
		lb $t7 , ($a2)
		
		beq $t7 , $t0 , print_line
		beq $t7 , $t5 , check_word1
		la $a2 , String_name	     # $a2 = pointer to the String name
		j loop11
		
		
		print_line:  #from t9 to \n
		move  $s1 , $a0
		move $a3 , $t9
		print_line_loop:
		lb $a0, ($a3)
		beq $a0, $t0 , done3
		li $v0, 11
		syscall
		addi $a3 , $a3,1
		j print_line_loop
		done3:
		jal print_new_line
		move  $a0 , $s1
		la $a2 , String_name	     # $a2 = pointer to the String name 
		j loop11
		
		next_line:
		addi $a1 , $a1 , 1
		move $t9 , $a1
	
		
		j loop11
		
		NOTHING2: 
    		#jr     $ra
    		j Loop
    			
############################################## grep_with_pipe	
    
    		grep_with_pipe:
    		la  $s3 , print_to_file_buffer
    		li $v0, 13           #open a file
		li $a1, 0            # file flag (read)
		la $a0, filename         # load file name
		add $a2, $zero, $zero    # file mode (unused)
		syscall
		move $a0, $v0        # load file descriptor
		li $v0, 14           #read from file
		la $a1, textSpace    # allocate space for the bytes loaded
		li $a2, 1050         # number of bytes to be read
		syscall  
		
		xor $t1,$t1,$t1             # t1=0
		li $t0 , '\n'
		li $t8 , ' '                #space
		li $t4, '\0'                #$t4 = NULL
		la $a2 , String_name	     # $a2 = pointer to the String name 
		la $a1, textSpace           # $a1 = pointer to the userString 
		move $t9 , $a1   # pointer to the first char in a line 
		
		
		loop1100 :
		
		lb $t5 , ($a1)
		lb $t7 , ($a2)
		
		beq $t5 , $t0 , next_line00
		beq $t4 , $t5 , NOTHING200 #null

		beq $t7 , $t5 , check_word100
		addi $a1 , $a1 , 1
		
		j loop1100
		
		check_word100: 
		
		addi $a2 , $a2 , 1          #String
		addi $a1 , $a1 , 1          #Word
		
		lb $t5 , ($a1)
		lb $t7 , ($a2)
		
		beq $t7 , $t0 , print_line00
		beq $t7 , $t5 , check_word100
		la $a2 , String_name	     # $a2 = pointer to the String name
		j loop1100
		
		
		print_line00:  #from t9 to \n
		move  $s1 , $a0
		move $a3 , $t9
		
		
		
		print_line_loop00:
		lb $a0, ($a3)
		beq $a0, $t0 , done300
		#________________________________________________
		sb $a0 , ($s3)
		addi $s3 , $s3 ,1
		#li $v0, 11
		#syscall
		#________________________________________________
		addi $a3 , $a3,1
		j print_line_loop00
		
		done300:
		#________________________________________________
		li $a0 , '\n'
		sb $a0 , ($s3)		
	
		#jal print_new_line_to_file
		
		#________________________________________________
		move  $a0 , $s1
		la $a2 , String_name	     # $a2 = pointer to the String name 
		j loop1100
		
		next_line00:
		addi $a1 , $a1 , 1
		move $t9 , $a1
	
		
		j loop1100
		
		NOTHING200: 
		li $a0 , '\0'
		sb $a0 , ($s3)
		
	##### print to buffer
	close_prev_file:
	li $v0, 16  # $a0 already has the file descriptor
    		syscall
			
		file_open:
    		li $v0, 13
  		la $a0, buffer_file
    		li $a1, 1
    		li $a2, 0
    		syscall  # File descriptor gets returned in $v0
		file_write:
  		move $a0, $v0  # Syscall 15 requieres file descriptor in $a0
		li $v0, 15
		la $a1, print_to_file_buffer
 		la $a2, str_data_end
    		la $a3, print_to_file_buffer
    		subu $a2, $a2, $a3  # computes the length of the string, this is really a constant
    		syscall
		file_close:
    		li $v0, 16  # $a0 already has the file descriptor
    		syscall
		
	###### count lines in buffer	
		count_lines_in_buffer:
    		
		li $v0, 13           #open a file
		li $a1, 0            # file flag (read)
		la $a0, buffer_file         # load file name
		add $a2, $zero, $zero    # file mode (unused)
		syscall
		move $a0, $v0        # load file descriptor
		li $v0, 14           #read from file
		la $a1, textSpace    # allocate space for the bytes loaded
		li $a2, 1050         # number of bytes to be read
		syscall  




		 li $t0 , '\r'
		#addi $t0,$0, 32  # $t0 holds 'space'
		xor $t1,$t1,$t1   # t1=0
		la $t3,	print_to_file_buffer		
		#la $t3, textSpace # $t3= pointer to the userString 
		li $t4, '\0'     #$t4 = NULL
		loop00 : 
		lb $t5 , ($t3)
		beq $t4 , $t5 , NOTHING500
		beq $t0 , $t5 , new_line_label00
		addi $t3 , $t3 , 1
		j loop00
		new_line_label00: 
		addi $t1 , $t1 , 1 #number of words (Spaces)
		addi $t3 , $t3 , 1 # next charcter 
		j loop00
		NOTHING500: 
		add $a0 , $t1 , $zero
		li $t0 , 3
		beq  $s0,$t0,done1000
		li $v0 ,1
		syscall
		li $a0 , '\n'
		li $v0 ,11
		syscall
		
		
		done1000:
    		jr     $ra
    		#j Loop

    		
######################################################################################################  
