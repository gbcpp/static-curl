#!/bin/bash

# 目标网络接口
INTERFACE="lo"

# 配置流量控制规则
configure() {
  #sudo tc qdisc add dev $INTERFACE tbf root rate 1mbit burst 32kbit latency 400ms
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
    echo "用法: $0 [configure|cleanup]"
    exit 1
    ;;
  esac
}

main "$@"
