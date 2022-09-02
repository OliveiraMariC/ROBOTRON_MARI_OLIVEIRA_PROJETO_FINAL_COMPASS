# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***

Documentation        Arquivo de Testes Endpoint /login
Resource    ../suporte/base.robot
Suite Setup    Criar Sessao    

#Sessão para a criação dos cenários
*** Test Cases ***
Cenario: POST Realizar Login 200
   [Tags]        POSTLOGIN1
   POST Endpoint /login
   Validar Status Code "200"

