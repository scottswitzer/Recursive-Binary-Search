.text
.global binary_search

binary_search:
	init:
		SUB sp, sp, #28				// decrease stack pointer to allocate stack space
		STR r0, [sp, #20]			// store r0 on stack
		STR	r7, [sp, #16]			// store r7 on stack
		STR	r6, [sp, #12]			// store r6 on stack
		STR r5, [sp, #8]			// store r5 on stack
		STR r4, [sp, #4]			// store r4 on stack
		STR lr, [sp, #0]			// store return address on stack
		
		LDR r7, [sp, #24]			// load numCalls from stack to r7
		
		B exec
		
	func:
		SUB sp, sp, #28				// decrease stack pointer to allocate stack space
		STR r0, [sp, #20]			// store r0 on stack
		STR	r7, [sp, #16]			// store r7 on stack
		STR	r6, [sp, #12]			// store r6 on stack
		STR r5, [sp, #8]			// store r5 on stack
		STR r4, [sp, #4]			// store r4 on stack
		STR lr, [sp, #0]			// store return address on stack
		
	exec:
		SUB r4, r3, r2				// int temp = endIndex - startIndex;
		ADD r5, r2, r4, lsr#1		// int middleIndex = startIndex + temp/2;
		
		ADD r7, r7, #1				// numCalls++;

		if0:
			CMP r2, r3					// startIndex - endIndex
			BLE else0					// if (startIndex <= endIndex) branch to else0
			MOV r12, #-1				// save -1
			
			LDR r0, [sp, #20]			// restore r0 from stack
			LDR	r7, [sp, #16]			// restore r7 from stack 
			LDR	r6, [sp, #12]			// restore r6 from stack
			LDR r5, [sp, #8]			// restore r5 from stack
			LDR r4, [sp, #4]			// restore r4 from stack
			LDR lr, [sp, #0]			// restore return address from stack
			ADD sp, sp, #28				// increase stack pointer to free stack space
			
			MOV r0, r12
			MOV	pc, lr					// return to caller
			
		else0:
			LDR r4, [r0, r5, lsl#2] 	// temp = numbers[middleIndex]; 	
			CMP r4, r1					// temp - key
			BNE else1					// if (temp != key) branch to else1
			MOV r6, r5	    			// keyIndex = middleIndex;
			B L1						// branch unconditionally to L1

		else1:	
			CMP r4, r1					// temp - key
			BLE else2 					// if (temp <= key) branch to else2
			SUB r3, r5, #1				// endIndex = middleIndex - 1
			BL func 					// call func
			MOV r6, r0					// keyIndex = binary_search(numbers, key, startIndex, middleIndex-1, NumCalls)
			B L1						// branch unconditionally to L1

		else2:
			ADD r2, r5, #1				// startIndex = middleIndex + 1
			BL func 					// call func
			MOV r6, r0					// keyIndex = binary_search(numbers, key, middleIndex+1, endIndex, NumCalls);

		L1:
			LDR r0, [sp, #20]			// restore r0 from stack
			
			NEG r4, r7					// temp = -NumCalls;
			STR r4, [r0, r5, lsl#2]		// numbers[middleIndex] = temp;
			MOV r12, r6					// save keyIndex
			
			LDR	r7, [sp, #16]			// restore r7 from stack 
			LDR	r6, [sp, #12]			// restore r6 from stack
			LDR r5, [sp, #8]			// restore r5 from stack
			LDR r4, [sp, #4]			// restore r4 from stack
			LDR lr, [sp, #0]			// restore return address from stack
			ADD sp, sp, #28				// increase stack pointer to free stack space
			
			MOV r0, r12					// return keyIndex
			MOV pc, lr					// return to caller