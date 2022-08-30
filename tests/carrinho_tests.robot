# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***

Documentation       Arquivo de Testes Endpoint /carrinho
Resource    ../Keywords/carrinho_keywords.robot
Suite Setup    Criar Sessao
#Sessão para a criação dos cenários
*** Test Cases ***
Cenario: GET Carrinhos 200
    [Tags]    GETCAR
    
    GET Endpoint /carrinhos
    Validar Status Code "200"

Cenario Criar Carrinho 201
    
    Fazer Login e Armazenar Token
