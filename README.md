# River Raid Demake

<p align="center">
  <img src="imagens/bemvindo.png" width="30%" alt="Imagem 1">
  <img src="imagens/jogo.png" width="30%" alt="Imagem 2">
  <img src="imagens/gameover.png" width="30%" alt="Imagem 3">
</p>

Esse repositório contém uma cópia do jogo River Raid da Activision produzido para Atari 2600. Esse jogo foi desenvolvido totalmente em linguagem montadora para o [Processador do ICMC](https://github.com/simoesusp/Processador-ICMC).

## Instalação

Para executar o jogo será necessário monta-lo e executá-lo no simulador. Para tanto, execute os seguintes comandos no terminal:
```bash
chmod +x ./rodar.sh
./rodar.sh
```

### Instalação manual

1. Compile o montador na pasta `Assembler_Source`.
2. Compile o simulador na pasta `Simulator_Source`.
3. Mova os dois executáveis para a raiz do repositório.
4. Monte e execute o jogo: `./montador joguinho.asm joguinho.mif && ./sim joguinho.asm charmap.mif`

### Dependências

Para instalar, é necessário ter `gcc`, `g++` e `make` instalados localmente, além disso as bibliotecas `gtk-2.0` e `SDL2` são utilizadas pelos programas.

## Como jogar

| Tecla     | Ação                       |
|-----------|----------------------------|
| `A`       | Move a nave para esquerda  |
| `D`       | Move a nave para direita   |
| `Espaço`  | Atira                      |
| `R`       | Reinicia após o Game Over  |

Na tela inicial, aperte **espaço** para começar.


## Autores

- Michel Filho ([@MichelHBFilho](https://github.com/MichelHBFilho))
- Mauricio Silveira ([@Mauricio-ATS](https://github.com/Mauricio-ATS))
- Matheus Rufino ([@mtrufino](https://github.com/mtrufino))
- Gabriel Teske

Projeto desenvolvido para a disciplina de Organização e Arquitetura de Computadores, ICMC-USP.

