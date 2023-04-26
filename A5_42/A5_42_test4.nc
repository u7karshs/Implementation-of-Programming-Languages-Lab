int fact(int n) {
    int m = n - 1;
    int r = 1;
    if (m) {
        int t = fact(m - 1);
        r = n * t;
    }
    return r;
}

int randomNumber = 46;
int main() {
    int res = factorial(randomNumber);
    return 0;
}

