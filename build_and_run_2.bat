nasm -f win64 -o av_evasion_part2.obj av_evasion_part2.asm
link av_evasion_part2.obj /subsystem:console /out:av_evasion_part2.exe msvcrt.lib shell32.lib user32.lib
av_evasion_part2.exe
