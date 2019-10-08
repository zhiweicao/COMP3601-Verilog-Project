#include <windows.h>
#include "dpcdefs.h"
#pragma comment(lib,"dpcutil.lib")
#include "dpcutil.h"
#include <stdio.h>
#include <iostream>
#include <vector>
#include <fstream>
#include <string>


#define cchDevNameMax 28
#define REPS 5

using namespace std;

struct MusicData {
	int frequency;
	vector<int> data;
};

char device[cchDevNameMax];


HANDLE hif;

int data_amount = 3;



unsigned char output_reg = 1;
unsigned char input_reg = 1;
unsigned char data_in = 6;

static int GetReg(unsigned char r) {
	unsigned char b;
	ERC erc;


	if (!DpcGetReg(hif, r, &b, &erc, NULL)) {
		printf("DpcGetReg failed\n");
		DpcCloseData(hif, &erc);
		return -1;
	}

	erc = DpcGetFirstError(hif);
	if (erc == ercNoError) {
		return b;
	}
	return -1;

}



static int PutReg(unsigned char r, unsigned char b) {
	ERC erc;

	if (!DpcPutReg(hif, r, b, &erc, NULL)) {
		printf("DpcPutReg failed\n");
		DpcCloseData(hif, &erc);
		return -1;
	}

	erc = DpcGetFirstError(hif);
	if (erc == ercNoError) {
		return 0;
	}
	return -1;
}

int getDataFromFile(string dir, MusicData*& data) {
	ifstream if_file(dir);
	if (!if_file.is_open()) {
		return -1;
	}
	printf("succeed open file in getData function\n");
	string line;
	getline(if_file, line);
	int frequency = (int)(line[0]);
	unsigned int note, beats;
	vector<int> notes;
	for (int i = 1; i < line.size(); i += 2) {
		if (line[i] == '@') {
			break;
		}
		note = (int)line[i] - 96;     				//  ascii a = 97 
		beats = (int)line[i + 1] - '0';
		int combined = (beats << 5) + note;
		notes.push_back(combined);
	}
	if_file.close();

	MusicData* ret = new MusicData();
	ret->frequency = frequency;
	ret->data = notes;
	data = ret;
	return 0;
}

void loadingDataToBoard(MusicData& md) {
	if (PutReg(1, md.frequency) < 0) {
		printf("put register failed\n");
	}
	for (auto p : md.data) {
		auto note = p & 0b11111;
		auto beat =  p >> 5;
		cout << "note: " << note << "   beat: " << beat << endl;
		if (PutReg(1, p) < 0) {
			printf("put note to register failed\n");
		}

	}
}

int main(int argc, char* argv[]) {


	// initialisation
	int erc = 0;
	int id;
	int name;
	//int value;
	int i;

	printf("debug storage\n");
	printf("start connection\n");
	//initialise DLL
	if (!DpcInit(&erc)) {
		printf("DLL initialisation failed\n");
		return 0;
	}
	printf("initialise DLL done\n");

	//set up devices
	id = DvmgGetDefaultDev(&erc);
	if (id < 0) {
		DvmgStartConfigureDevices(NULL, &erc);
		id = DvmgGetDefaultDev(&erc);
	}
	// DvmgStartConfigureDevices(NULL, &erc);
	printf("start configuration\n");

	//returns id of default device

	printf("device id is %d\n", id);

	if (id == -1) {
		printf("No device found\n");
		return 0;  //? error type
	}

	name = DvmgGetDevName(id, device, &erc);

	printf("device is %s\n", device);



	// open data port
	if (!DpcOpenData(&hif, device, &erc, NULL)) {
		printf("data open failed\n");
		return -1;
	}
	printf("data port open succeed;\n");
	// read data from file
	MusicData* data = nullptr;
	if (getDataFromFile("output.txt", data) < 0) {
		printf("file open failed\n");
	}
	else {
		printf("file open succeed\n");
		loadingDataToBoard(*data);
	}


	//loading data
	// int n, reg_num, data_num;
	// std::cout << "incoming numbers:";
	// std::cin >> n;

	// for (i = 0; i < n; i++) {
	// 	std::cout << "register numbers:";
	// 	std::cin >> reg_num;
	// 	std::cout << "data numbers:";
	// 	std::cin >> data_num;
	// 	if (PutReg(reg_num, data_num) < 0) {
	// 		printf("put register failed\n");
	// 	}
	// }



	DpcCloseData(hif, &erc);

	printf("successfully send the data\n");
	int verificaiton = 0;
	while (cin >> verificaiton) {
		if (verificaiton == 1) {
			break;
		}
	}
	return 0;




}