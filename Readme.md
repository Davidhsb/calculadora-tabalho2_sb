# Trabalho 2 - Software Básico

### Nome: David Herbert de Souza Brito

- Este readme especifica quais são os comandos necessários para executar as calculadoras de 32 e 16 bits, feitas em assembly IA-32. O sistema usado para construir todas as funcionalidades do programa foi o WSL (Windows Subsystem for Linux)

#### Comandos:

- Para esse programa foram feitos dois arquivos Makefile para automatizar o processo de compilação e ligamento do código. Primeiramente abra o terminal Linux ou WSL no repositório local deste arquivo readme.

##### 0. Acessando diretório dos arquivos Makefile

    cd src

##### 1. Compilar e ligar calculadora de 16 bits

    make -f makefile_16bits

##### 1.1 Executar calculadora de 16 bits

    ./calc_16bits

##### 2. Compilar e ligar calculadora de 32 bits

    make -f makefile_32bits

##### 2.1 Executar calculadora de 16 bits

    ./calc_32bits
