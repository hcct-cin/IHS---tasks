#include <stdio.h>
#include <string.h>


extern int palindrome(char* a,int tamanho);

int main(int argc, char **argv)
{
  char entrada[100];
  int tamanho;


  scanf("%s", entrada);
  tamanho = strlen(entrada);

  printf("%d\n", palindrome(entrada,tamanho-1)); /*passo como parametro a string e o tamanho dela)*/
  return 0;
}

