# Assembly MIPS64 — Sistemas 1

Exercícios de Assembly MIPS64 feitos nas aulas de Sistemas (simulador WinMIPS64 / EduMIPS64).

## Exercícios

| Ficheiro | Descrição |
|---|---|
| `ficha1_A.asm`, `ex1_a_test.s` | Soma de variáveis em memória |
| `ex_2.asm`, `ex2_b.s` | Troca dos valores de duas variáveis |
| `ex3.s` | Soma e mostra o resultado no terminal (CONTROL/DATA) |
| `ex4.s` | Lê dois inteiros do teclado, soma e mostra |
| `ex5_a.s` | "hello world" no terminal |
| `ex5_B.s` | Lê dois valores e diz se são iguais |
| `ex5c.s` | Lê dois valores e mostra o maior |
| `ex6a.s`, `training_ex6.s` | Jogo de adivinhar o número secreto, com contagem de tentativas |
| `test_*.s`, `tets_*.s`, `testex*.s` | Testes e rascunhos |

## I/O do terminal

- `CONTROL` = `0x10000`, `DATA` = `0x10008`
- Códigos usados: `1` inteiro sem sinal, `2` inteiro com sinal, `4` string, `6` limpar ecrã, `8` ler inteiro

## Publicar no GitHub

- `publicar.bat` — commit + push (na 1.ª vez cria o repo).
- `vigiar.bat` — enquanto estiver aberto, publica sozinho 5 s depois de guardares um ficheiro.
- `configurar_notepad.bat` — põe o Notepad++ a guardar nesta pasta.
