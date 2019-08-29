#!/bin/bash

clear
Menu(){
   echo -e "\e[36m ------------------------------------------"
   echo -e "    USUARIO-ALUNO.sh         "
   echo -e " ------------------------------------------"
   echo -e
   echo -e " [ 1 ] Instalar programas essenciais"
   echo -e " [ 2 ] Atualizar todos os programas"
   echo -e " [ 3 ] Instalar LinFreeze"
   echo -e " [ 0 ] Sair"
   echo -e
   echo -e -n "\e[36m Digite a opção desejada:  \e[0m"
   read opcao
   case $opcao in
      1) InstalarProgramas ;;
      2) AtualizarProgramas ;;
      3) InstalarLinfreeze ;;
      0) exit ;;
      *) "Opcao desconhecida." ; echo ; Menu ;;
   esac
}
InstalarProgramas() {

cd 'Área de Trabalho'
echo -e "\e[36mCriando diretório VMs Backup\e[0m"
cd /home
	if ! mkdir 'VMs Backup'
		then
			echo -e "\e[31mNão foi possível criar o diretório VMs Backup\e[0m"
		else
			echo -e "\e[92mDiretório criado\e[0m"
	fi
chmod 777 'VMs Backup'

echo -e "\e[36mAtualizando repositórios..\e[0m"
	if ! apt-get update
		then
    			echo -e "\e[31mNão foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list\e[0m"
    		else
			echo -e "\e[92mAtualização feita com sucesso\e[0m"
	fi

echo -e "\e[36mAtualizando pacotes já instalados...\e[0m"
	if ! apt-get dist-upgrade -y
		then
    			echo -e "\e[31mNão foi possível atualizar pacotes.\e[0m"
    		else		
			echo -e "\e[92mAtualização de pacotes feita com sucesso.\e[0m"
	fi

echo -e "\e[36mInstalando NTP...\e[0m"
	if ! apt-get install ntp
		then
			echo -e "\e[31mNão foi possível instalar o NTP\nTente manualmente com 'apt-get install ntp'\e[0m"
	fi
echo -e "\e[92mNTP instalado com sucesso.\e[0m"

echo -e "\e[36mInstalando VirtualBox...\e[0m"
	if ! apt-get install virtualbox
		then
			echo -e "\e[31mNão foi possível instalar o VirtualBox.\e[0m"
			
	fi
echo -e "\e[92mVirtualBox instalado com sucesso.\e[0m"

echo -e "\e[36mInstalando samba...\e[0m"
	if ! apt-get install samba
		then
			echo -e "\e[31mNão foi possível instalar o samba.\e[0m"
			
	fi
echo -e "\e[92msamba instalado com sucesso.\e[0m"

echo -e "\e[36mInstalando Nautilus...\e[0m"
	if ! apt-get install nautilus
		then
			echo -e "\e[31mNão foi possível instalar o Nautilus\e[0m"
			
	fi
echo -e "\e[92mNautilus instalado com sucesso\e[0m"

echo -e "\e[36minstalando wget...\e[0m"
	if ! apt-get install wget
		then
			echo -e "\e[31mNão foi possível instalar o wget.\e[0m"
			
	fi
echo -e "\e[92mwget instalado com sucesso.\e[0m"

echo -e "\e[36m--INSTALAÇÂO DE PACOTES--\e[0m"

echo -e "\e[36mBaixando Google Chrome\e[0m"
	
	#if ! wget -T 10 -i https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	#	then
	#		echo -e "\e[31mNão foi possível baixar o Google Chrome\e[0m"
	#		
	#fi

sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt-get update
sudo apt-get install google-chrome-stable

echo -e "\e[92mDownload concluído\e[0m"

echo -e "\e[36mInstalando Google Chrome\e[0m"
	if ! sudo dpkg -i google-chrome-stable_current_amd64.deb
		then
			echo -e "\e[31mNão foi possível instalar o Google Chrome\e[0m"
			
	fi
echo -e "\e[92mGoogle Chrome instalado com sucesso\e[0m"

echo -e "\e[92mInstalação finalizada\e[0m"

echo -e " \e[36m\n-------------------------------------------------------\e[0m"
echo -e " \e[36mhabilitando VMs para execução... \e[0m"

if ! cd /home
	then
		echo -e " \e[31mNão foi possível acessar o diretório. \e[0m"
fi

if ! chmod -R 777 'VMs Backup'
	then
		echo -e " \e[31mNão foi possível habilitar permissões para os arquivos do diretório. \e[0m"
	else
		echo -e " \e[92mFinalizado! \e[0m"		
fi

Menu
}
#--------------------------------------------------------------------------------------------------

AtualizarProgramas(){
echo -e "\e[36mAtualizando repositórios..\e[0m"
	if ! apt-get update
		then
    			echo -e "\e[31mNão foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list\e[0m"
    		else
			echo -e "\e[92mAtualização feita com sucesso\e[0m"
	fi

echo -e "\e[36mAtualizando pacotes já instalados...\e[0m"
	if ! apt-get dist-upgrade -y
		then
    			echo -e "\e[31mNão foi possível atualizar pacotes.\e[0m"
    		else		
			echo -e "\e[92mAtualização de pacotes feita com sucesso.\e[0m"
	fi
Menu
}

#--------------------------------------------------------------------------------------------------
InstalarLinfreeze(){

echo -e " \e[36mInstalando LinFreeze ...\n\e[0m"

if cd /home/fatec/Desktop
	then
		echo -e " \e[36mExtraindo linfreeze.zip ...\n\e[0m"
		if unzip linfreeze-master.zip
			then
				chmod 777 LinFreeze-master
				echo -e " \e[36mCopiando linfreeze para /usr/bin...\n\e[0m"
				if cp LinFreeze-master/linfreeze /usr/bin
					then
						echo -e " \e[36mCompactando linfreeze.1 ...\n\e[0m"
						if gzip LinFreeze-master/linfreeze.1
							then
								echo -e " \e[36mCopiando linfreeze.1 para /usr/share/man/man1 ...\n\e[0m"
								if cp LinFreeze-master/linfreeze.1.gz /usr/share/man/man1 
									then
										echo -e " \e[92mLinFreeze instalado com sucesso!\e[0m"
										echo -e " \e[0m------------------------------------------------------- \e[0m"
										
										echo -e " \e[36mCongelando conta aluno \e[0m"
										if ! linfreeze -f aluno
											then
												echo -e " \e[31mNão foi possível congelar a conta aluno.\nTente fazer o processo manual \e[0m"
											else
												echo -e " \e[92mConta aluno congelada com sucesso.\n \e[0m"
										fi
									else
										echo -e " \e[31mNão foi possível copiar o arquivo \e[0m"
								fi
							else
								echo -e " \e[31mNão foi possível compactar o arquivo.\e[0m"
						fi
					else
						echo -e " \e[31mNão foi possível copiar o arquivo.\e[0m"
				 fi
			else
				echo -e " \e[31mNão foi possível extrair o arquivo, verifique se o arquivo se encontra no Desktop. \e[0m"
		fi
	 else
		echo -e " \e[31mNão foi possível encontrar o diretório Desktop. \e[0m"
fi
Menu
}
Menu