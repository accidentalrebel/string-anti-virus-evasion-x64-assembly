#include <windows.h>
#include <shellapi.h>

int main(void)
{
	char ca_notepad[] = { 'n','o','t','e','p','a','d',0 };
	HINSTANCE hinst = ShellExecute(0, "open", ca_notepad, NULL, NULL, SW_SHOW);

	char ca_notepad2[] = "notepad";
	ShellExecute(0, "open", ca_notepad2, NULL, NULL, SW_SHOW);

	/* HINSTANCE test = hinst; */
	
	ExitProcess(0);
}
