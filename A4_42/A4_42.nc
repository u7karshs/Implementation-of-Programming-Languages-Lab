/*
Name: Utkarsh Srivastava
RollNo: 226201003
*/


/* Find max of n numbers using array */
int main(void) {
int n;
int a[10];
int m=10;
int i=7;
int b;
char c;

readInt(&n);
for(i = 0; i <= n; i = i + 1) {
readInt(&m);
a[i] = m + 2;
}

if(i == n){
	printf("_ a b c d e f g h i j k  \a \b \f \n   q r s t u v w x y z");
}
else{
	printf("A B C D E F G H I J K L M \r \t \v N O P Q R S T U V W X Y Z");
	printf(" %d", a[i]);
}
m = a[0];
for(i = 1; i < n; i = i + 1) {
if (a[i] > m)
m = a[i] - 1;
}
printStr("Max of: ");
printInt(a[0]);
for(i = n-1; i >= 1; i = i - 1) {
printStr(", "); 
printInt(a[i] * a[i]);
printInt(a[i] / a[i]);
printInt(a[i] % 2);
}

if(a[i] > 0){
i != 1 ? (a[i] && a[i]) : (a[i] || a[i]) ;
a[i] -> b;
int i = 5;
i->b = 42;  
/* Write 42 into `int` at address 7 */
100->a = 0; 

// Write 0 into `int` at address 100 \\n
}

printStr(": = ");
printInt(m);
return 0;
}
