# os

freaking terrible project. why would i ever start this project. this was an awful idea of a project.

---

Anyways uhh this is an attempt to "make an operating system from scratch"

I must admit, despite the many, *many*, ***many*** problems with this entire project, it does in fact work!

After compiling everything (which basically means running `make.sh` on linux/WSL), you get a final result of `os.bin`, which can then _actually be run_ in a vm (super cool)

I use `qemu-system-x86_64`, because it's easy and because it can run raw binary files the same as `.iso` or `.img` which idk if other virtual machines can do. 
Technically you _can_ also write the raw .bin to a disk with the `dd` command; and I've tested it and it *does* boot... but it won't get much further (more on that below)


### makin the thing
So the very base of the project is `boot.asm`. This is the bootloader, the very first bit of programming that gets loaded into memory and run. It's written in NASM assembly, meaning that what you see in the source code file is about as close to machine code as you can get. 

I could try to explain this file in depth, but it has ~~decent~~ okayish inline documentation on its own, and to be honest I only barely understand large parts of it myself. I followed a really good tutorial to learn basic assembly (which i sadly couldn't find the link to), alongside [another really good tutorial](https://www.youtube.com/watch?v=MwPjvJ9ulSc&list=PLm3B56ql_akNcvH8vvJRYOc7TbYhRs19M) to learn not only how to _make_ the bootloader, but also _how and why_ everything works; I would absolutely reccomend watching it if you want to learn more.

---

Next is `kernel_entry.asm`, `kernel_asm_main.asm`, and `kernel.cpp`. Because only the first 512 Bytes get loaded into memory by default (ie `boot.asm`), `boot.asm` loads the rest of the disk (or binary) into memory itself, with `kernel_entry` being the very first thing it jumps to. From there, `kernel_entry` runs `kernel_asm_main` and `kernel` (which is written in C++).

...This is where problems arise. I *could* write the rest of my """os""" in assembly, which is what `kernel_asm_main` is for. However, that's tedius and involves learning more assembly than I bargained for when I started this. Writing everything in C++ (`kernel.cpp`) sounds much better, given that i can link the C++ and Assembly in the same binary and be able to run the program compiled with C++ ~~with no problems~~. There are problems. There are many many problems. My inexperience with C++ might be part of the problem, but on several different occasions I tried to do something that should have worked, sources online confirmed it should have worked, multiple different AI models confirmed it should have worked, but it didn't work. Or only kind of worked. Or did something, just not the thing it was supposed to do. So, uh, I temporarily put the thing on hold. I suppose I could continue in full assembly, and I probably will, but just... not right now.


### setup
(Note: instructions here apply to debian linux. To follow on Windows, I suggest [installing WSL](https://learn.microsoft.com/en-us/windows/wsl/install#install-wsl-command), which basically gives you linux inside of Windows.)

If all you want to do is run it, just install `qemu-system-x86_64` or `qemu-system-i386` (for our purposes, basically the same thing.) In debian this can be done by running `sudo apt update && sudo apt install qemu-system-i386`.

For the full setup, however, you should run `settup-gcc-debian.sh` (stolen from [Daedalus Community](https://www.youtube.com/watch?v=MwPjvJ9ulSc&list=PLm3B56ql_akNcvH8vvJRYOc7TbYhRs19M)) which installs pretty much everything needed to assemble/compile/link everything yourself. It'll probably take a while because it's basically compiling most of this stuff from scratch, so fair warning. After that, you *should* be good to compile it yourself; and since my intelligent ass ~~doesn't know how to~~ forgot to use make, I'm using a shell script instead: `make.sh`. Run it with `./make.sh`, and boom, you've compiled it.


aaaaaaaaaaaaaaaaaaaaaa
