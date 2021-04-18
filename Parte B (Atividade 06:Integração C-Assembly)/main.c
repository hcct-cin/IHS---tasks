#include <stdio.h>
#include <string.h>


extern int sort(int* a,int tamanho);

int main(int argc, char **argv)
{
  int entrada[100];
  int tamanho;
  int i;
  scanf("%d", &tamanho);                // getting the length

  for(i = 0 ; i < tamanho ; i++){
    scanf("%d", &entrada[i]);           // getting values of the array
  }


  sort(entrada,tamanho-1);              // calling the ASM function

  for(i=0;i<tamanho;i++){
      printf("%d ", entrada[i]);        // printing the array
  }

  printf("\n");                         // just for identation
  return 0;
}
