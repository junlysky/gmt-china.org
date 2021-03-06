+++
title = "绘制地球内部主要界面"
date = "2016-08-31"
categories = ["GMT示例"]
tags = ["射线"]
authors = ['seisman']
images = ["earth-discontinuities.png"]
commands = ["psbasemap", "pstext"]
+++

在利用地震波研究地球深部结构时，经常需要绘制震相在深度剖面下的射线路径，同时也需要绘制地球内部的主要界面。

震相的射线路径可以用 [TauP](http://www.seis.sc.edu/taup/) 提供的 `taup_path` 命令计算得到，然后在极坐标系 `-JP` 中绘制。难点在于如何绘制几个主要界面。

本示例将展示如何绘制震中距为30度的 PcP 和 PKiKP 震相的射线路径，同时绘制地球内的410、660界面以及 CMB 和 ICB。最终的绘图效果如下：

{{< figure src="/example/ex002/earth-discontinuities.png" title="震相射线路径" width="300px">}}

绘图脚本如下：

{{< include-code "/example/ex002/plot-earth-discontinuities.sh" bash >}}

脚本中使用了五个 `psbasemap` 命令分别绘制五个界面。

- 第一个 `psbasemap` 用于绘制地表， `-Byg6371` 表明要在 Y 方向（极坐标下即 R 方向）以6371为间隔绘制网格线，由于地球半径是6371，所以理论上会在R=0和 R=6371 两处绘制网格线。 `-Bs` 的作用是只绘制 R=6371 处的网格线，且只绘制网格线而不绘制刻度；
- 第二个 `pabasemap` 用于绘制410界面，其与前一命令基本相同，唯一的区别是 `-Byg6371+5961` 中多了 `+5961`，其作用是定义网格线的起算点，即此时将在 R=5961（即410界面）处绘制网格线。
- 其他同理
