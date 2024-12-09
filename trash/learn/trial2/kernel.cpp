class StdStringBase {
public:
    char* ca; // Pointer to the character array
    int length; // Length of the string

    // Constructor initializes length and assigns ca to null initially.
    // Derived classes will allocate and manage memory for ca.
    StdStringBase(int len) : ca(nullptr), length(len) {}
};

class StdString : public StdStringBase {
public:
    char ca_storage[2];

    StdString(const char initString[32]) : StdStringBase(2) {
        ca = ca_storage; // Pointing ca to the actual storage
        for (int i = 0; i < length; ++i) {
            ca[i] = initString[i];
        }
    }
};

class StdString32 : public StdStringBase {
public:
    char ca_storage[32];

    StdString32(const char initString[32]) : StdStringBase(32) {
        ca = ca_storage; // Pointing ca to the actual storage
        for (int i = 0; i < 31; i++) {
            ca[i] = initString[i];
        }
        ca[31] = '\0'; // Ensuring null termination
    }
};

void stdPrint(StdStringBase& s) {
    char* vidLoc = reinterpret_cast<char*>(0xB8000);
    for (int i = 0; s.ca[i] != '\0'; i++) {
        vidLoc[2 * i] = s.ca[i];      // Set character
        vidLoc[2 * i + 1] = 0x07;     // Set attribute
    }
}

void dummyPrint(){
    char vari = 'A';
    char* vidLoc = reinterpret_cast<char*>(0xB8000);
    for (int i = 0; i <= 5; i = i + 2){
        *vidLoc = vari;
        vidLoc = vidLoc + i;
        vari++;
    }
}

void lessDumbPrint() {
    char vari[] = "Hello World!";
    char *vidLoc = reinterpret_cast<char *>(0xB8000);
    char *helpme = reinterpret_cast<char *>(0xB8000);
    int i = 0;
    int vidLocAdder = 0;
    while (true){
        if (vari[i] == '\0' || i > 32){
            break;
        }
        helpme = vidLoc + vidLocAdder;
        *helpme = vari[i];
        vidLocAdder = vidLocAdder + 2;
        i++;
    }
}

void dynPrint(const char* str) {
    char *vidLoc = reinterpret_cast<char *>(0xB8000);
    char *helpme = reinterpret_cast<char *>(0xB8000);
    int i = 0;
    int vidLocAdder = 0;
    while (true){
        if (str[i] == '\0' || i > 32){
            break;
        }
        helpme = vidLoc + vidLocAdder;
        *helpme = str[i];
        vidLocAdder = vidLocAdder + 2;
        i++;
    }
}

char g_text[] = "Hello, World!";

void print() {
    char *vidLoc = reinterpret_cast<char *>(0xB8000);
    int i = 0;
    while (g_text[i] != '\0') {
        vidLoc[2 * i] = g_text[i];
        vidLoc[2 * i + 1] = 0x07;
        i++;
    }
}


int main(){
    char vart[] = "umm";
    print();

	return 0;
}
