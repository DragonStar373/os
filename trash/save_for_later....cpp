#include <cstdint>  // for uint16_t, uint8_t

// Video memory base address
constexpr uint16_t* const VIDEO_MEMORY = reinterpret_cast<uint16_t*>(0xB8000);

// Screen dimensions
constexpr int SCREEN_WIDTH = 80;
constexpr int SCREEN_HEIGHT = 25;

// Writes a single character with attribute to a specific location
void put_char(char character, uint8_t attribute, int x, int y) {
    const int index = y * SCREEN_WIDTH + x;
    VIDEO_MEMORY[index] = (attribute << 8) | character;
}

// Prints a string to the screen at a given location with a specific color
void print(const char* str, int x, int y, uint8_t attribute) {
    while (*str) {
        if (x >= SCREEN_WIDTH) {  // Move to the next line if end of screen width is reached
            x = 0;
            y++;
        }
        if (y >= SCREEN_HEIGHT) {  // Scroll the screen or stop printing if end of screen height is reached
            break;
        }
        put_char(*str++, attribute, x++, y);  // Print character and advance position
    }
}

// Example usage
extern "C" void kernel_main() {
    print("Hello, world!", 0, 0, 0x0F);  // White on Black
}



/////////////////////////////////////////////////////////////////////////////////////////////////////////



#define VIDEO_MEMORY ((unsigned short*)0xB8000)

// Screen dimensions
#define SCREEN_WIDTH 80
#define SCREEN_HEIGHT 25

// Writes a single character with attribute to a specific location
void put_char(char character, unsigned char attribute, int x, int y) {
    int index = y * SCREEN_WIDTH + x;
    VIDEO_MEMORY[index] = (attribute << 8) | character;
}

// Prints a string to the screen at a given location with a specific color
void print(const char* str, int x, int y, unsigned char attribute) {
    while (*str) {
        if (x >= SCREEN_WIDTH) {  // Move to the next line if end of screen width is reached
            x = 0;
            y++;
        }
        if (y >= SCREEN_HEIGHT) {  // Scroll the screen or stop printing if end of screen height is reached
            break;
        }
        put_char(*str++, attribute, x++, y);  // Print character and advance position
    }
}

// Example usage
extern "C" void kernel_main() {
    print("Hello, world!", 0, 0, 0x0F);  // White on Black
}



