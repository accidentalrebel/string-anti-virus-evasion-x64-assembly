nasm -f win64 -o av_evasion_part1.obj av_evasion_part1.asm
link av_evasion_part1.obj /subsystem:console /out:av_evasion_part1.exe msvcrt.lib shell32.lib user32.lib
av_evasion_part1.exe
