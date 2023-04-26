void printNums(int curr, int till) {
    if (curr > till) {
        return;
    }
    printInt(curr);
    if(curr == till) {
        printStr("\n");
    } else {
        printStr(" ");
        printNums(curr + 1, till);
    }
}



int main() 
{
    printStr("\nRecursive function calls\n");
    int start, end, ep;
    printStr("\nNumbers start number: ");
   start= readInt(&ep);
   printStr("\nNumbers end number: ");
   end= readInt(&ep);
    printStr("\nNumbers from ");
    printInt(start);
    printStr(" to ");
    printInt(end);
    printStr(" are: ");
    printNums(start, end);
}
