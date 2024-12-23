# CXX_LIB

本仓库存储着使用 MSVC 工具链编译构建的常见 C++ 三方库。

版本：`Visual Studio Community 2022 (64 位) 17.11.3`。

编译器工具集：`v14`。

Visual Studio 版本之间的 C++ 存在[二进制兼容性](https://learn.microsoft.com/zh-cn/cpp/porting/binary-compat-2015-2017?view=msvc-170)，自 Visual Studio 2015 到 2022。

>[!TIP]
>如果你是纯萌新，参考：[**MSVC-setup.md**](./MSVC-setup.md)

## 快速安装

直接下载 [Setup-CXX_LIB](./Setup-CXX_LIB.ps1) 脚本然后执行，即可自动配置。

windows 默认不开启执行脚本权限，需要以管理员身份运行 `Set-ExecutionPolicy Unrestricted -Scope CurrentUser` 命令设置。

为了考虑大多数人的环境是 windows 中国大陆区域，即 `chcp 936`，我们将脚本存储为 `gb2312` 的编码，以让大多数人能直接运行。如果你和我一样是全局 `utf-8` 记得修改脚本编码。


## 普通安装

>[!TIP]
>如果你做了上一步快速安装，则无需看这一节。

引入库十分的简单，将仓库克隆到本地：

```shell
git clone https://github.com/Mq-b/CXX_LIB
```

然后定义变量 `CMAKE_PREFIX_PATH` ，值为仓库的路径，它是用来设置 CMake 查找包路径的。

> [!TIP]
> 建议将该变量定义在全局环境中，而非 `CMakeLists.txt` 文件中。这种方式更通用，便于开发者根据需要自行决定库的路径，避免硬编码路径的问题（例如和同事共享）。

可以定义在全局环境变量，或者是在 CMakeList.txt 中定义：

```cmake
set(CMAKE_PREFIX_PATH "D:/CXX_LIB" CACHE STRING "自定义查找包的安装路径" FORCE)
```

定义环境变量查看是否生效：

```PowerShell
PS C:\Users\A1387> $env:CMAKE_PREFIX_PATH
D:/CXX_LIB
```

做好这一步之后就可以直接在自己仓库随便的引入库了：

## 在项目中引入库

```cmake
find_package(SFML 2.6.1 COMPONENTS system window graphics audio network REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE sfml-system sfml-window sfml-graphics sfml-audio sfml-network)

find_package(fmt CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE fmt::fmt-header-only)

find_package(TBB REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE TBB::tbb)

# 无法处理 Debug 这是库本身的问题
find_package(cpp-terminal REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE cpp-terminal::cpp-terminal)

find_package(spdlog REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE spdlog::spdlog_header_only)

find_package(nlohmann_json 3.2.0 REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE nlohmann_json::nlohmann_json)

find_package(GTest REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE GTest::GTest)

find_package(benchmark REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE benchmark::benchmark)
```

有些库还需设置 `bin` 环境变量或者直接将 `dll` 复制过来，因为是动态链接库，这不是 CMake 管理的。

## 相关库介绍

- [**cpp-terminal**](https://github.com/jupyter-xeus/cpp-terminal)

  用于构建跨平台的终端应用程序，支持终端输入输出控制（如颜色、光标控制，终端绘制图形）。

  **特点**：现代 C++ 风格，简单易用，适用于需要与终端交互的应用。
  
- [**fmt**](https://github.com/fmtlib/fmt)

  跨平台的现代高效的字符串格式化库。
  
  **特点**：支持类型安全的格式化，性能高，易于使用，广泛应用于 C++ 项目中。

- [**GTest**](https://github.com/google/googletest)

  Google 提供的跨平台 C++ 测试框架，用于单元测试。

  **特点**：简洁的 API，支持断言和 Mock 测试，广泛用于自动化测试。

- [**nlohmann_json**](https://github.com/nlohmann/json)

  现代的跨平台 C++ JSON 解析与序列化库。

  **特点**：提供 STL 容器风格的接口，易于使用，支持完整的 JSON 操作。

- [**TBB**](https://github.com/oneapi-src/oneTBB)

  Intel 提供的跨平台并行编程库，帮助开发高性能多线程应用。

  **特点**：支持任务调度、并行算法，适合多核计算和高性能计算应用。

- [**sfml**](https://github.com/SFML/SFML)

  用于 2D 图形、音频和窗口处理的跨平台多媒体库。

  **特点**：易于使用，适合开发游戏或其他图形和多媒体应用。

- [**spdlog**](https://github.com/gabime/spdlog)
  
  跨平台的高性能 C++ 日志库，支持异步日志和多种输出方式。

  **特点**：日志记录效率高，支持多种输出格式，适用于高并发环境。

- [**benchmark**](https://github.com/google/benchmark)

  Google 提供的跨平台 C++ 性能测试库，用于测量代码的运行时间和性能。

  **特点**：支持微基准测试，易于与 CMake 集成，支持自定义输入参数和多线程测试，广泛用于评估代码性能和优化效果。

> [!TIP]
> 除了 sfml，所有库都是本人自行源码编译构建。
