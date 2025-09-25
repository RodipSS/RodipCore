#ifndef RDLIB_H
#define RDLIB_H

#ifdef __cplusplus
extern "C" {
#endif



int scanf(const char *format, ...);

int GetLength(char *input) {
    int i = 0;
    while (input[i] != '\0') {
        i++;
    }
    return i;
}

int IntLength(int input) {
    int len = 0;

    if (input == 0) return 1;
    if (input < 0) input = -input;

    while (input != 0) {
        input /= 10;
        len++;
    }
    return len;
}

int EraseFirstNumber(int input) {
    return input % 10;
}

int EraseLastNumber(int input) {
    return input / 10;
}

// Проверка, содержит ли число variable цифру number
int ifIntContains(int variable, int number) {
    if (variable < 0) variable = -variable; // поддержка отрицательных чисел

    while (variable > 0) {
        if (variable % 10 == number) {
            return 1;
        }
        variable /= 10;
    }
    return 0;
}

#ifdef __cplusplus
}
#endif

#endif // RDLIB_H
