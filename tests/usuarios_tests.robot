# Sessão para configuração, documentação, imports de arquivos e libraries
*** Settings ***
  
Documentation        Arquivo de testes para endpoint /usuarios
Resource             ../keywords/usuarios_keywords.robot
Resource             ../keywords/login_keywords.robot
Resource             ../keywords/carrinho_keywords.robot
Resource             ../consumir_library_python.robot
Resource             ../suports/base.robot
Suite Setup    Criar Sessao    

#Sessão para a criação dos cenários
*** Test Cases ***


#Requisições Simples
Cenario: GET Todos os Usuarios 200
    [Tags]    GETUSER
    GET Endpoint /usuarios
    Validar Status Code "200"
    
Cenario: POST Endpoint /usuarios sem Email
    [Tags]    POSTUSERSE
    POST Endpoint /usuarios sem Email
    Validar Status Code "400"
Cenario: PUT Editar Usuario 200 
    [Tags]        PUTUSER   
    PUT Endpoint /usuarios
    Validar Status Code "200"

Cenario: DELETE Excluir Usuario 200
    [Tags]    DELUSER
    DELETE Endpoint /usuarios
    Validar Status Code "200"
    GET Endpoint /usuarios
    Validar Status Code "200"

#Encadeamentos
Cenario POST Cadastrar Usuarios Não Administrador 201
    [Tags]        POSTUSER_NAD
    Criar Usuario Nao Adm e Armazenar ID
    Validar Ter Criado Usuario
    DELETE Endpoint /usuarios
    Validar Status Code "200"

Cenario POST Cadastrar Usuarios Administrador 201
    [Tags]        POSTUSER_AD
    Criar Usuario Adm e Armazenar ID
    Validar Ter Criado Usuario
    DELETE Endpoint /usuarios
    Validar Status Code "200"

#Usuários Massa Estática
Cenario: POST Cadastrar Usuario de Massa Estatica 201
    [Tags]    POSTUSERME
    Cadastrar Usuario Estatico Valido
    Validar Status Code "201"

#Usuário Massa Dinâmica
Cenario: POST Cadastrar Usuario de Massa Dinamica 201
    [Tags]        POSTUSERMD
    Cadastrar Usuario Dinamico Valido
    Validar Status Code "201"
Cenario: GET Listar Todos os Usuarios 200
    [Tags]    GETALLUSERS    
    GET Endpoint /usuarios
    Validar Status Code "200"
    Validar Quantidade Total "${3}"
    Validar Quantidade Usuários Administradores
    Validar Se Dado Cadastro Existe "zequinha@qa.com.br"
    
Cenario: POST Criar Usuario Massa Estatica 201
    [Tags]    POSTUSERESTATICO 
    Selecionar Usuario Estatico "user_valido"
    POST Endpoint /usuarios
    Validar Ter Criado o Usuario
    Validar Status Code "201"
    DELETE Endpoint /usuarios/id

Cenario: POST Criar Usuario de Massa Dinamica 201
    [Tags]    POSTUSERDIN
    Criar Dados Usuario Valido
    POST Endpoint /usuarios
    Validar Status Code "201"
    Validar Se Dado Cadastro Existe "${nome}"
    DELETE Endpoint /usuarios/id

Cenario 04: POST Criar Usuario E-mail Já Cadastrado 400
    [Tags]    POSTUSEREMAIL
    Selecionar Usuario Estatico "user_email_cadastrado"
    POST Endpoint /usuarios
    Validar Status Code "400"
    Validar Mensagem "Este email já está sendo usado"

Cenario: POST Criar Usuario E-mail Inválido 400
    [Tags]    POSTUSEREMAILINVALIDO
    Selecionar Usuario Estatico "user_email_invalido"
    POST Endpoint /usuarios
    Validar Status Code "400"
    Validar Erro "email" 

Cenario: POST Criar Usuario Sem E-mail 400
    [Tags]    POSTUSERSEMEMAIL
    Selecionar Usuario Estatico "user_sem_email"
    POST Endpoint /usuarios
    Validar Status Code "400"
    Validar Erro "email"  
    
Cenario: POST Criar Usuario Sem Senha 400
    [Tags]    POSTUSERSEMSENHA
    Selecionar Usuario Estatico "user_sem_senha"
    POST Endpoint /usuarios
    Validar Status Code "400"
    Validar Erro "password"  

Cenario: POST Criar Usuario Sem Nome 400
    [Tags]    POSTUSERSEMNOME
    Selecionar Usuario Estatico "user_sem_nome"
    POST Endpoint /usuarios
    Validar Status Code "400"
    Validar Erro "nome"  

Cenario 09: POST Criar Usuario Sem Adm 400
    [Tags]    POSTUSERSEMADM
    Selecionar Usuario Estatico "user_sem_admin"
    POST Endpoint /usuarios
    Validar Status Code "400"
    Validar Erro "administrador"
    
Cenario 10: GET Buscar Usuario 200
    [Tags]    GETUSER
    Criar Um Usuario e Armazenar ID
    GET Endpoint /usuarios/id
    Validar Status Code "200"
    DELETE Endpoint /usuarios/id
    Validar Se Dado Cadastro Existe "${id_user}"

Cenario 11: GET Buscar Usuario Não Encontrado 400
    [Tags]    GETUSERINVALIDO
    Selecionar ID User Invalido  
    GET Endpoint /usuarios/id
    Validar Status Code "400"
    Validar Mensagem "Usuário não encontrado"

Cenario 12: DELETE Deletar Usuario 200
    [Tags]    DELETEUSER
    Criar Dados Usuario Valido
    POST Endpoint /usuarios
    DELETE Endpoint /usuarios/id
    Validar Status Code "200"
    Validar Se Dado Cadastro Existe "${id_user}"
    
Cenario 13: DELETE Deletar Usuario Carrinho Cadastrado 400   
    [Tags]    DELETEUSERCARRINHO
    Fazer Login e Armazenar Token
    Criar Carrinho Estatico Valido
    Selecionar ID User Carrinho
    DELETE Endpoint /usuarios/id
    Validar Status Code "400"
    Validar Mensagem "Não é permitido excluir usuário com carrinho cadastrado"
    DELETE Endpoint /carrinhos/cancelar-compra

Cenario 14: PUT Editar Usuario 200
    [Tags]    PUTUSER   
    Criar Dados Usuario Valido
    POST Endpoint /usuarios
    PUT Endpoint /usuarios
    Validar Status Code "200"
    # GET Endpoint /usuarios/id
    DELETE Endpoint /usuarios/id

# Cenario 15: PUT Editar Usuario e Cadastrar 201
#     [Tags]    PUTUSER201
#     Criar Usuario Estatico Valido
#     PUT Endpoint Cadastro /usuarios/id
#     Validar Status Code "201"
#     Validar Ter Criado o Usuario
#     DELETE Endpoint /usuarios/id

# Cenario 16: PUT Editar Usuario E-mail Já Cadastrado 400
#     [Tags]    PUTUSER400
#     PUT Endpoint Cadastro Invalido /usuarios/id
#     Validar Status Code "400"
#     Validar Mensagem E-mail Invalido
