# Vagrant. Primer acercamiento.
Vagrant es una herramienta para la creación y configuración de entornos de desarrollo virtualizados. Inicialmente trabajaba como único proveedor con VirtualBox pero desde la versión 1.1 es "multi-proveedor", pudiendo trabajar entre otros con Hyper-V, WMware, etc.
Como un primer acercamiento a la herramienta vamos a montar un **Ubuntu 14.04.2 LTS** con todas las herramientas del **stack MEAN** preparadas (Mongo, Express, Angular y NodeJs) con VirtualBox como proveedor.

## Paso 1. Instalación de Vagrant.  ##
Para decargar e instalar Vagrant debemos seguir las instrucciones y recomendaciones de [su página oficial.](http://www.vagrantup.com/downloads.html)
Esto simplemente nos instala y nos prepara el entorno para poder ejecutar Vagrant desde línea de comandos.
Es necesario tener instalado en el equipo cualquier proveedor de virtualización. 
 
## Paso 2. Inicializando y configurando nuestro primera máquina virtual. ##
Desde un terminal y situados en la carpeta que queremos trabajar el primer paso es inicializar el entorno.

    vagrant init

El siguiente paso es configurar el entorno y seleccionar la caja (box) de nuestro entorno (Caja es una imagen base). El catálogo oficial de cajas lo tenéis [aquí](https://atlas.hashicorp.com/boxes/search). Para este ejemplo usaremos **ubuntu/trusty32** y la forma de indicarlo es modificando el archivo (Vagrantfile) que hemos creado mediante la instrucción anterior.

El contenido de Vagrantfile en su mayoría está comentado y se refiere siempre a opciones que son auto-explicativas (Create a private network, create a public network, share an additional folder, etc.). Insisto que para algo básico, como es este caso, simplemente deberemos modificar las siguientes líneas e indicar la caja preferida así como la url de descarga de la misma.

    config.vm.box = "ubuntu/trusty32"
    config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/trusty-server-cloudimg-i386-juju-vagrant-disk1.box"

Lo siguiente que podemos hacer es configurar el contenido de nuestra máquina virtual, es decir, que herramientas incluiremos e instalaremos en ella. Tenemos muchas opciones de aprovisionamiento (Provisioning) y nos vamos a quedar quizás con la menos cool del momento que es vía shell. Las otras opciones más cool de aprovisionamiento son chef o puppet y que en un futuro espero poder hablar un poquito de ellas.

    config.vm.provision "shell", path: "provision/setup.sh"

Esto quiere decir que realice la provisión mediante el shell ejecutando el script de la ruta indicada. Como he comentado anteriormente nos instalará todas las herramientas necesarias del stack MEAN.

    #!/bin/bash    
    echo "#Install curl"
    sudo apt-get install -y curl
    
    echo "#Install nodejs v.0.12"
    curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -
    sudo apt-get install -y nodejs
    
    sudo npm install -g bower
    sudo npm install -g grunt-cli
    sudo npm install -g gulp
    
    echo "Install mongodb..."
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
    echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
    deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen
    sudo apt-get update
    sudo apt-get install mongodb-org -y

## Paso 3. Levantando nuestra máquina virtual. ##

El siguiente paso es levantar nuestro vagrant (máquina virtual), la primera vez es la más  costosa ya que se encargará de instalar e inicializar dicha máquina. 

    vagrant up
Al finalizar de levantar nuestro vagrant podremos acceder a la máquina virtual mediante el comando vagrant ssh recibiendo el típico mensaje de bienvenido de las máquinas Ubuntu/ Linux.

    Welcome to Ubuntu 14.04.2 LTS (GNU/Linux 3.13.0-46-generic i686)

## Comandos básicos en Vagrant. ##

Estos son los comandos básicos que tiene Vagrant desde terminal.

    vagrant --help

    Common commands:
     box             manages boxes: installation, removal, etc.
     connect         connect to a remotely shared Vagrant environment
     destroy         stops and deletes all traces of the vagrant machine
     global-status   outputs status Vagrant environments for this user
     halt            stops the vagrant machine
     help            shows the help for a subcommand
     init            initializes a new Vagrant environment by creating a Vagrantfile
     login           log in to HashiCorp's Atlas
     package         packages a running vagrant environment into a box
     plugin          manages plugins: install, uninstall, update, etc.
     provision       provisions the vagrant machine
     push            deploys code in this environment to a configured destination   
     rdp             connects to machine via RDP
     reload          restarts vagrant machine, loads new Vagrantfile configuration  
     resume          resume a suspended vagrant machine
     share           share your Vagrant environment with anyone in the world
     ssh             connects to machine via SSH
     ssh-config      outputs OpenSSH valid configuration to connect to the machine  
     status          outputs status of the vagrant machine
     suspend         suspends the machine
     up              starts and provisions the vagrant environment
     version         prints current and latest Vagrant version 

Enlaces de interés/ referencias.

- [Vagrant.](https://www.vagrantup.com/)
- [VirtualBox.](https://www.virtualbox.org/)
- [Discover Vagrant Boxes.](https://atlas.hashicorp.com/boxes/search?utm_source=vagrantcloud.com&vagrantcloud=1)
