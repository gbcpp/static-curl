#!/bin/bash

# 目标网络接口
INTERFACE="lo"

# 配置流量控制规则
configure() {
  # 添加限速
  sudo tc qdisc add dev $INTERFACE root tbf rate 1mbit burst 32kbit latency 400ms
  # 添加延迟和丢包
  sudo tc qdisc add dev $INTERFACE root netem delay 30ms 5ms distribution normal loss random 3%
  echo "已配置 3% 丢包率和 30～35ms 延迟抖动"
}

# 删除流量控制规则
cleanup() {
  sudo tc qdisc del dev $INTERFACE root
  echo "已删除流量控制规则"
}

show() {
  sudo tc qdisc show dev $INTERFACE root
}

# 主函数
main() {
  case "$1" in
  "configure")
    configure
    ;;
  "cleanup")
    cleanup
    ;;
  "show")
    show
    ;;
  *)
    echo "用法: $0 [configure|show|cleanup]"
    exit 1
    ;;
  esac
}

main "$@"
