#include <windows.h>
#include <shellapi.h>

int main(void)
{
	int test = 0;
	
	char ca_notepad[] = { 'n','o','t','e','p','a','d',0 };
	ShellExecute(0, "open", ca_notepad, NULL, NULL, SW_SHOW);

	ExitProcess(0);
}
