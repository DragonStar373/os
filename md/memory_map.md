Note: using [this document](https://web.archive.org/web/20200428091120/http://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf) for reference.

---
### Default Organization

Memory in the x86 architecture is organized into units of bytes called addresses, and memory addresses are typically represented in hex values (often shown with an `h` on the end, and/or a `0x` in the beginning.) On startup, certain address ranges will contain data that is not only important to preserve, but often required to keep untouched, as in many cases the BIOS will still actively be using these addresses during operation.

The (typical) default memory map is as follows:
- **0x0 - 0x400: Interrupt Vector Table (IVT)** (1KB)
- **0x400 - 0x500: BIOS Data Area (BDT)** (256 bytes)
-  *0x500 - 0x7c00: Free space* (30,464 bytes; ie 29.75KB)
- **0x7c00 - 0x7e00: Location of boot sector** (512 bytes)
- *0x7e00 - 0x9fc00: Free space*  (135KB)
- **0x9fc00 - 0xA0000: Extended BIOS Data Area** (639KB)
- **0xA0000 - 0xC0000: Video Memory** (128KB)
- **0xC0000 - 0x100000: BIOS** (256KB)

Above 0x100000, something called the [A20 Line](https://wiki.osdev.org/A20_Line) must be enabled before accessing upper memory.

### How We're Organizing It

For our use case, we'll be using the 25KB immediately after the BDT (0x500 - 0x6900) to move the entirety os into memory; this can be expanded later if need be, but lets hope it never need be. The 512 Byte area after the boot sector (0x7e00 - 0x8000) will be used to store data in a structure as follows:
- 0x7e00 (1 byte) - The boot disk ID (stored in dl at startup)
- 0x7e01 (4 bytes) - The Vesa BIOS Extension (VBE) Framebuffer location
- 0x7e05 (4 bytes) - The VBE Pixel Value, 0x0 -> 0xBB9B0 (what pixel, not what byte - 3 bytes per pixel, but that's for colors)
- 0x7e09 (2 bytes) - The Character-Counter Value, 0x0 -> 0x2000 (what character grouping (8x12) we're currently on - screen can fit 128 chars across, 64 chars down)
- 0x7e0b (1 byte) - 8-bit array of bool values for tests, 00000000b, labeled 0 through 7 (more on this below)
- 0x7e0c () -

### The Chaos

The addresses 0x7df0 -> 0x7dffb will contain 4 32-bit sections for passing values to functions, since I forgot to understand how the stack works :D (I'll figure it out eventually.)

Any address with the prefix 0x7cXX will be designated as "The Wild Fucking West," a zone where functions can do whatever the hell they want. That's a bit of a stretch - 0x7c00 -> 0x7c3f will be reserved for saving values in the aforementioned 32-bit sections - but the name is basically accurate.

(Note that this is essentially just a way to make use of the boot sector once we're done with it)
