// C signature for Win32 API in kernel32.dll:
// BOOL WINAPI SetConsoleCursorPosition(
//   _In_ HANDLE hConsoleOutput,
//   _In_ COORD  dwCursorPosition
// );

import 'dart:ffi';

typedef nativePrototype = Int32 Function(IntPtr hConsoleOutput, Int32 dwCursorPos);
typedef dartPrototype = int Function(int hConsoleOutput, int dwCursorPos);

final kernel32 = DynamicLibrary.open('kernel32.dll');
final SetConsoleCursorPosition = kernel32.lookupFunction<nativePrototype, dartPrototype>('SetConsoleCursorPosition');

// final result = MessageBox(
//     NULL,
//     TEXT("This is one of those messages that nobody will ever read. They'll "
//         "just click the default button, and about a millisecond later, "
//         "they'll experience a pang of concern as they wonder whether Windows "
//         "was giving them one last opportunity to perform a critical task "
//         "before all their files were wiped.\n\nWhat even is the difference "
//         "between Cancel, Try Again and Continue?"),
//     TEXT('Critical system message'),
//     MB_ICONEXCLAMATION | // Warning
//         MB_CANCELTRYCONTINUE | // Action button
//         MB_DEFBUTTON2 // Second button is the default
//     );
