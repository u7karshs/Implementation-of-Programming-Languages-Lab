void twopower(int curr) {
    int i;
    int i1=1;
    for(i = 0 ; i <= curr ; i = i + 1){
    printInt(i1);
    printStr(" ");
    i1 = i1 * 2;
    }
}



int main() 
{
    printStr("\nPower of 2");
    int start;
    printStr("\nEnter the count: ");
  start= readInt(&ep);
    printStr("\ntwo power series of ");
    printInt(start);
        printStr(" are: ");
    twopower(start);
}
