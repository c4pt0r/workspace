# disk partition

sgdisk -z /dev/sda
sgdisk -n 1:0:+512M -t 1:ef00 -c 1:"EFI System" /dev/sda
sgdisk -n 2:0:+512M -t 2:8300 -c 2:"Linux filesystem"　/dev/sda
sgdisk -n 3:0: -t 3:8300 -c 3:"Linux filesystem" /dev/sda

# mkfs

mkfs.vfat -F32 /dev/sda1
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda3

# mount OS

mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda2 /mnt/boot
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi

# wifi

[iwd]# device list
[iwd]# device device set-property Powered on
[iwd]# adapter adapter set-property Powered on
[iwd]# station device scan
[iwd]# station device get-networks
[iwd]# station device connect SSID

# pacstrap

pacstrap /mnt base base-devel linux linux-firmware grub efibootmgr dosfstools netctl vim iw wpa_supplicant networkmanager dialog

# fstab
genfstab -U /mnt >> /mnt/etc/fstab

# chroot
arch-chroot /mnt /bin/bash

# locale

vim /etc/locale.gen
	...
	en_US.UTF-8 UTF-8
	...

locale-gen
echo "LANG=en_US.UTF-8 UTF-8" > /etc/locale.conf

# timezone
tzselect

# ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
hwclock --systohc --utc


# hostname
echo "hostname" > /etc/hostname

127.0.0.1 localhost
::1 localhost
127.0.1.1 hostname


# initramfs

mkinitcpio -p linux

# passwd

passwd

# grub

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --boot-directory=/boot/efi/EFI --recheck
grub-mkconfig -o /boot/efi/EFI/grub/grub.cfg


# reboot

exit
shutdown -h now

#####################

systemctl start NetworkManager
systemctl enable NetworkManager
nmctl d wifi list
nmctl d wifi connect SSID password password

