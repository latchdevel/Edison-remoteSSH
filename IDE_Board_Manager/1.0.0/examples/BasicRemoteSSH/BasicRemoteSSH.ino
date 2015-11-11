/* 
 *  You can add the comments there with a little bit of inline assembly
 *  GCC also has #ident directive which copies the text into an appropriate 
 *  section if available. In the case of ELF, it would be the .comment section. 
 *  This solution, even though the directive isn't standard, is probably more 
 *  portable than the former.
 *  
 *  You can access to .comment section of elf object file:
 *    objdump -s --section .comment <elf_file>
 *    readelf -p .comment <elf_file>
 *    
 *  You can remove .comment section:
 *    objcopy --remove-section .comment <elf_file>
 *    strip --remove-section=.comment <elf_file>
 *  
*/

#ident "USER:root"

__asm__(".section .comment\n\t"
        ".string \"HOST:edison.local\"\n\t"
        ".section .text");

void setup() {
  // put your setup code here, to run once:

}

void loop() {
  // put your main code here, to run repeatedly:

}
