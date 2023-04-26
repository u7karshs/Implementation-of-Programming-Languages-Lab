int fibNum(int n) {
    if (n == 0) {
        return 0;
    } else if (n == 1) {
        return 1;
    } else {
        return fibNum(n - 1) + fibNum(n - 2);
    }
}

int main() {
    int start;
    printStr("\nEnter the count: ");
  start= readInt(&ep);
printStr("Printing fibonacci series: ");
        printInt(fibNum(start));
        printStr("\n\n");
    }
    return 0;
}
