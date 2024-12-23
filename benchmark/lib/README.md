愚蠢的谷歌非常的愚蠢，事实上你是不可能按照它的构建教程获取到合适的版本并简单引入的。

它不区分Debug和Release。如果你需要Debug的内容就将它复制出来使用。

具体来说，你执行

```cmake
cmake --install . --config Debug
cmake --install . --config Release
```

依然只会有一个版本的而已，你用不了，你要吗手动复制过来，然后自己操作。要吗 CMakeList.txt 里写 if，我反正不想。

或者改用包管理器，这或许是个合适的选择，但是本仓库是源码构建。