# ubuntu


**编译**

`bash ./curl-static-cross.sh`

编译完成后，将二进制文件拷贝到根目录：` cp release/bin/curl-linux-x86_64-glibc curl.exe`即可使用。

# 使用 

通过 curl 指定 http3-only 进行拉流测试：

```
./curl.exe --http3-only -v --retry 10 -s 'https://h3.livetest.com/ztest/A123.flv' --output /dev/null
```

通过将流重定向到`/dev/null`持续进行拉流测试。

# 压测

通过脚本启动 N 路同时进行拉流测试，如启动 100 路拉流命令：

```
bash ./start_curl.sh  100
```

# 网损

如果需要配置一定的网损，最好需要，否则`quic`中的很多代码逻辑`case`无法覆盖，可通过`tc.sh`进行配置，当前脚本默认为`lo`网卡配置 3% 的随机丢包和 25～35ms 的延迟，可直接修改脚本内的相关配置。

```
# 开启网损
bash ./tc.sh configure

# 查看网损配置
bash ./tc.sh show

# 清除配置
bash ./tc.sh cleanup

```
