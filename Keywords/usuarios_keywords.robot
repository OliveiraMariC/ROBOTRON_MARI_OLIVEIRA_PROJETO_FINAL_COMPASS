# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
Documentation       Keywords e Variáveis para Ações do Endpoint Usuários
Resource    ../suporte/base.robot

*** Keywords ***
#GETALL1
GET Endpoint /usuarios
    ${response}    GET On Session    serverest        /usuarios
    Log To Console        ${response}
    Set Global Variable    ${response}

#POST1 NÃO ESTÁ CADASTRADO
POST Endpoint /usuarios
    &{payload}        Create Dictionary        nome=User102        email=user102@gmail.com        password=user102        administrador=true
    ${response}    POST On Session    serverest       /usuarios        data=&{payload}
    Log To Console        Response:${response.content}   
    Set Global Variable    ${response}

#PUT1 FOI DELETADO PELO DELETE1
PUT Endpoint /usuarios
    &{payload}        Create Dictionary        nome=User104        email=user104@gmail.com        password=user103        administrador=true
    ${response}    PUT On Session    serverest       /usuarios/OEywGN8P96KYRTon        data=&{payload}
    Log To Console        Response:${response.content}   
    Set Global Variable    ${response} 
#DELETE1 EXCLUI PUT1
DELETE Endpoint /usuarios 
    ${response}    DELETE On Session    serverest       /usuarios/svucWaUnUrUt8THs
    Log To Console        Response:${response.content}   
    Set Global Variable    ${response} 
Validar Ter Criado o Usuario
    Should Be Equal        ${response.json()["message"]}        Cadastro realizado com sucesso              
Criar Dados Usuario Valido
    ${json}    Importar JSON Estatico    json_usuario_ex.json 
    ${payload}        Set Varible     ${response} 
Trazer Quantidade Usuarios
    ${quantidade}    Buscar Quantidade Usuarios Cadastrado 
    Log To Console        ${quantidade}       
    
