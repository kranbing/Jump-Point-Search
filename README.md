# AI project --JPS

#### 介绍
人工智能课程设计的代码仓库

在实际生活中，我们经常想找从一个位置到另一个位置的路径。我们不仅试图找到其中最短的路径，还希望考虑到时间成本。本论文通过一种改进后的寻路算法对路径进行要找到此路径，我们可以使用图搜索算法，该算法在将地图表示为图（Graph）这种数据结构时起作用。
论文简要回顾了A*搜索算法的基本原理。该算法作为一种启发式搜索算法，其中关键的一步是向待寻路节点四周扩展节点并生成openlist，但当地图较大的情况下，A*搜索的效率会显著降低。于是考虑一种算法使得只寻找对搜索方向有影响的点，由于这些点显然不是连续的，所以被称为跳点（Jump Points）。
本文的核心即是以跳点为核心概念的JPS算法的介绍与分析，该算法在A*的基础上优化openlist只存储跳点，跳过不必要的点以达到提升效率的目的。为直观显示二者性能差距，论文设计了一组简单的对照实验，体现两种算法的内存占用和时间效率。


#### 特技

1.  使用 Readme\_XXX.md 来支持不同的语言，例如 Readme\_en.md, Readme\_zh.md
2.  Gitee 官方博客 [blog.gitee.com](https://blog.gitee.com)
3.  你可以 [https://gitee.com/explore](https://gitee.com/explore) 这个地址来了解 Gitee 上的优秀开源项目
4.  [GVP](https://gitee.com/gvp) 全称是 Gitee 最有价值开源项目，是综合评定出的优秀开源项目
5.  Gitee 官方提供的使用手册 [https://gitee.com/help](https://gitee.com/help)
6.  Gitee 封面人物是一档用来展示 Gitee 会员风采的栏目 [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)
