# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***

Documentation        Arquivo de Testes Endpoint /login
Resource    ../suporte/base.robot
Suite Setup    Criar Sessao    

#Sessão para a criação dos cenários
*** Test Cases ***
Cenario 01: POST Realizar Login 200
   [Tags]        POSTLOGIN1
   POST Endpoint /login static
   Validar Status Code "200"
Cenario 02: POST Realizar Login SAdmin 200
   POST Endpoint /login static sem admin
   Validar Status Code "200"

