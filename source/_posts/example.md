---
title: Test-Page
top-img: Blog/themes/butterfly/source/img/test-page.png
---

# 容器技术基础


## 容器的本质与核心技术
容器本质上是受资源限制、彼此隔离的 Linux 进程集合，其核心目标是实现应用在沙箱环境中的独立运行。支撑容器技术的三大核心技术包括：
 - `Namespace`：（实现资源隔离），包括 PID（进程）、NET（网络）、Mount（文件系统）等 6 种命名空间，使容器拥有独立的 "系统视图"。
 - `Cgroups`：进行资源限制，控制容器对 CPU、内存、磁盘 IO 等资源的使用上限，避免资源竞争。
 - `Unionfs`：设计镜像分层机制，通过只读层 + 可写层的组合，实现镜像的高效存储与复用。

## Docker 运行原理与架构
Docker 作为早期容器技术的代表，简化了容器的创建与管理流程。其核心架构包括：
 - Docker Client：命令行交互工具（如docker run）
- dockerd：守护进程，负责接收客户端请求并调度底层组件
- containerd：从 Docker 拆分出的核心组件，负责容器生命周期管理（创建、启动、销毁）、镜像拉取等
- runc：容器运行时的具体实现，基于 OCI 标准，直接与 Linux 内核交互
- Docker 工作流程：用户通过`docker run发起请求→dockerd 转发至 containerd→containerd 调用 runc 创建容器→借助 Namespace 和 Cgroups 实现隔离与限制`

## 容器技术编年史
2008 年：Linux 内核引入 Cgroups，为资源限制奠定基础。
2013 年：Docker 开源，首次将容器技术推向大众，简化了容器创建流程。
2015 年：OCI（开放容器倡议）成立，制定容器镜像与运行时标准，runc 成为参考实现。
2016 年：containerd 从 Docker 拆分，成为独立项目并加入 CNCF。
2021 年：Kubernetes 1.24 移除 dockershim，正式弃用 Docker 作为运行时，推荐 containerd。

# containerd(容器运行时的核心角色)
## containerd 的定位与作用
containerd 是一个轻量级、高性能的容器运行时，专注于容器生命周期的完整管理，核心功能包括：
- 容器生命周期管理（创建、启动、停止、销毁）
- 镜像管理（拉取、推送、存储）
- 与底层运行时（如 runc）交互，执行容器实际操作
- 网络与存储管理，为容器提供隔离的网络环境与持久化存储
- 作为符合 CRI（容器运行时接口）规范的组件，containerd 可无缝集成 Kubernetes、Swarm 等编排工具，成为云原生基础设施的核心底层组件
## containerd 与 Docker、K8s的关系
三者在技术栈中属于不同层级，关系如下：
- Docker：上层工具，整合了 containerd、镜像构建、CLI 等功能，面向开发者提供完整工作流（如docker build、docker run）。
- containerd：底层运行时，是 Docker 的核心依赖，同时也是 K8s推荐的运行时（通过 CRI 接口对接）。
- K8s：编排层，通过 kubelet 与 containerd 交互，管理集群中容器的调度与扩缩容。

调用链对比：

> Docker 作为 K8s运行时：kubelet → dockershim → dockerd → containerd → runc
> containerd 作为 K8s 运行时：kubelet → cri-plugin → containerd →runc（链路更短，性能更优）

#  K8s
Kubernetes（简称 K8s）是一款开源的容器编排平台，能自动化管理容器的部署、扩展、调度及运维，通过 Pod、Service、Ingress 等资源抽象，实现大规模容器集群的高效管理，是云原生技术栈的核心基石。

## K8s
{% btn 'https://butterfly.js.org/',Butterfly,far fa-hand-point-right,pink larger %}

---

# 总结
以上就是今天要讲的内容，本文仅仅简单介绍了pandas的使用，而pandas提供了大量能使我们快速便捷地处理数据的函数和方法。