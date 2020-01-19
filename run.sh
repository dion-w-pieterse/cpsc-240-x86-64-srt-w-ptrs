
echo "Assemble the x86-64 NASM file"
nasm -f elf64 -l main_asm.lis -o main_asm.o main_asm.asm
echo "Assemble the x86-64 NASM file"
nasm -f elf64 -l input_array_func.lis -o input_array_func.o input_array_func.asm
echo "Assemble the x86-64 NASM file"
nasm -f elf64 -l output_array_func.lis -o output_array_func.o output_array_func.asm
echo "Assemble the x86-64 NASM file"
nasm -f elf64 -l output_original_array.lis -o output_original_array.o output_original_array.asm
echo "Compile the .cpp file"
g++ -c -m64 -Wall -l prac2cpp.lis -o driver.o driver.cpp
echo "Compile the .cpp file"
g++ -c -m64 -Wall -l sort_func.lis -o sort_func.o sort_func.cpp
echo "Link the object files"
g++ -m64 -o Exec driver.o main_asm.o input_array_func.o output_array_func.o output_original_array.o sort_func.o
echo "Run the program"
./Exec
