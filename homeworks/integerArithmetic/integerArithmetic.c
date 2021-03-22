#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

void eh_primo (int num) {
	int div = 0;
	
	for (int i = 3; i < 256; i+=2) {
		if(i == num) break;
    	if (num % i == 0) { 
     		printf("O modulo nao eh primo.\n");
    		exit(0);
    	}
  	}
}

int le_inteiro () {
	int num;
	scanf("%d", &num);
	
	return num;
}

void imprime_erro(int erro) {
	if(erro > 0){
		printf("Entradas invalidas\n");
		exit(0);
	}
}

void imprime_saida(int a, int b, int m, int resultado) {
	printf("A exponencial modular %d elevado a %d (mod %d) eh %d.\n", a, b, m, resultado);
}

int calcula_exp(int a, int b, int m) {
	int resultado = 1, count = 0;

	a %= m;

	for (; b > 0; b--)
    	resultado = (resultado * a) % m;

	return resultado;
}

int analisa_entradas(int a, int b, int m) {
	int erro = 0;

	if(a < 1 || a > 65534) {
		erro += 1;
	}
	if(b < 1 || b > 65534) {
		erro += 1;
	}
	if(m < 1 || m > 65534) {
		erro += 1;
	}

	return erro;
}

int main() {
	int a, b, m;

	m = le_inteiro();
	//a = le_inteiro()
	//b = le_inteiro()
	
	//imprime_erro(analisa_entradas(a, b, m));

	eh_primo(m);

	//imprime_saida(a,b,m,calcula_exp(a, b, m));

	return 0;
}