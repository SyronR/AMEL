#!/bin/bash

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

echo ""
echo "##############################################"
echo "## Install the necessary dependencies     ####"
echo "##############################################"

# Actualizar la lista de paquetes
apt update

# Instalar Dependencias esenciales
apt install -y linux-headers-$(uname -r)
apt install -y python2
apt install -y zip
apt install -y unzip

echo ""
echo "##############################################"
echo "## Capturing RAM...                       ####"
echo "##############################################"

# Crear la carpeta de captura de memoria
mkdir capture

# Crear el modulo de memoria
sudo ./avml ./capture/memory.lime

echo ""

echo ""
echo "###############################################"
echo "## Do you want to create the operating     ####"
echo "## system profile for Volatility? y/n      ####"
echo "###############################################"

exit = false
read response

while [ $exit -eq false ]; do
    if [ "$response" -eq 'y' ]; then
        echo ""
        echo "##############################################"
        echo "## Creating profile...                    ####"
        echo "##############################################"

        # Crear el perfil de memoria
        cd ./volatility/tools/linux
        sudo make dwarf

        cp /boot/System.map-$(uname -r) System.map-$(uname -r)
        zip profile.zip ./module.dwarf ./System.map-$(uname -r)
        mv profile.zip ../../../capture/profile.zip
        
    elif [ "$response" -eq 'n' ]; then
            echo ""
            echo "##############################################"
            echo "## Leaving the program...                 ####"
            echo "##############################################"

            $exit = true
    else
        echo "Enter a valid value: y/n"
    fi

done

