#include "numbers.h"
#include <random>

Numbers::Numbers() {}

int Numbers::getRandomInt(int min, int max) {
    std::random_device rd;
    std::mt19937 gen(rd());

    std::uniform_int_distribution<int> distrib(min, max);

    return distrib(gen);
}