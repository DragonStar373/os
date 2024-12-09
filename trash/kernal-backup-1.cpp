typedef unsigned long size_t;  // Assuming size_t is not defined



constexpr size_t POOL_SIZE = 1024 * 1024;  // 1 MB pool
static char memoryPool[POOL_SIZE];
static bool used[POOL_SIZE] = {false};  // Track memory usage

void* my_malloc(size_t size) {
    size_t consecutiveFree = 0;

    for (size_t i = 0; i < POOL_SIZE; i++) {
        if (!used[i]) {
            consecutiveFree++;
            if (consecutiveFree == size) {
                size_t start = i - size + 1;
                for (size_t j = start; j <= i; j++) {
                    used[j] = true;
                }
                return &memoryPool[start];
            }
        } else {
            consecutiveFree = 0;
        }
    }
    return nullptr;
}

void my_free(void* ptr, size_t size) {
    size_t offset = static_cast<char*>(ptr) - memoryPool;
    for (size_t i = 0; i < size; i++) {
        used[offset + i] = false;
    }
}
void operator delete(void* ptr, size_t size) noexcept {
    my_free(ptr, size);  // Now correctly passing both parameters
}

void operator delete[](void* ptr, size_t size) noexcept {
    my_free(ptr, size);  // Same for array delete
}

class StdString {
public:
    char* ca;  // Pointer to character array
    int length;

    StdString(int len) : length(len) {
        ca = static_cast<char*>(my_malloc(len));  // Use custom allocation
        if (ca == nullptr) {
            // Handle allocation failure if necessary
        }
    }

    virtual ~StdString() {
        operator delete(ca, length);  // Use custom delete operator that includes size
    }
};

class StdString32 : public StdString {
public:
    StdString32(const char* initString) : StdString(32) {  // Length is static for demonstration
        for (int i = 0; i < 31; i++) {
            ca[i] = initString[i];
        }
        ca[31] = '\0';  // Ensure null termination
    }
};

void stdPrint(const StdString& s) {
    char* vidLoc = reinterpret_cast<char*>(0xB8000);  // Assume direct memory access
    for (int i = 0; i < s.length && s.ca[i] != '\0'; i++) {
        *vidLoc = s.ca[i];
        vidLoc += 2;  // Move to the next character cell
    }
}

int main(){
    *(char*)0xb8000 = 'Q';
    StdString bob("Hello World!");
    stdPrint(bob);
    return 0;
}
