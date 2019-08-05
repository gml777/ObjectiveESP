/*
 * 获取最短路径类，使用方法如下：
 * 先通过带参数构造函数保存，再通过get_shortest_path_info接口返回指定起点到终点的距离和路径信息
 * 注意事项：
 * 1.必须是结构化数据，格式参考link.txt和node.txt 但是需要去除文件头，正式输入的文件格式参考link_data node_with_no_header 节点id是非负数，不可重复
 * 2.需要c++11以上编译器支持，通过make file编译安装nlohmann_json. 
 */ 

    // 构造函数，先通过传递一个node文件和一个link文件，构建道路数据
    KYEPathData(string node_file_path, string link_file_path);
    
    // 获取最短路径方法，输入一个起始节点名字和一个终止节点名字，返回json格式数据
    json get_shortest_path_info(string start_node_name, string end_node_name);

将整个工程克隆到本地，运行示范程序如下操作：
0.如果没有安装nlohmann json库，需要打开run.sh的3~7行 如果没有cmake 请先安装cmake 需要c++11以上编译器支持
1.将demo.cc里的node 和 link文件路径改成你实际的本地对应文件路径
2.修改get_shortest_path_info里的起始和终止节点名字为你需要的名字
3.chmod 777 run.sh; ./run.sh
