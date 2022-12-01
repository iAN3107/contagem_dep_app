<i><h2>Apresentação</h2></i>
Projeto criado para o depósito da empresa DISO, pensado para facilitar a contagem para separação de mercadoria e
inventário.

Caso queira utilizar este repositório, peço apenas uma estrela no repositório e que seja efetuado um Fork do
repositório.

<i><h2>Instruções</h2></i>
<p align="left">
Desenvolvido em Flutter para Android, pensado para ser usado com bancos SQL Server.
Para testes, clone esse repositório, configure o arquivo /lib/services/SQL.dart com a senha ou o banco,
você pode também clonar o base da dados com o APP_CONTAGEM.bak, presente na raiz do repositório.

O aplicativo para entrar na contagem, deve ter alguma contagem em aberto no banco,
crie uma contagem com o <b>status = 0 e emContagem = 0</b>, você também precisara
criar o usuário na tabela de usuários.
</p>
<i>
<h2>Como utilizar</h2></i>
Efetue o login no aplicativo escrevendo o usuário, depósito e rua previamente cadastrado.
Após, em <B>ENDEREÇO</B> irá mostrar aonde este item está em um depósito.

A coluna <b>PRODUTO</b> apresenta o produto que está no endereço, com a descrição em preto abaixo,
SKU como código do produto e quantos itens vem dentro da caixa, denominado <b>Fator Caixa</b>.

Na área <b>CONTAGEM</b> é onde o usuário poderá colocar as caixas presentes no endereço e as unidades sortidas,
as caixas são multiplicadas pelo fator da caixa, logo ao lado é mostrado o total junto da validade
do lote do produto. Na imagem tem apenas um lote, porém pode ser cadastrados mais lotes no mesmo endereço, todos
os lotes no mesmo endereço e mesmo código será mostrado na aba contagem.

<h1 align="center">Tela de Login</h1>
<p align="center">
  <img src="https://github.com/ian3107/contagem_dep_app/blob/master/images/Login.png?raw=true">
</p>

<h1 align="center">Tela de Contagem</h1>
<p align="center">
  <img src="https://github.com/ian3107/contagem_dep_app/blob/master/images/Contagem.png?raw=true">
</p>

