#include <iostream>
#include <curl/curl.h>

int main(int argc, char *argv[]) {
	std::cout << curl_version() << std::endl;
	return 0;
}
