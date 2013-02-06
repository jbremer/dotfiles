#include <stdio.h>
#include <string.h>

int main()
{
    FILE *fp = fopen(".git/HEAD", "r");
    if(fp != NULL) {
        char buf[512];
        fread(buf, sizeof(buf), 1, fp);
        fclose(fp);

        char *ptr = strrchr(buf, '\r');
        if(ptr != NULL) *ptr = 0;

        ptr = strrchr(buf, '\n');
        if(ptr != NULL) *ptr = 0;

        ptr = strrchr(buf, '/');
        if(ptr != NULL) ptr++;

        printf(" (%s)", ptr);
    }
}
