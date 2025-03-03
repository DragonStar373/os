#!/bin/bash
#this script is almost perfect, but brew refuses to install "i386-elf-gcc" - it actually just installs x86_64-elf-gcc
#basically identical, but i also just installed i686-elf-gcc since they're basically the same and they sound the same

if command -v brew &> /dev/null
then
    echo "Homebrew is already installed."
else
    echo "Homebrew is NOT installed; installing manually"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if command -v brew &> /dev/null
then
    echo "Installing dependencies:"
else
    echo "Error in Homebrew installation, please manually install with the following script:"
    echo "/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi


brew install nasm
brew install qemu
brew install i386-elf-gcc
brew install i686-elf-gcc