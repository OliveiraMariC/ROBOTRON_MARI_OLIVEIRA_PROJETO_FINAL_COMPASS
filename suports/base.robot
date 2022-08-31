# Sessão para configuração, documentação, imports de arquivos e libraries   
*** Settings ***
Documentation        Arquivo simples para requisições HTTP em APIs REST
Library              RequestsLibrary
Library              Collections
Library              OperatingSystem
#Importando tudo o que está na pasta suporte para dentro do arquivo base:
Resource             ./common/common.robot
Resource             ./fixtures/dynamics.robot
Resource             ./variaveis/serverest_variaveis.robot

*** Keywords ***
Criar Sessao              
    Create Session        serverest    ${BASE_URI}  
