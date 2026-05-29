1. Respostas do Questionário
Qual era a estrutura do seu projeto antes da inclusão das novas telas?
O projeto possuía apenas uma tela principal (ProductPage) que era exibida assim que o aplicativo iniciava. Ela estava estruturada em camadas (Models, Views, ViewModels, Repositories e DataSources) e fazia a listagem dos itens com estados de loading, success e error.

Como ficou o fluxo da aplicação após a implementação da navegação?
O fluxo agora é linear e sequencial: A aplicação inicia na HomePage (Tela Inicial), onde um botão direciona via navegação para a ProductPage (Tela de Produtos). Ao clicar em um item específico da lista, o usuário é direcionado para a ProductDetailsPage (Tela de Detalhes).

Qual é o papel do Navigator.push() no seu projeto?
O Navigator.push() é utilizado para adicionar (empilhar) uma nova tela sobre a atual. Ele foi usado em dois momentos: para navegar da Home para a lista de produtos, e da lista para a tela de detalhes, aproveitando para transportar o objeto do produto selecionado.

Qual é o papel do Navigator.pop() no seu projeto?
O Navigator.pop() serve para remover a tela atual do topo da pilha de navegação, retornando à tela anterior. Ele é acionado automaticamente quando o usuário clica na seta de voltar padrão da AppBar (tanto na tela de lista quanto na tela de detalhes).

Como os dados do produto selecionado foram enviados para a tela de detalhes?
Os dados foram enviados através do construtor da classe ProductDetailsPage. No evento onTap da lista, a instância do objeto Product clicado é passada como argumento na chamada da rota.

Por que a tela de detalhes depende das informações da tela anterior?
Porque, neste fluxo, a tela de detalhes não realiza uma nova chamada de rede (HTTP) para buscar as informações de um ID específico. Ela reaproveita os dados (título, preço, descrição e imagem) que já foram baixados pela tela de listagem, economizando dados e garantindo uma transição imediata.

Quais foram as principais mudanças feitas no projeto original?

Atualização do modelo Product para capturar os campos description e image da Fake API.

Criação da HomePage como ponto de entrada.

Criação da ProductDetailsPage para exibir o produto de forma ampla.

Adição do método onTap no ListTile da ProductPage contendo o Navigator.push.

Modificação no main.dart para iniciar a rota pela Home, passando o ViewModel adiante.

Quais dificuldades você encontrou durante a adaptação do projeto para múltiplas telas?
A principal dificuldade envolveu o gerenciamento das dependências. Como o ProductViewModel é instanciado no main.dart, foi preciso pensar na melhor forma de repassá-lo para a tela de produtos (já que agora a tela inicial é a Home). Além disso, garantir que o sistema de cache (SharedPreferences) não quebrasse ao adicionar as novas propriedades (imagem e descrição) ao objeto exigiu atenção.