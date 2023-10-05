.data
size: .word 10		#10010000
target: .word 3998	#10010004
result: .word 0		#10010008
array: .word 1, 64, 189, 674, 1005, 2763, 3730, 3998, 5476, 10003	#10010012

.text
########################################
# Your code starts here
# Your name: Fernando Portillo 
########################################

main:	lui $s0, 0x1001		# load base address 0x10010000 to s0
	ori $s0, $s0, 0x0000
	lw $s1, 0($s0)		# load size into s1
	lw $s2, 4($s0)		# load target into s2
	addi $s3, $s0, 12	# load base address of array into $s3
	j binary_search		# jump to binary_search

binary_search:
	addi $t0, $zero, -1	# save -1 as default result (0x10010008)
	sw $t0, 8($s0)
	addi $t0, $zero, 0	# set left index (0)
	addi $t1, $s1, -1	# set right index (size - 1)
	j loop			# jump to loop
	
loop:	slt $t3, $t1, $t0	# check if a <= b, by checking if b < a
	bne $t3, $zero, end	# if b < a or a > b, jump to end
	sub $t2, $t1, $t0	# right - left
	srl $t2, $t2, 1		# (right - left) / 2
	add $t2, $t2, $t0	# left - (right - left) / 2 (calculated m)
	sll $t3, $t2, 2		# m * 4
	add $t3, $s3, $t3	# &array[m]
	lw $t3, 0($t3)		# load value of &array[m] into $s3
	beq $t3, $s2, equal	# check if array[m] == target (target found)
	slt $t3, $s2, $t3	# check if target < array[m]
	beq $t3, $zero, greater # if target is not less, jump to greater label
	addi $t1, $t2, -1	# set right = m - 1
	j loop			# loop
	
equal:
	sw $t2, 8($s0)		# load found index to result address
	j end			# jump to end

greater:
	addi $t0, $t2, 1	# set left = m + 1
	j loop			# loop
 
end:


########################################
# Your code ends here
# Store your answer to 0x10010008(result)
########################################
	ori $2, $0, 10
	syscall



