/*
 * 道路数据解析并获取最短路径类实现
 */

/* 
 * File:   KYEPathData.cc
 * Author: gml
 * 
 * Created on January 29, 2019, 5:22 PM
 */

#include "KYEPathData.h"
#include <stdexcept>
#include <fstream>
#include <sstream>
#include <algorithm>
#define KYE_MAX 100000
static const int NO_PARENT = -1;
void outputPath(int currentVertex, vector<int> parents,unordered_map<int, int> index_to_node_id, vector<float> &result){
    if(currentVertex == NO_PARENT)
        return;
    outputPath(parents[currentVertex], parents, index_to_node_id, result);
    result.push_back(index_to_node_id[currentVertex]);
}
void outputSolution(int endVertex, vector<float> distances, vector<int> parents,unordered_map<int, int> index_to_node_id, vector<float> &result){
    result.push_back(distances[endVertex]);
    outputPath(endVertex, parents, index_to_node_id,result);
}
vector<float> KYEPathData::DIJKSTRA(int start, int end){
    int nVertices = adjance_matrix.size();
    vector<float> dist_path, shortestDistances(nVertices);             //各顶点的距离值
    vector<int> parents(nVertices), added(nVertices);
    if(start < 0 || start > nVertices-1 || end < 0 || end > nVertices-1){
        throw invalid_argument("输入的顶点id错误，请检查！\n");
//        return nullptr;
    }
    for (int vertexIndex = 0; vertexIndex < nVertices; vertexIndex++) {
        shortestDistances[vertexIndex] = KYE_MAX;
        added[vertexIndex] = false;
    }
    shortestDistances[start] = 0;
    parents[start] = NO_PARENT;
    for (int i = 1; i < nVertices; i++) {
        int nearestVertex = -1;
        float shortestDistance = KYE_MAX;
        for (int vertexIndex = 0; vertexIndex < nVertices; vertexIndex++) {
            if(!added[vertexIndex] && shortestDistances[vertexIndex] < shortestDistance){
                nearestVertex = vertexIndex;
                shortestDistance = shortestDistances[vertexIndex];
            }
        }
        added[nearestVertex] = true;
        for (int vertexIndex = 0; vertexIndex < nVertices; vertexIndex++) {
            float edgeDistance = adjance_matrix[nearestVertex][vertexIndex];
            if(edgeDistance > 0 && (shortestDistance + edgeDistance < shortestDistances[vertexIndex])){
                parents[vertexIndex] = nearestVertex;
                shortestDistances[vertexIndex] = shortestDistance + edgeDistance;
            }
        }
    }
    outputSolution(end, shortestDistances, parents, index_to_nodeid, dist_path);
    return dist_path;
}
template<typename Out>
void split(const string &s, char delim, Out result) {
    stringstream ss(s);
    string item;
    while (getline(ss, item, delim)) {
        *(result++) = item;
    }
}
vector<string> split(const string &s, char delim) {
    vector<string> elems;
    split(s, delim, back_inserter(elems));
    return elems;
}
void KYEPathData::import_data_from_file(string link_data_path, string node_data_path){
    auto id = 0, snode = 0, enode = 0;
    auto dist = 0.0;
    string coords;  
    ifstream infile(link_data_path);
    while(infile >> id >> snode >> enode >> dist >> coords){
        auto got = node_to_index.find(snode);
        if(got == node_to_index.end()){
            node_to_index[snode] = node_to_index.size()-1;// in clang here should not minus one
            index_to_nodeid[node_to_index[snode]] = snode;
        }
        got = node_to_index.find(enode);
        if(got == node_to_index.end()){
            node_to_index[enode] = node_to_index.size()-1;
            index_to_nodeid[node_to_index[enode]] = enode;
        }
    }
    infile.clear(); infile.close();
    vector<vector<float> > graph(node_to_index.size(), vector<float>(node_to_index.size()));
    adjance_matrix = graph;
    for(int i = 0; i < node_to_index.size(); i++)
        for(int j = 0; j < node_to_index.size(); j++)
            adjance_matrix[i][j] = KYE_MAX;
    ifstream infile2(link_data_path);
    while(infile2 >>id >> snode >> enode >> dist >> coords){
        adjance_matrix[node_to_index[snode]][node_to_index[enode]] = dist;
        adjance_matrix[node_to_index[enode]][node_to_index[snode]] = dist;
        link_info[snode][enode] = Link();
        link_info[enode][snode] = Link();
        link_info[snode][enode].dist = dist;
        link_info[enode][snode].dist = dist;
        vector<string> coord_set = split(coords, ',');
        link_info[snode][enode].source_coord = {stof(coord_set[0]), stof(coord_set[1])};
        link_info[snode][enode].end_coord = {stof(coord_set[2]), stof(coord_set[3])};
        link_info[enode][snode].source_coord = {stof(coord_set[2]), stof(coord_set[3])};
        link_info[enode][snode].end_coord = {stof(coord_set[0]), stof(coord_set[1])};
    }
    infile2.clear(); infile2.close();
    ifstream infile3(node_data_path);
    string line, name, link_item;
    vector<string> tokens;
    while(getline(infile3, line)){
        istringstream iss(line);
        string token;
        while(getline(iss, token, '\t'))
            tokens.push_back(token);
        node_info[stoi(tokens[0])] = Node();
        node_info[stoi(tokens[0])].coord = {stof(tokens[2]), stof(tokens[3])};
        istringstream f(tokens[1]);
        while(getline(f, name, '|')){
            if(!tokens[1].empty()){
                name_to_nodeids[name].push_back(stoi(tokens[0]));
                node_info[stoi(tokens[0])].names.push_back(name);
            }
        }
        istringstream links(tokens[4]);
        while (getline(links, link_item, '|')) {
            node_info[stoi(tokens[0])].links.push_back(stoi(link_item));
        }
        tokens.clear();    
    }infile3.clear(); infile3.close();
}
KYEPathData::KYEPathData(string node_file_path, string link_file_path){
    KYEPathData::import_data_from_file(link_file_path, node_file_path);
}
KYEPathData::KYEPathData() {
    KYEPathData::import_data_from_file("/home/gml/kye/shortestPath/link_data",
            "/home/gml/kye/shortestPath/node_with_no_header");
}
json KYEPathData::get_shortest_path_info(string start_node_name, string end_node_name){
    auto got = name_to_nodeids.find(start_node_name);
    if(got == name_to_nodeids.end()){
        throw invalid_argument("input error source node name!");
        return {};
    }
    got = name_to_nodeids.find(end_node_name);
    if(got == name_to_nodeids.end()){
        throw invalid_argument("input error end node name!");
        return {};
    }
    auto end_nodes_id = name_to_nodeids[end_node_name];
    auto start_nodes_id = name_to_nodeids[start_node_name];
    float shortest_dist = KYE_MAX;
    vector<float> shortest_path_node;
    vector<float> dist_path;
    for (auto source : start_nodes_id)
        for(auto end : end_nodes_id){
            dist_path.clear();
            dist_path = DIJKSTRA(node_to_index[source], node_to_index[end]);
            if(dist_path[0] < shortest_dist){
                shortest_dist = dist_path[0];
                dist_path.erase(dist_path.begin());
                shortest_path_node.clear();
                shortest_path_node.resize(dist_path.size());
                for (auto i = 0; i < dist_path.size(); i++) {
                    shortest_path_node[i] = dist_path[i];
                }
            }
        }
    size_t size = shortest_path_node.size(); 
    json path_array = {};
    for (auto i = 0; i < size - 1; i++) {
      path_array.push_back({{"node id", static_cast<int>(shortest_path_node[i])}, 
      {"node coordinate", {link_info[static_cast<int>(shortest_path_node[i])][static_cast<int>(shortest_path_node[i+1])].source_coord.x,
      link_info[static_cast<int>(shortest_path_node[i])][static_cast<int>(shortest_path_node[i+1])].source_coord.y}}});
    }
    path_array.push_back({{"node id", static_cast<int>(shortest_path_node[size-1])},
    {"node coordinate", {link_info[static_cast<int>(shortest_path_node[size-2])][static_cast<int>(shortest_path_node[size-1])].end_coord.x,
      link_info[static_cast<int>(shortest_path_node[size-2])][static_cast<int>(shortest_path_node[size-1])].end_coord.y}}});
      
    json j_shortest_path_info = {{"shortest_dist",shortest_dist}, {"start node id" , static_cast<int>(shortest_path_node[0])},
    {"start node coordinate", {node_info[static_cast<int>(shortest_path_node[0])].coord.x,node_info[static_cast<int>(shortest_path_node[0])].coord.y}},
    {"end node id", static_cast<int>(shortest_path_node.back())}, 
    {"end node coordinate", {node_info[static_cast<int>(shortest_path_node.back())].coord.x, node_info[static_cast<int>(shortest_path_node.back())].coord.y}},
    {"path from end node to source node", path_array}};
//    cout<< j_shortest_path_info <<endl;
    return j_shortest_path_info;
}
KYEPathData::KYEPathData(const KYEPathData& orig) {
}

KYEPathData::~KYEPathData() {
}

