
#remove lateset version of boost
sudo apt-get --purge remove libboost-dev libboost-doc  2> /dev/null 
#download boost 1.58
sudo apt-get update 
sudo apt-get install net-tools cmake -y
sudo apt-get install build-essential 
wget http://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.gz
tar -xf boost_1_58_0.tar.gz
#usage generator
echo "###############################################################"
echo "#                                                             #"
echo "#                 start Build boost                           #"
echo "#                 don't worry about warnnings                 #"
echo "#                                                             #"
echo "###############################################################"

cd boost_1_58_0/
./bootstrap.sh --prefix=/usr/
sudo ./b2
sudo ./b2 install
cd ..
#copy lib to COMMONAPI
copyToLib(){
    mkdir ../../COMMONAPI 
    cp -d lib* ../../COMMONAPI 
    cd ../../
}
#capicxx-core
git clone https://github.com/GENIVI/capicxx-core-runtime.git
cd  capicxx-core-runtime
git checkout tags/3.1.12.6
mkdir build
cd build
cmake ..
make -j 
if [ $? -ne 0 ]
then
echo "Error in capicxx-core-runtime"
exit -1
fi
echo "Succeffully installed capicxx-core-runtime "
sleep 1
copyToLib
#vsomeip
git clone http://github.com/GENIVI/vSomeIP.git
cd vSomeIP
git checkout tags/2.14.16
mkdir build
cd build
cmake ..
make -j 
if [ $? -ne 0 ]
then
echo "Error in someip"
exit -1
fi
copyToLib

#capixx-someip
git clone https://github.com/GENIVI/capicxx-someip-runtime.git
cd capicxx-someip-runtime
git checkout tags/3.1.12.9
mkdir build
cd build
cmake -DUSE_INSTALLED_COMMONAPI=OFF ..
make -j
if [ $? -ne 0 ]
then
echo "Error in capicxx-someip-runtime"
exit -1
fi
copyToLib
#generator
wget https://github.com/COVESA/capicxx-core-tools/releases/download/3.1.12.4/commonapi-generator.zip
wget https://github.com/COVESA/capicxx-someip-tools/releases/download/3.1.12/commonapi_someip_generator.zip
sudo apt install openjdk-8-jdk -y
unzip commonapi-generator.zip -d commonapi-generator
unzip commonapi_someip_generator.zip -d commonapi_someip_generator
chmod +x commonapi-generator/commonapi-generator-linux-x86_64
chmod +x commonapi_someip_generator/commonapi-someip-generator-linux-x86_64
#usage generator
echo "###############################################################"
echo "#                                                             #"
echo "#                 Usage of generator                          #"
echo "#                                                             #"
echo "#                                                             #"
echo "###############################################################"

echo " ~/commonapi-generator/commonapi-generator/commonapi-generator-linux-x86_64 -sk <fidl file > "
echo " ~/commonapi_someip_generator/commonapi-someip-generator-linux-x86_64 -ll verbose <fdepl file>"

echo " export \"LD_LIBRARY_PATH=${PWD}/COMMONAPI\"" >> ~/.bashrc

echo "###############################################################"
echo "#                                                             #"
echo "#                 Example Hello World                         #"
echo "#                 you just need to update CMakeLists.txt      #"
echo "#                 with your paths                             #"
echo "###############################################################"
git clone https://github.com/moatasemelsayed/vsomeip_helloworld.git

bash
