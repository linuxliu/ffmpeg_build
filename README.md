该项目为编译 android 和ios(后续添加)的 openssl 和ffmpeg
其中openssl的版本必须为1.0.x 及其以下版本，原因为 在1.1.x版本上 ffmpeg config
检查的SSL_library_init 不存在, 1.1.x上SSL_library_init 替换为了OPENSSL_library_init

ffmpeg 采用的版本为4.0.3,目前在4.1上编译有问题，不正正确编译，原因未知

项目介绍
compile-openssl.sh 为编译 openssl的
compile-ffmpeg.sh 为编译ffmpeg的
都支持全部编译和某个平台的编译
如 ./compile-openssl.sh all
包含 armv5 armv7a arm64 x86 x86_64
./compile-openssl.sh armv5
只编译armv5
文件module.sh为 ffmpeg的定制化参数.详情参考ffmpeg介绍
编译脚本借用了ijkplayer 的编译脚本