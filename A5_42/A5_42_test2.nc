int potato() {
    int i;
    for (i = 25; i > 0; i = i - 2) {
        if (i >= 'B' && i <= 101)
            i = 2 * i;
        else {
            if (i > 55 && i <= 'x')
                i = 77;
        }
    }
    return i;
}

int main()
{
  int p = 0;
  p = potato();
  return 0;
}
