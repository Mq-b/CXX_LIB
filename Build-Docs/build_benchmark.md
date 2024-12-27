# build_benchmark

- <https://github.com/google/benchmark>

你需要参考谷歌仓库中的 README 提到的构建，但是如果你照抄，几乎不可能构建并成功引入。

## 编译构建

```shell
git clone https://github.com/google/benchmark
cd .\benchmark\
cmake -E make_directory "build"
cmake -E chdir "build" cmake -DBENCHMARK_DOWNLOAD_DEPENDENCIES=on -DCMAKE_BUILD_TYPE=Release ../
cmake --build "build" --config Release -j
cmake --build "build" --config Debug -j
```

## install

下面就是 install 了：

```shell
cd build
cmake --install . --prefix "D:\CXX_LIB\benchmark" --config Release
cmake --install . --prefix "D:\CXX_LIB\benchmark" --config Debug
```

> [!TIP]
> `--prefix` 指定安装路径，可以随意修改。
> 如果使用 Ninja 会略有改变，我们使用 MSVC 工具链，CMake 默认生成的 `sln` 解决方案是支持多配置的构建系统的，所以我们能直接 `--config`。

谷歌在 windows 中即使执行了我们前面的 install，也不会把 Debug 和 Release 复制过来，其实也没用。因为它不区分这两种产物的名字。

你们可以选择直接进入 `benchmark\build\src` 里将 Debug 和 Release 文件夹复制到你的安装目录 `benchmark\lib` 中。

其实复制过来也没用，CMake 查找不了，意思是如果你需要用 Debug 模式就把 Debug 中的库复制到 `benchmark\lib` 这个外层，就能正常查找了。

---

这种做法显然过度的愚蠢，我们通过修改 [`benchmarkTargets-debug.cmake`](../benchmark/lib/cmake/benchmark/benchmarkTargets-debug.cmake) 与 [`benchmarkTargets-release.cmake`](../benchmark/lib/cmake/benchmark/benchmarkTargets-release.cmake) 包文件，重新设置查找静态库的路径为：

- [benchmark\lib\Debug](../benchmark/lib/Debug/)

- [benchmark\lib\Release](../benchmark/lib/Release/)

也得以智能的选择合适构建的库。

## 测试使用

引入库：

```CMake
find_package(benchmark REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE benchmark::benchmark)
```

测试代码：

```cpp
#include <benchmark/benchmark.h>

static void test_string(benchmark::State& state) {
    auto func = [](const std::string&str) {
        std::string s{ str };
    };
    for (auto _ : state) {
        // This code gets timed
        func("乐呵..........................................................................");
    }
}

BENCHMARK(test_string);

static void test_string_view(benchmark::State& state) {
    auto func = [](std::string_view str) {
        std::string s{ str };
    };
    for (auto _ : state) {
        // This code gets timed
        func("乐呵..........................................................................");
    }
}

BENCHMARK(test_string_view);
// Run the benchmark
BENCHMARK_MAIN();
```

## 总结

其实构建成功后，具体怎么做，都可以随便你，只是我懒得在 CMakeLists.txt 中写 if 而已。还是想用 `find_package` 和 `target_link_libraries`。
