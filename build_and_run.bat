nasm -f win64 -o av_evasion.obj av_evasion.asm
link av_evasion.obj /subsystem:console /out:av_evasion.exe msvcrt.lib shell32.lib user32.lib
av_evasion.exe
