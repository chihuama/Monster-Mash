
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sstream>
#include <fstream>
#include <iostream>
#include<algorithm>

using namespace std;

#define NUM 10000
#define buffer 512

int YearStart = 1890;
int YearEnd = 2012;

const char *MonsterList[28] = {"Zombies", "Frankenstein's monster", "Alien", "Xenomorph", "Vampire", "Dracula", "Robot", "Werewolf", "Witch", "Mutant",	                           "Demons", "Ghost", "Bigfoot", "Yeti", "Sasquatch", "Devil", "Satan", "Dragon", "Phantom", "Sabertooth", "Godzilla",					           "Cyclops", "Mummy", "Predator", "Dinosaurs", "Mermaid", "Android", "Anaconda"};


// transfer a single qoute to a single Tab
string Quote_2_Tab (string s) {
	int loc = -1;
    while((loc = s.find(",",loc+1)) != std::string::npos)  // Single quote
    {
         s.replace(loc,2,"	");  // Tab
    }
	return s;
    //cout << s << endl;
}


int main(int argc, char* argv[]) {

	/****************************** load files *****************************/
	FILE *fileName;
	if ((fileName = fopen("sampleMonster.tsv", "r"))==NULL) {
		printf( "File could not be opened\n" );
		exit(0);
	}
	char buff_file[buffer];

	/***************************** output files *****************************/

	// output file for processing reading
	FILE *fout;
	char file_new[buffer];
	sprintf(file_new,"%s.txt","overview");
	if ((fout = fopen(file_new,"w"))==NULL)
	{
		printf("cannot open file\n");
	}

	int *YearNum = new int[NUM];
	memset(YearNum,0,sizeof(YearNum));
	int totalNum = 0;

	int MonsterNum[NUM][28];
	memset(MonsterNum, 0, sizeof(MonsterNum));

	/***************************** read input file ****************************/

	string sin, sout;
	ifstream inputFile("sampleMonster.tsv");
	int yearid;
	//if(inputFile.is_open()) {

	while (fgets(buff_file,sizeof(buff_file),fileName)!=NULL) {

		// strip trailing '\n' if it exists
        int len = strlen(buff_file)-1;
        if(buff_file[len] == '\n') 
           buff_file[len] = 0;

		//getline(inputFile,sin);
		//stringstream ss;
		//ss << buff_file;
		//ss >> sin;
		sin = buff_file;
		sin.erase(remove( sin.begin(), sin.end(), '\"' ), sin.end());  // remove double qutoes
		//istringstream iss(sin);
		sout = Quote_2_Tab(sin); // replace the single quote into single Tab
		//istringstream iss(sout);

		// split string by Tab
		istringstream iss(buff_file);
		string s, s2;
		int n = 0;
		while ( getline( iss, s, '	' ) ) {
			//printf( "'%s'\n", s.c_str() );
			n++;

			if (n==2) {    // get the year data
				printf( "\n\n%s	", s.c_str());
				for (int i=YearStart; i<=YearEnd; i++) {
					if (i==atoi(s.c_str())) {
						YearNum[i-YearStart]++;
						yearid = i-YearStart;
						break;
					}
				}
			}

			if (n>=3) {    // get the moster type	
				//if (n==3)
					//s2 = s.erase(remove( s.begin(), s.end(), '\r\n' ), s.end());  // remove \n

				printf( "%s;", s.c_str());
				for (int j=0; j<28; j++) {
					if (strcmp(MonsterList[j], s.c_str())==0) {
						MonsterNum[yearid][j]++;
						//printf( "\n%s : %s", "same", s.c_str() );
						break;
					}
				}
			} // end - if(n==3)

		} // end while
		//printf("\n");
	} //end while

	fclose(fileName);

	/************************** write output file ***************************/

	fprintf(fout, "%s	%s", "Year", "Total");
	for (int i=0; i<28; i++) {
		fprintf(fout, "	%s", MonsterList[i]);
		//printf("%s\n", MonsterList[i]);
	}
	fprintf(fout, "\n");

	for (int i=0; i<=(YearEnd-YearStart); i++) {
		fprintf(fout, "%d	%d", i+YearStart, YearNum[i]);
		totalNum += YearNum[i];	

		for (int j=0; j<28; j++)
			fprintf(fout, "	%d", MonsterNum[i][j]);

		fprintf(fout, "\n");
	}
	printf("total number of the monster film is : %d\n", totalNum);

    return 0;
}
