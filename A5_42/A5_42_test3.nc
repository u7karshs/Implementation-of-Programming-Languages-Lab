int main() {
    int a;
    int fizzCount = 0;
    int buzzCount = 0;
    int fizzBuzzCount = 0;

    for (a = 1; a <= 100; a=a+1) {
        if (a % 3 == 0) {
            fizzCount=fizzCount+1;
            printf("Fizz\n");
        }
        if (a % 5 == 0) {
            buzzCount=buzzCount+1;
            printf("Buzz\n");
        }
        if (a % 3 && a % 5) {
            fizzBuzzCount=fizzBuzzCount+1;
            printf("FizzBuzz\n");
        }
    }
    return 0;
}
