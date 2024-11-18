#include <stdio.h>

#if 1
#include <stdexcept>

int fn(int x) {
    if (x < 0) {
        throw("A Error");
    }
    return 0;
}

int one() {
    try {
        fn(-5);
    } catch(const char *err) {
        return -1;
    }
    return 0;
}
#else

int fn(int x) {
    if (x < 0) {
        printf("ERROR");
        __builtin_trap();
    }
    return 0;
}

int one() {
    if (fn(-5)) {
        return -1;
    }
    return 0;
}

#endif
