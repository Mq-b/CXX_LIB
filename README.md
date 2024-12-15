# CXX_LIB

本仓库存储着使用 MSVC 工具链编译构建的常见 C++ 三方库。

版本：`Visual Studio Community 2022 (64 位) 17.11.3`。

编译器工具集：`v14`。

Visual Studio 版本之间的 C++ 存在[二进制兼容性](https://learn.microsoft.com/zh-cn/cpp/porting/binary-compat-2015-2017?view=msvc-170)，自 Visual Studio 2015 到 2022。

## 使用库

引入库十分的简单，将仓库克隆到本地：

```shell
git clone https://github.com/Mq-b/CXX_LIB
```

然后定义变量 `CMAKE_PREFIX_PATH` ，值为仓库的路径，它是用来设置 CMake 查找包路径的。

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
```

有些库还需设置 `bin` 环境变量或者直接将 `dll` 复制过来，因为是动态链接库，这不是 CMake 管理的。

## 相关库链接

- [cpp-terminal](https://github.com/jupyter-xeus/cpp-terminal)  
- [fmt](https://github.com/fmtlib/fmt)  
- [GTest](https://github.com/google/googletest)  
- [nlohmann_json](https://github.com/nlohmann/json)  
- [TBB](https://github.com/oneapi-src/oneTBB)  
- [sfml](https://github.com/SFML/SFML)  
- [spdlog](https://github.com/gabime/spdlog)  
