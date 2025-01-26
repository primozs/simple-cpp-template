#pragma once
#include <iostream>

template <typename... Args>
void echo(Args... args) {
   ((std::cout << args << ", "), ...);
   std::cout << "\n";
}
