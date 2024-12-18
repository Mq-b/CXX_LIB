# MSVC-setup

直接在微软官网安装 [Visual Studio](https://visualstudio.microsoft.com/zh-hans/) 来配置 MSVC 工具链是最为简单的。下载 C++ 桌面开发那个模块即可。

不管你是 windows10 还是 windows11，Visual Studio 安装成功后都会附带的给你几个配置好了 MSVC 工具链的终端，我们直接操作这个终端是最为方便的。

建议使用：`Developer PowerShell for VS 2022` 也就是 PowerShell 终端。直接去开始菜单慢慢翻即可。

> [!TIP]
> 如果你是 windows11 ，则默认预装了 [Windows Terminal](https://github.com/microsoft/terminal)。我们可以选择打开它，点击右边的下拉新建一个会话即可：
> ![terminal](image/Windows%20Terminal.png)

所有想要使用 MSVC 工具链的操作都可以直接操作这个终端。它也附带了许多基本的工具。

1. **`cl.exe`**   - MSVC C/C++ 编译器

2. **`link.exe`** - 链接器

3. **`cmake`**    - 跨平台构建系统生成器

4. **`nmake`**    - Microsoft 的 `make` 工具

5. **`msbuild`**  - Microsoft 构建工具，通常用于 .NET 和 C++ 项目

6. **`vcpkg`**    - C++ 包管理工具

7. **`git`**      - Git 版本控制工具

8. **`ninja`**    - 高效的构建系统工具
