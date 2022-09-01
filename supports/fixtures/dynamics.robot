# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
Documentation       Keywords e Variáveis para Geração de Massas de Dados Dinâmicos
Library    FakerLibrary    locale=pt_br

*** Keywords ***


Criar Dados Produto Valido
    ${random_produto}           FakerLibrary.Word
    ${random_preco}             FakerLibrary.Building Number
    ${random_qtd}               FakerLibrary.Building Number
    ${payload}                  Create Dictionary    nome=${random_produto}    preco=${random_preco}    descricao=produto teste    quantidade=${random_qtd}    
    Log To Console              ${payload}
    Set Global Variable         ${payload} 
Criar Dados Usuario Valido
    ${nome}                   FakerLibrary.Name
    ${email}                  FakerLibrary.Email
    ${payload}                Create Dictionary    nome=${nome}    email=${email}    password=senha123    administrador=true    
    Log To Console            ${payload}
    Set Global Variable       ${payload} 
    Set Global Variable       ${nome}
    
