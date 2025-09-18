# Morse-Encoder-

**1. Project Overview**
This project implements a Morse Code Encoder using RISC-V assembly language.It informs the user for an alphanumeric string and transforms each character (A-Z, a-z, 0-9) into its corresponding Morse code representation. Then, the encoded output is printed to the console
using RARS (RISC-V Assembler and Runtime Simulator).
The application illustrates:
a- Character input and output handling.
b- Use of .data and .text segments effectively.
c- Manipulation of ASCII values.
d- String scanning and processing.
e- Basic loop and conditional constructs in RISC-V.

**2. Design Implementation**
**2.1. Input and Output**
a- At the beginning, the program prints a message which tells the user to enter a message.
b- After that, it reads the message into a buffer with a size of 100 bytes.
c- Then, the message is read, and the original input is printed back, followed by the
“Morse: “ label and encoded message.
**2.2. Morse Code Table**
- A single string stores the Morse Equivalents of A-Z and 0-9. Note that they are separated by spaces.
- A lookup index is calculated based on the ASCII value of each character as follows:
• ‘A’ – ‘Z’: indices 0-25
• ‘a’ – ‘z’: first converted to uppercase, then treated as ‘A’ – ‘Z’
• ‘0’ – ‘9’: indices 26-35
**2.3. Character Processing**
- The program loops through each character of the input string.
- It removes non-alphanumeric characters and transforms lowercase letters to uppercase.
- The correct index in the Morse table is computed and then it is used to extract the Morse code letter by letter.
- Each Morse code character is printed using syscall 11 (a7 = 11) and separated by spaces.
**2.4. Handling Special Characters**
- Spaces in the input are maintained as spaces in the output.
- Any Newline and any unsupported characters are skipped during encoding.
**3. Challenges and Solutions**
- Morse Table Navigation:
Navigating a space separated string needed careful word counting and offset tracking.
We used a loop that scanned the table until the desired Morse index was matched by counting spaces.
- Character Classification:
ASCII comparisons and branching managed differentiating between letters, digits, and invalid characters.
- Uppercase Conversion:
Lowercase letters were transformed into uppercase letters using a subtraction of 32 from their ASCII values, relying on the standard ASCII table.
**4. Testing and Validation**
We tested the program of RARS with various input cases including: lowercase and uppercase letters, digis from 0-9, and mixed inputs and spaces.
**5. Conclusion**
This project allowed my team and I to apply the fundamental concepts from the course EECE 321 (Computer Organization) such as register operations, memory management, control flow, and string processing in assembly language. It enhanced our understanding of low-level programming and RISC-V architecture by simulating a real-world encoder application. We successfully developed a functional Morse code in RISC-V that met the specified requirements and provided clean and readable code.
