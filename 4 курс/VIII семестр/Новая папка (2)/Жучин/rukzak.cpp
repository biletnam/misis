// rukzak.cpp
// Приложение  к  статье  "Применение криптографии  в  вопросах  защиты данных,  на
// примере рюкзачной системы шифрования." Здесь представлен текст программы удобный
// для чтения и понимания, на практике применяется более лаконичный вариант ;-)


#include <fstream.h>
#include <stdlib.h>
#include <stdio.h>

// Интерфейсная функция пользователя
int enterChoice(void);

// Функция представления символа в двоичном виде
void int2bits_ASCII(bool *a1, int integer)
{
unsigned k, displayMask = 1 << 7;

for (k=1;k<=8;k++) {
a1[k-1]=new bool;
integer & displayMask ? a1[k-1]=1: a1[k-1]=0;
integer <<=1;
                    }
}

int obratnyi(int w,int m)
{
  int z;

  for (int y=1; y<m; y++)
  {
    z=w*y;
    while (z>=m)  {
      z=z-m;
                  }
    if (z==1) return y;
  }
}

//Функция кодирования символа
int rukzak(bool *a1, int a[])
{
int c=0;
for (int  i=0; i<8; i++)
  c=c+a1[i]*a[i];
return c;
}

// Функция шифрования
void coding(int a[])
{
char ch,ch2;

bool *a1;
a1=new bool [7];
// Ввод файла, который необходимо зашифровать
char *filename;
cout<<"Input filename :"<<endl;
cin>>filename;
ifstream infile(filename, ios::in);
// Зашифрованный файл
ofstream outfile("coding.x", ios::out);
// Цикл зашифрования
while (! infile.eof())
{
  infile.read((char *) & ch, sizeof(ch));
// Представление символа в двоичном виде
  int2bits_ASCII(a1,ch);
// Шифрование символа
  ch2=rukzak(a1,a);
// Запись закодированного символа в файл
  outfile.write((char *) & ch2, sizeof(ch2));
}

cout<<"\nCode program is done!"<<endl;
}

// Передача управления функции шифрования
void incoding()
{
int m0=0;
// Cупервозростающая последовательность
int b[8]={1,2,4,8,16,32,64,128};
for (int k=0; k<8; k++)
  m0=m0+b[k];

int m=m0+1;

// Задание перестановки
int p[8]={2,1,4,3,5,8,6,7};
// Ввод параметра кодирования
int w=13;
int a[8];
int bp[8];
// Подготовка параметров к шифрованию
for (int k=0; k<8; k++)
  { bp[k]=p[k];
    a[k]=w*b[bp[k]-1];
    while (a[k]>=m)  {
    a[k]=a[k]-m;
                     }
    }
// Передача управления функции шифрования
coding(a);
}

void outcoding()
{
int m0=0;
int b[8]={1,2,4,8,16,32,64,128};

for (int k=0; k<8; k++) {
  m0=m0+b[k];
                         }
int m=m0+1;
int p[8];

cout<<"Input rearrangement :"<<endl;
for (int j=0; j<8; j++) {
  cout<<"pi ["<<j+1<<"]=";
  cin>>p[j];
                        }
int w;
cout<<"Input w :"<<endl;
cin>>w;

//int p[8]={2,1,4,3,5,8,6,7};
//int w=13;

int ch3;
int h;
int x[8];
int z[8];

FILE *stream3;
stream3 = fopen("coding.x","r");
fseek(stream3, 0, SEEK_SET);

while (!feof(stream3))
{
    ch3 = fgetc(stream3);
    if (ch3!=EOF) {
    h=obratnyi(w,m)*ch3;
    while (h>=m)
    h=h-m;
    for (int i=7; i>=0; i--)
    {if (h>=b[i]) {x[i]=1; h=h-b[i];}
     else x[i]=0;
             }
    for (int i=0; i<8; i++)
    z[i]=x[p[i]-1];

    int charout=0;
    if (z[0]==1) charout=charout+2*2*2*2*2*2*2;
    if (z[1]==1) charout=charout+2*2*2*2*2*2;
    if (z[2]==1) charout=charout+2*2*2*2*2;
    if (z[3]==1) charout=charout+2*2*2*2;
    if (z[4]==1) charout=charout+2*2*2;
    if (z[5]==1) charout=charout+2*2;
    if (z[6]==1) charout=charout+2;
    if (z[7]==1) charout=charout+1;

fprintf(stdout,"%c",charout);
        }
   }
fclose(stream3);
cout<<"\nOUTCode program is done!"<<endl;
}

main()
{
int choice;

while ((choice=enterChoice())!=3)
 {
  switch(choice) {
  case 1:incoding();break;
  case 2:outcoding();break;
  default:{cerr<<"Incorrect choice!"<<endl;
           exit(1);}break;
                    }
 }
}

// Интерфейсная функция пользователя
int enterChoice(void)
{
cout<<"\nIt's a coding program!"<<endl
    <<"Press:"<<endl
       <<"1-incoding"<<endl
       <<"2-outcoding"<<endl
       <<"3-exit"<<endl;
int menuChoice;
cin>>menuChoice;
if (menuChoice>3) {cerr<<"Incorrect choice!"<<endl;
                   exit(1);}
return menuChoice;
}

=1) charout=charout+2*2*2*2;
    if (z[4]==1) charout=charout+2*2*2;
    if (z[5]==1) charout=charout+2*2;
    if (z[6]==1) charout=charout+2;
    if (z[7]==1) charout=charout+1;
fprintf(stdout,"%c",charout);
        }
   }

fclose(stream3);
cout<<"\nOUTCode program is done!"<<endl;
cout<<"Enjoy it!!!"<<endl;
}

main()
{
int choice;
while ((choice=enterChoice())!=3)
 {
  switch(choice) {
  case 1:incoding();break;
  case 2:outcoding();break;
  default:{cerr<<"Incorrect choice!"<<endl;
           exit(1);}break;
                    }
 }
}
// Интерфейсная функция пользователя.
int enterChoice(void)
{
cout<<"\nIt's a coding program!"<<endl
    <<"Press:"<<endl
       <<"1-incoding"<<endl
       <<"2-outcoding"<<endl
       <<"3-exit"<<endl;
int menuChoice;
cin>>menuChoice;
if (menuChoice>3) {cerr<<"Incorrect choice!"<<endl;
                   exit(1);}
return menuChoice;
}

