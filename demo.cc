/*
 * 道路数据接口使用示范
 */

/* 
 * File:   newmain.cc
 * Author: gml
 *
 * Created on January 29, 2019, 5:23 PM
 */

#include <cstdlib>
#include <iostream>
#include "KYEPathData.h"
using namespace std;

/*
 * 道路数据接口调用示范程序
 * node文件路径是"/home/gml/kye/shortestPath/node_with_no_header",
 * link文件路径是 "/home/gml/kye/shortestPath/link_data"
 * 起始节点名字"7-1"
 * 终止节点名字"19"
 * 返回的最短路径信息是json对象path_info
 */
int main(int argc, char** argv) {
    cout<<"道路数据最短路径调用示范：" <<endl;
    KYEPathData demo = KYEPathData("/home/gml/kye/shortestPath/node_with_no_header", "/home/gml/kye/shortestPath/link_data");
    json path_info = demo.get_shortest_path_info("7-1", "19");
    cout << path_info <<endl;
    return 0;
}

