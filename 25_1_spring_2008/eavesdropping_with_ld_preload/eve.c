#include <stdio.h>            
#define __USE_GNU 1           
#include <unistd.h>
#include <dlfcn.h>  

/* Typedef some function pointers for memcpy() and read() */ 
typedef void *(*memcpy_t) (void *dest, const void *src, size_t n);
typedef ssize_t (*read_t) (int FD, void *buf, size_t n);

/* Utility - Returns the address of the function having the name funcName */
static void *getLibraryFunction(const char *funcName)
{
    void *res;

    if ((res = dlsym(RTLD_NEXT, funcName)) == NULL) {
        fprintf(stderr, "dlsym %s error:%s\n", funcName, dlerror());
        _exit(1);
    }
    return res;
}

/* Our hi-jacked MEMCPY() stub. We dump our args to STDERR. */
void *memcpy(void *dest, const void *src, size_t n)
{
  static memcpy_t real_memcpy = NULL;

  //  fprintf(stderr,"MEMCPY:\nSRC: %s\nDST: %s\nSIZE: %d\n----------------\n", src, dest, n);
  fprintf(stderr, "MEMCPY: \nSRC: ");
  fwrite(src, n, 1, stderr);
  fprintf(stderr, "\nDST: ");
  fwrite(dest, n, 1, stderr);
  fprintf(stderr, "\nSIZE: %d\n----------------------\n", n);
  real_memcpy = getLibraryFunction("memcpy");
  return real_memcpy(dest, src, n);
}

/* Hi-jacked READ() */
ssize_t read (int FD, void *buf, size_t n)
{
  static read_t real_read = NULL;
  ssize_t i;

  real_read = getLibraryFunction("read");
  i = real_read(FD, buf, n);
  
  fprintf(stderr, "READ:\nFD: %d\nBUF: %s\nSIZE: %d\n-------------------\n", FD, buf, n);
  return i;
}
