/*
 * 获取最短路径类，使用方法如下：
 * 先通过带参数构造函数保存，再通过get_shortest_path_info接口返回指定起点到终点的距离和路径信息
 * 注意事项：
 * 1.必须是结构化数据，格式参考link.txt和node.txt 去除文件头 节点id是非负数，不可重复
 * 2.需要c++11以上编译器支持，通过make file编译安装nlohmann_json. 
 */ 

/* 
 * File:   KYEPathData.h
 * Author: gml
 *
 * Created on January 29, 2019, 5:22 PM
 */

#ifndef KYEPATHDATA_H
#define KYEPATHDATA_H
#include <string>
#include <nlohmann/json.hpp>
#include <vector>
#include <unordered_map>
using namespace std;
using json = nlohmann::json;

class KYEPathData {
public:
    // 构造函数，先通过传递一个node文件和一个link文件，构建
    KYEPathData(string node_file_path, string link_file_path);
    
    // 获取最短路径方法，输入一个起始节点名字和一个终止节点名字，返回json格式数据
    json get_shortest_path_info(string start_node_name, string end_node_name);
    
    KYEPathData() ;
    KYEPathData(const KYEPathData& orig);
    virtual ~KYEPathData();
private:    
    struct Point{
        float x;
        float y;
    };
    struct Node{
        vector<string> names;
        struct Point coord;
        vector<int> links;
    };
    struct Link{
        float dist;
        struct Point source_coord;
        struct Point end_coord;
    };
    // 第一个key是source nodeid，第二个key是end nodeid，保存link数据
    unordered_map<int, unordered_map<int, struct Link> > link_info;
    // key是nodeid，保存node数据
    unordered_map<int, struct Node> node_info;
    // 索引值对应的顶点距离邻接矩阵
    vector<vector<float> > adjance_matrix;
    // 从索引值到nodeid的映射字典
    unordered_map<int, int> index_to_nodeid;
    // 从nodeid到索引值的映射字典
    unordered_map<int, int> node_to_index;
    // 从名字到nodeid的映射字典
    unordered_map<string, vector<int> >name_to_nodeids;
private:
    // 求指定起点nodeid和终点nodeid的最短距离
    vector<float> DIJKSTRA(int start, int end);
    // 解析文件，创建结构并保存到类属性，便于后续查询
    void import_data_from_file(string link_data_path, string node_data_path);
};

#endif /* KYEPATHDATA_H */

