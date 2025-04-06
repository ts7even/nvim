#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

#define VAULT_PATH                                                             \
  "/home/bourbon/notes/obsidian/vaults/neuron" // Corrected VAULT_PATH

int directory_exists(const char *path) {
  struct stat st;
  return (stat(path, &st) == 0 && S_ISDIR(st.st_mode));
}

int create_directory(const char *path) {
  if (mkdir(path, 0755) != 0) {
    perror("Failed to create directory");
    return 1;
  }
  return 0;
}

int main(int argc, char *argv[]) {
  if (argc != 2) {
    fprintf(stderr, "Usage: ob <subfolder>\n");
    return 1;
  }

  char path[1024];
  snprintf(path, sizeof(path), "%s/%s", VAULT_PATH,
           argv[1]); // Fix path construction

  // Check if the directory exists
  if (!directory_exists(path)) {
    char choice[10];
    printf("Directory '%s' does not exist. Create it? [y/N]: ", argv[1]);

    // Check for user input to create directory
    if (fgets(choice, sizeof(choice), stdin) == NULL ||
        (choice[0] != 'y' && choice[0] != 'Y')) {
      printf("Aborted.\n");
      return 0;
    }

    // Create the directory
    if (mkdir(path, 0755) != 0) {
      perror("Failed to create directory");
      return 1;
    }
  }

  // Change to the target directory
  if (chdir(path) != 0) {
    perror("Failed to change directory");
    return 1;
  }

  // Open Neovim in that directory
  execlp("nvim", "nvim", ".", (char *)NULL);
  perror("Failed to launch nvim");
  return 1;
}
