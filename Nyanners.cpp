//
//  main.cpp
//  NubletsProyect
//
//  Created by Justin on 7/2/14.
//  Copyright © 2014 Justin. All rights reserved.
//

#include <iostream>
#include <cstdlib>
#include <ctime>
using namespace std;

int genRandom(int a, int b);
int randomBoolean();
void printNyan();
void addNyan(int &x);
void printIntro();
void nyanBomb();

//The nyan
class Nyan {
    public:
    Nyan();
    Nyan(int setWarmthFactor);
    ~Nyan();
    int warmthFactor;
    unsigned int bustSize;
    unsigned int deflated;
    int aggression;
    char name[];
    
    void goNyan() const;
    //Constant function won't change shit
    int getDeflation() const;
    
    //Inline declaration
    int getWarmth() {
        return warmthFactor;
    }
    void setWarmth(int a) {
        warmthFactor = a;
    }
};

//What nyan makes you make
class jazzStain {
public:
    jazzStain() {}
    ~jazzStain() {}
    void changeName(string nameIn);
    string getName();
    int smelliness;
private:
    string jName;
};

void getStank(jazzStain arr[], int length);
void listStains(jazzStain arr[], int length);

//Function that takes an object reference as parameters
const Nyan & makeHerNyan (const Nyan & theNyan);

//Main
int main() {
    // insert code here...
    srand((unsigned)time(NULL));
    printIntro();
    cout << "Let's get some nyanners from AnimeSpots!\n";
    int i, m;
    int nyansOwned = 0;
    int nyansPurchased = 0;
    
    
    
    //Some chance variables
    //Defaults: 60, 400
    int jazzChance = 60;
    int maxWarmth = 400;
    
    
    //Array of pointers to track the stains
    //jazzStain * stainArray[50];
    int numStains = 0;
    //Array of waiting stains
    jazzStain stainList[50];
    
    //Create a pointer to access the # owned
    //int * pOwned = &nyansPurchased;
    int comasEntered = 0;
start:
    cout << "How many nyanners should we get?\n";
    cin >> m;
    nyansPurchased += m;
    //cout << endl << nyansOwned << " : " << m << endl;
    Nyan Hanekawa;
    cout << endl << "Let's go to Animespots NAO!!!!";
    int deflationStatus;
    string nameIn;
    
    
    for (i=0; i < m; i++) {
        cout << endl;
        Hanekawa.bustSize = genRandom(40, 100);
        Hanekawa.deflated = randomBoolean();
        Hanekawa.setWarmth(genRandom(4, maxWarmth));
        Hanekawa.aggression = genRandom(0, 100);
        
        cout << "We got nyanners number " << (i+1) << endl;
        printNyan();
        //nyansOwned++;
        addNyan(nyansOwned);
        //Hanekawa.goNyan();
        makeHerNyan(Hanekawa);
        cout << "This Nyanners' deflation status....";
        deflationStatus = Hanekawa.getDeflation();
        if (deflationStatus == 0) {
            cout << "Nyan! I'm fluffy!";
        } else {
            cout << "Nyan! I'm deflated :(";
        }
        cout << endl << "Nyan nyill nyake nyou " << Hanekawa.getWarmth() << "x nyas nyarm!!!!\n";
        if (Hanekawa.getWarmth() > 300) {
            cout << "~~~~~~~~~~~~~~~\n";
            cout << endl << "You just went into coma from overheating.";
            comasEntered++;
            
            //Add a 60% chance to jazz
            if (genRandom(0, 100) < jazzChance) {
                //jazz!
                cout << "\n\nLooks like you got excited and created jazz.\n";
                cout << "Name your jazz stain: ";
                cin >> nameIn;
                stainList[numStains].changeName(nameIn);
                stainList[numStains].smelliness = genRandom(4, 10);
                cout << "You just named this stain " << stainList[numStains].getName() << endl;
                numStains++;
            }
        }
        if (Hanekawa.aggression >= 98) {
            cout << "!!!!!!!!!!" << endl;
            cout << "\nNyanners scratched you! You have perished after only obtaining " << (i+1) << " nyanners!\n\n";
            nyanBomb();
            cout << "Goruuuuu...\n\n";
            goto end;
        }
        cout << endl << "------------------\n";
    }

    cout << endl;
    cout << "You now have " << nyansPurchased << " nyans after buying " << nyansPurchased << ". ";
    cout << "You entered " << comasEntered << " comas from overheating, jazzing " << numStains << " time(s). ";
    getStank(stainList, numStains);
menu:
    cout << "Here are your options:\n";
    cout << "  -Enter 'y' to get more nyans\n";
    cout << "  -Enter 'n' if you had enough nyans\n";
    cout << "  -Enter 'j' to check your stain collction\n";
    char in;
redo:
    cin >> in;
    switch (in) {
        case 'Y':
        case 'y':
            cout << "Let's get more nyans!!\n";
            goto start;nyanners.cpp

            break;
        case 'N':
        case 'n':
            cout << "Seems like you're done with nyans.\n";
            break;
        case 'J':
        case 'j':
            cout << endl << endl;
            listStains(stainList, numStains);
            cout << "Back to menu.\n\n";
            goto menu;
        default:
            cout << "What? (y/n/j)\n";
            goto redo;
    }
end:
    cout << "You ended up owning " << nyansOwned << " while purchasing " << nyansPurchased << " nyans." << endl;
    listStains(stainList, numStains);
    getStank(stainList, numStains);
    cout << endl << endl;
    cin.get();
    return 0;
}

