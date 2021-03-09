/// Basic Petzoldian "hello world" Win32 app
/// 本例的dll调用,使用的是win32这个库,它里面封装很完善.
import 'dart:ffi';
import 'package:ffi/ffi.dart';

import 'package:win32/win32.dart';

final hInstance = GetModuleHandle(nullptr);

int mainWindowProc(int hWnd, int uMsg, int wParam, int lParam) {
  switch (uMsg) {
    case WM_DESTROY:
      PostQuitMessage(0);
      return 0;

    case WM_PAINT:
      final ps = PAINTSTRUCT.allocate();
      final hdc = BeginPaint(hWnd, ps.addressOf);
      final rect = RECT.allocate();
      final msg = TEXT('Hello, Dart!');

      GetClientRect(hWnd, rect.addressOf);
      DrawText(hdc, msg, -1, rect.addressOf, DT_CENTER | DT_VCENTER | DT_SINGLELINE);
      EndPaint(hWnd, ps.addressOf);

      free(ps.addressOf);
      free(rect.addressOf);
      free(msg);

      return 0;
  }
  return DefWindowProc(hWnd, uMsg, wParam, lParam);
}

/// 1. 申请窗口内存实例,绑定回调事件,title,后台现成,消息服务等,注册当前系统
/// 2. 实例窗口
/// 3. 激活消息回调, [mainWindowProc] 开始生命周期
void main() {
  // Register the window class.
  final className = TEXT('Sample Window Class');

  // 1. 申请窗口内存实例,绑定回调事件,title,后台现成,消息服务等,注册当前系统
  final wc = WNDCLASS.allocate();
  wc.style = CS_HREDRAW | CS_VREDRAW;
  wc.lpfnWndProc = Pointer.fromFunction<WindowProc>(mainWindowProc, 0);
  wc.hInstance = hInstance;
  wc.lpszClassName = className;
  wc.hCursor = LoadCursor(NULL, IDC_ARROW);
  wc.hbrBackground = GetStockObject(WHITE_BRUSH);
  RegisterClass(wc.addressOf);

  // 2. 实例窗口
  // Create the window.
  final hWnd = CreateWindowEx(
      0, // Optional window styles.
      className, // Window class
      TEXT('Dart Native Win32 window'), // Window caption
      WS_OVERLAPPEDWINDOW, // Window style

      // Size and position
      CW_USEDEFAULT,
      CW_USEDEFAULT,
      CW_USEDEFAULT,
      CW_USEDEFAULT,
      NULL, // Parent window
      NULL, // Menu
      hInstance, // Instance handle
      nullptr // Additional application data
      );
  // 检测窗口创建结果,失败退出
  if (hWnd == 0) {
    final error = GetLastError();
    throw WindowsException(HRESULT_FROM_WIN32(error));
  }

  // 显示与更新
  ShowWindow(hWnd, SW_SHOWNORMAL);
  UpdateWindow(hWnd);

  // 3. 激活消息回调, [mainWindowProc] 激活生命周期
  // Run the message loop.
  final msg = MSG.allocate();
  while (GetMessage(msg.addressOf, NULL, 0, 0) != 0) {
    TranslateMessage(msg.addressOf);
    DispatchMessage(msg.addressOf);
  }
}
