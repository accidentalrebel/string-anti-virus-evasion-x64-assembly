#include <windows.h>

typedef HINSTANCE (*_ShellExecuteA) (
	HWND   hwnd,
	LPCSTR lpOperation,
	LPCSTR lpFile,
    LPCSTR lpParameters,
	LPCSTR lpDirectory,
	INT    nShowCmd
);

int main(void)
{
	char ca_shell32[] = { 's','h','e','l','l','3','2','.','d','l','l', 0 };
	HANDLE hShell32 = LoadLibrary(ca_shell32);

	char ca_shellExA[] = { 'S','h','e','l','l','E','x','e','c','u','t','e','A', 0 };
	_ShellExecuteA fShellExecuteA = (_ShellExecuteA) GetProcAddress(hShell32, ca_shellExA);

	char ca_notepad[] = { 'n','o','t','e','p','a','d',0 };
 	fShellExecuteA(0, "open", ca_notepad, NULL, NULL, SW_SHOW);

	ExitProcess(0);
}
