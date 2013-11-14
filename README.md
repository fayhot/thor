thor
====

linux cd wrapper 之 飞雷神

日常开发中,经常需要在不同目录之间跳转. ctags只能在代码文件之间疯狂的跳转.  
文件目录之间的跳转现在只能很无奈的 cd  cd  cd ...  
运维以及平台的小伙伴们教了些招,pushd alias,环境变量等等,都还是不够快捷.  
根据需求适用shell封装了下 cd 命令, 基本达到了自由跳转的目的.  
centos下测试通过, 其他linux发行版未测试  
mac下测了下, tab自动补全的有异常,之后修复  

* 安装
  1. shell .bashrc 配置添加如下. /path/to/thor为thor文件路径

   ```shell
    if [ -x /path/to/thor ]; then
      . /path/to/thor
      alias t='thor'
      alias tl='thor -l'
      alias ta='thor -a'
      alias td='thor -r'
    fi
   ```
  2. 添加可执行权限
  
   ```shell
    chmod 755 /path/to/thor 
   ```  
  3. 重新加载bashrc
   
   ```shell
    source ~/.bashrc
   ```

* 使用方法
   ```shell
 1. thor -l          显示标记列表
 2. thor -a pin_name 添加标记
 3. thor -r pin_name 删除标记
 4. tl               thor -l 缩写
 5. td pin_name      thor -r pin_name 缩写
 6. ta pin_name      thor -a pin_name 缩写
  ```

* todo
 1. 修复mac下tab自动补全的bug
