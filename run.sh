#!/bin/bash
#安装json库
#git clone https://github.com/nlohmann/json.git
#cd json/
#cd build/
#cmake ..;make -j8;make install
#cd ../../

mkdir build

cd build

cmake ..

make -j8


./KYEPathData
