#!/bin/bash
lsblk
read -p "ENTER"
echo "-------------------------------------------------------------------------------"
echo "!!ВАЖНО УКАЗАТЬ СВОЙ ДИСК, КОТОРЫЙ ВЫ ХОТИТЕ, ПО УМОЛЧАНИЮ, ЗДЕСЬ /dev/sda!!"
echo "!!IT IS IMPORTANT TO SPECIFY YOUR DRIVE, THE DEFAULT IS HERE /dev/sda!!"
echo "-------------------------------------------------------------------------------"
read -p "ENTER"
git clone https://github.com/ondasd/disko-setup.git
read -p "ENTER"
echo "change disk?:"
read -p " change (yes/no): " answer
case "$answer" in
    y|Y|yes|YES)
        nano /disko-setup/disko-conf.nix
        ;;
    n|N|no|NO)
        echo "ok"
        ;;
    *)
    echo "Wrong answer"
    ;;
esac
read -p "nice"
touch Disko.nix
read -p "ENTER"
cp /tmp/disko-setup/disko-conf.nix /tmp/Disko.nix
read -p "ENTER"
rm -rf disko-setup
read -p "ENTER"
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/Disko.nix
lsblk
echo "----------------"
echo "      nice     "
echo "----------------"
