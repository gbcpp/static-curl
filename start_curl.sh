#!/bin/bash

# 检查是否传入启动路数参数
if [ $# -ne 1 ]; then
  echo "用法: $0 <启动路数>"
  exit 1
fi

# 获取启动路数
num_runs=$1

# 要请求的 URL
url="https://h3.livetest.com:443/ztest/A123.flv"

# 启动指定路数的 curl 进程
start_curl_processes() {
  local current_runs=$(ps -ef | grep "curl.exe" | grep -v grep | wc -l)
  local runs_to_start=$((num_runs - current_runs))

  echo "will start: " $runs_to_start

  for ((i = 0; i < runs_to_start; i++)); do
    ./curl.exe --http3-only -v --retry 10 -s "$url" --output /dev/null &
    sleep 0.3
  done
}

# 初始启动
start_curl_processes

# 定时检查并拉起缺失的进程
while true; do
  sleep 5
  start_curl_processes
done
