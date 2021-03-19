##################################################################
#Script Linux Author: Revilla
#Descripcion: Copia LXC (PBX de Issabel) de Burro1 a Burro2
#Fecha: 18 Mar. 2021
#
###################################################################

#1. Eliminar vzdumps viejitos de Burro2
find /var/lib/vz/dump/*  -delete

#2. Copiar vzdump de Burro1 a Burro2
scp root@10.7.177.200:/var/lib/vz/dump/vzdump-lxc-10[235]* /var/lib/vz/dump/

#3. Destroy pct 202,203,205
/usr/sbin/pct destroy 202
/usr/sbin/pct destroy 203
/usr/sbin/pct destroy 205

#4. Restaurar pct 202,203,205
SIP2=$(find /var/lib/vz/dump -name vzdump-lxc-102*[.tar.zst])
SIP3=$(find /var/lib/vz/dump -name vzdump-lxc-103*[.tar.zst])
SIP5=$(find /var/lib/vz/dump -name vzdump-lxc-105*[.tar.zst])
/usr/sbin/pct restore 202 $SIP2 -hostname SIP2 --storage local-lvm --rootfs local-lvm:150
/usr/sbin/pct restore 203 $SIP3 -hostname SIP3 --storage local-lvm --rootfs local-lvm:150
/usr/sbin/pct restore 205 $SIP5 -hostname SIP5 --storage local-lvm --rootfs local-lvm:150