void addNyan(int &rx) {
    rx++;
}

void printNyan() {
    cout << endl;
    cout << "  ^   ^  " << endl;
    cout << "  n . n  \n" ;
    cout << " =  w  =  \n";
    cout << endl;
}

int genRandom(int a, int b) {
    return rand()%(b+1) + a;
}

int randomBoolean() {
    return rand()%2;
}

//Passed nyan
const Nyan & makeHerNyan (const Nyan & theNyan) {
    cout << "Let's make her nyan.";
    theNyan.goNyan();
    return theNyan;
}

void printIntro() {
    cout << "=================================\n\n";
    cout << "  Nyan Aquisition Simulator 0.1  \n\n";
    cout << "=================================\n\n";
}

void getStank(jazzStain arr[], int length) {
    int totalStank = 0;
    for (int i = 0; i < length; i++) {
        totalStank += arr[i].smelliness;
    }
    cout << "The room's stank level is " << totalStank << endl;
}

void listStains(jazzStain arr[], int length) {
    cout << "There are " << length << " jazz stains from you. ";
    cout << "Here are your stains: ";
    for (int i = 0; i < length; i++) {
        cout << "\n  #" << (i+1) << ". " << arr[i].getName() << ".. " << arr[i].smelliness << "stank points.";
    }
    cout << endl;
}

void nyanBomb() {
    for (int i = 0; i < 100; i++) {
        if (i%10 == 0) {
            cout << "Nyaaaaha";
            int k = genRandom(1, 6);
            for (int j = 0; j < k; j++) {
                cout << "ha";
            }
            cout << "!!\n";
        }
    }
}



/*=================

Nyanners' functions

==================*/

void Nyan::goNyan() const {
    cout << endl;
    cout << "Nyaaaahahahahahahaha\n";
    cout << "Ny nyust nyize nyis " << bustSize << " nyans" << endl;
    return;
}

int Nyan::getDeflation() const {
    //cout << deflated;
    return deflated;
}

//Overloaded Constructors
Nyan::Nyan() {
    warmthFactor = 0;
}
Nyan::Nyan(int setWarmthFactor) {
    warmthFactor = setWarmthFactor;
}

//Destructor
Nyan::~Nyan() {
}

// jazzstain functions
void jazzStain::changeName(string nameIn) {
    jName = nameIn;
}
string jazzStain::getName() {
    return jName;
}
