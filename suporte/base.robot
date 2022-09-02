# Sessão para configuração, documentação, imports de arquivos e libraries   
*** Settings ***
Documentation        Arquivo simples para requisições HTTP em APIs REST
Library              RequestsLibrary
Library              Collections
Library              OperatingSystem
Library              ./funcao_python/library_tests.py
Library              FakerLibrary
#Importando tudo o que está na pasta suporte para dentro do arquivo base:
Resource             ./common/common.robot       
Resource             ./variaveis/serverest_variaveis.robot
Resource             ./fixtures/dynamics.robot
Resource             ../keywords/usuarios_keywords.robot
Resource             ../keywords/login_keywords.robot
Resource             ../keywords/carrinho_keywords.robot
Resource             ../keywords/produtos_keywords.robot

*** Keywords ***
Criar Sessao
    Create Session    serverest   ${BASE_URI}
