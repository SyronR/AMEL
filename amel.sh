#!/bin/bash

################################################################
## FUNCTIONS ###################################################
################################################################

captureRAM() {
	echo ""
	echo "##############################################"
	echo "## Capturing RAM...                       ####"
	echo "##############################################"

	# Crear el modulo de memoria
	sudo ./avml ./capture/memory.lime
}

createProfile() {
	echo ""
	echo "##############################################"
	echo "## Install the necessary dependencies     ####"
	echo "##############################################"

	# Actualizar la lista de paquetes
	apt update

	# Instalar Dependencias esenciales
	apt install -y linux-headers-$(uname -r) python2 zip unzip make gcc
    
    echo ""
    echo "##############################################"
    echo "## Creating profile...                    ####"
    echo "##############################################"

    # Crear el perfil de memoria
    cd ./volatility-master/tools/linux
    sudo make dwarf

    cp /boot/System.map-$(uname -r) System.map-$(uname -r)
    zip profile.zip ./module.dwarf ./System.map-$(uname -r)
    mv profile.zip ../../../capture/profile.zip
}

################################################################
## SCRIPT ######################################################
################################################################

exit=false

echo "##############################################"
echo "#### Automated Memory Extractor for Linux ####"
echo "####           By Alberto Galvez          ####"
echo "####              Version 1.0             ####"
echo "##############################################"

# Verificar si el usuario es root
if [ "$(id -u)" -ne 0 ]; then
    echo "Ejecute AMEL como administrador, por favor"
    exit 1
fi

# Crear la carpeta de captura de memoria
mkdir capture

while [ "$exit" == false ]; do
    read -p "Do you want to capture the RAM? (y/n): " responseRAM

    if [ "$responseRAM" == 'y' ]; then
	captureRAM
        
        exit=true
    elif [ "$responseRAM" == 'n' ]; then
        exit=true
    else
        echo "Enter a valid value: y/n"
    fi
done

exit=false

while [ "$exit" == false ]; do
    read -p "Do you want to create the profile for volatility? (y/n): " responseProfile

    if [ "$responseProfile" == 'y' ]; then
	createProfile
        
        exit=true
    elif [ "$responseProfile" == 'n' ]; then
        exit=true
    else
        echo "Enter a valid value: y/n"
    fi
done

echo ""
echo "##############################################"
echo "## Leaving the program...                 ####"
echo "##############################################"
exit 0
