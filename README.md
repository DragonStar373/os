freaking terrible project. why would i ever start this project. this was an awful idea of a project.

---

# How It Works

This project is designed as a bare-metal, bootable piece of code. It's meant to be run on any computer with a standard BIOS (or UEFI with legacy mode enabled.)

There are 3 major sections: The Bootloader, The Entry, and The Kernel (TBD)

## The Bootloader

The bootloader is split into 2 stages, since it's the bootloader's job to load the disk, start VBE graphics, and transition into 32-bit Protected Mode.

### Bootloader - Stage 1:
This stage (programmed in boot1.asm) has the sole job of loading the next sectors from the disk. Since the BIOS only loads the first sector (512 bytes) from the boot disk by default, we have to load in the rest ourselves (using `int 0x13`). We do this by
- 1 - Finding the disk ID: by default, the disk ID is saved to the `dl` register on startup, so we just have to make sure to save that ID
- 2 - Determining the CHS addressing: on standard disks/hard drives, you need to know what cylinder, head, and sector of the hard drive you want to read from (since hard drives can have multiple platters, with multiple heads to read from either side.) For this scenario, the boot sector was the C=0 H=0 S=1, so we want to read starting from C=0 H=0 S=2 (note: C & H start from 0, while S starts at 1)
- 3 - Determining how many sectors to read: Bootloader Stage 2 is 5KB long, or 10 sectors, so we want to load at least that many. We add like 40KB of zeroes to the end of os.bin for padding, so realistically we shouldn't need to worry about making this number too big right now
- well shit why isnt it working now (3/6/25)

---

---

---

note: the below is the old readme. im still reworking the entire thing, but its kinda hard to write a readme when the project is nowhere near production ready

---

Anyways uhh this is an attempt to "make an operating system from scratch"

I must admit, despite the many, *many*, ***many*** problems with this entire project, it does in fact work!

After compiling everything (which basically means running `make.sh` on linux/WSL), you get a final result of `os.bin`, which can then _actually be run_ in a vm (super cool)

I use `qemu-system-x86_64` because it's easy and because it can treat raw binary `.bin` files like a normal disk image, same as `.iso` or `.img`, and idk if other virtual machines can do that.
Technically you _can_ also write the raw binary to a disk... and I've tested it and it *does* boot... but it won't get much further (more on that below)


### makin the thing
So the very base of the project is `boot.asm`. This is the bootloader, the very first bit of programming that gets loaded into memory and run. It's written in NASM assembly, meaning what you see in the source code file is about as close to machine code as you can get.

I could try to explain this file in depth, but it has ~~decent~~ okayish inline documentation on its own, and to be honest I don't understand some parts of it very well myself. I followed a really good tutorial to learn basic assembly (which i sadly couldn't find the link to), alongside [another really good tutorial](https://www.youtube.com/watch?v=MwPjvJ9ulSc&list=PLm3B56ql_akNcvH8vvJRYOc7TbYhRs19M) to learn not only how to _make_ the bootloader, but also _how and why_ everything works; I would absolutely reccomend watching it if you want to learn more.



Next is `kernel_entry.asm`, `kernel_asm_main.asm`, and `kernel.cpp`. In legacy/bios mode (the mode this project targets), the first 512 bytes of the disk — and only the first 512 bytes — get loaded into memory automatically, and the machine code in those 512 bytes is the first code to be run after the BIOS. `boot.asm` takes up these 512 bytes; it loads the rest of the disk into memory, with `kernel_entry.asm` containing the very first bit of code it jumps to. From there, `kernel_entry` runs `kernel_asm_main` and `kernel` (which is written in C++).

...This is where problems arise. I *could* write the rest of my """os""" in assembly, which is what `kernel_asm_main` is for. However, that's tedius and involves learning more assembly than I bargained for when I started this. Writing everything in C++ (`kernel.cpp`) sounds much better, given that i can link the C++ and Assembly in the same binary and be able to run the program compiled with C++ ~~with no problems~~. There are problems. There are many many problems. My inexperience with C++ might be _part_ of the problem, but on several different occasions I tried to do something that should have worked, sources online confirmed it should have worked, multiple different AI models confirmed it should have worked, but it didn't work. Or only kind of worked. Or did something, just not the thing it was supposed to do. So, uh, I temporarily put the thing on hold. I suppose I could continue in full assembly, and I probably will, but just... not right now.


### setup
(Note: instructions here apply to debian linux. To follow on Windows, I suggest [installing WSL](https://learn.microsoft.com/en-us/windows/wsl/install#install-wsl-command), which basically gives you linux inside of Windows.)

If all you want to do is run it, just install `qemu-system-x86_64` or `qemu-system-i386` (for our purposes, basically the same thing.) In debian this can be done by running `sudo apt update && sudo apt install qemu-system-x86_64`. After that, just run `qemu-system-x86_64 os.bin` to run this makeshift "operating system."

For the full setup (assembling, compiling, linking), however, you should run `settup-gcc-debian.sh` (stolen from [Daedalus Community](https://www.youtube.com/watch?v=MwPjvJ9ulSc&list=PLm3B56ql_akNcvH8vvJRYOc7TbYhRs19M)) which installs pretty much everything needed to assemble/compile/link everything yourself. It'll probably take a while because the shell script is basically compiling what we need from scratch, so fair warning. Optionally, it would be a good idea to also [add it to the path](https://phoenixnap.com/kb/linux-add-to-path). After that, you *should* be good to compile the "os" yourself; and since my intelligent ass ~~doesn't know how to~~ forgot to use `make` or `cmake`, I'm using a shell script instead: `make.sh`. Run it with `./make.sh`, and boom, you've compiled it.

The result is a raw binary file named `os.bin`. It's pretty much pure raw machine code, which qemu treats like a disk. In fact, as previously mentioned, you can use the linux `dd` command to write it bit-for-bit to a disk/usb-drive. The reason why this doesn't really work, however, is that the bootloader in `boot.asm` tries to load the rest of the disk into memory on its own. That works fine on qemu, because it simulates the `os.bin` file like a fully generic disk; but USB drives and DVDs aren't necessarily fully genericdisks. So it's very likely that when you boot up, the bootloader's attempt at loading the next parts of the disk into memory fails due to semantics and differences between disks that I don't really know how to contend for. Atm, I just have it programmed to display "Disk Read Error" to the screen and pause if an error flag get thrown when it tries to load the disk; it does _technically_ still boot though. If you reallyyy wanna test it out on true hardware, be my guest.


aaaaaaaaaaaaaaaaaaaaaa
