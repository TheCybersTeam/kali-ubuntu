#!/bin/bash


#Script kali-ubuntu.sh para adicionar ferramentas do Kali linux no Ubuntu 
#funçoes

#Funçao menu oferese opçoes para o usuario
#instalar os metapackages do kali linux
menu(){
	while :

do
	echo "AQUI ESTÃO ALGUMAS OPÇÕES"
	echo
	echo "[1] Instalar armitage"
	echo "[2] Instalar sqlmap"
	echo "[3] Inatalar wireshark"
	echo "[4] Instalar aircrack-ng"
	echo "[5] Instalar burpsuite"
	echo "[6] Instalar vega"
	echo "[7] Instalar setoolkit"
	echo "[8] Sair"
	
	read opt

	case $opt in
	
	1)xterm -e apt-get install armitage
	;;
	2)xterm -e apt-get install sqlmap
	;;
	3)xterm -e apt-get install wireshark
	;;
	4)xterm -e apt-get install aircrack-ng
	;;
	5)xterm -e apt-get install burpsuite
	;;
	6)xterm -e apt-get install vega
	;;
	7) xterm -e apt-get install set
	;;
	8)echo "Ate Logo"
	exit
	;;
	*) echo "Opção [$opt] invailda Selecione a opção entre 1-6 só";

     echo   "         Pressione [ENTER] para continuar.      ";

     read enterKey
	;;

  esac
 done
}

#Função update atualiza o cache do Ubuntu adicionando
#os novos repos
update(){
	echo "Atualizando systema isso pode demorar algums minuto"
	xterm -e apt-get update
	
	menu
}

#Funçao chave adicionando chaves do servidor do
#kali para poder baixar os programas do servidor
chave(){
gpg --keyserver pgpkeys.mit.edu --recv-key  ED444FF07D8D0BF6
gpg -a --export ED444FF07D8D0BF6 | sudo apt-key add -

update
}

#Funçao repo adiciona repos do systema kali linux
#ao seu Ubuntu
repo(){
echo "
#kali_linux
deb http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list

chave
}

#Funçoa verifica-repo verifica se os repos do kali linux
#estão no seu source.list
verifica-repo(){
	VERI=$(cat /etc/apt/sources.list |grep \#kali_linux)

if [ $VERI = \#kali_linux ] ;
then
	echo "o arquivo repo existe"
	clear
	menu
else
	echo "o arquivo repo não existe"
	repo
fi
}

#Função login que verifica se o usuario corrente
#esta com previlegios de root para rodar 
#o script

login(){
	veri=$(id -u)
	usu=$(whoami)
if [ $veri != 0 ] ;
then
	clear
	echo "-------->"
	echo "$usu rode o script como root"
	echo "		   <---------"
	exit 1
else
	verifica-repo
fi
}

# Verifiando coneção com a Internet
internet() {
ping www.google.com.br -c 1 >/dev/null;

if [ "$?" = "0" ] ;
then
   echo "Conexao com a internet OK";
   clear
   login
else
   echo "Sem conexao com a internet"
   
fi
}
internet
