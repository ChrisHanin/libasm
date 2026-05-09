# libasm

![libasm](https://img.shields.io/badge/Language-x86__64_Assembly-blue.svg) ![42 School](https://img.shields.io/badge/42-Project-black)

**libasm** is a project from the 42 School curriculum that introduces you to the world of x86_64 Assembly language. The goal of this project is to re-write a specific set of standard C library functions entirely in Assembly. This helps demystify how higher-level language primitives are translated into machine instructions, and teaches the basics of calling conventions, stack management, and system calls.

## 🧠 About Assembly Language (x86_64 NASM)

Assembly language is a low-level programming language that provides a strong correspondence between the program's instructions and the architecture's machine code instructions. In this project, we use **NASM** (Netwide Assembler) with Intel syntax targeting the **x86_64 architecture**.

### Key Concepts

1. **Registers**: Instead of variables, assembly uses hardware registers to store and manipulate data. 
   - **General Purpose Registers**: `rax`, `rbx`, `rcx`, `rdx`, `rsi`, `rdi`, `rbp`, `rsp`, `r8` to `r15`.
   - **Return Value**: `rax` is strictly used to store the return value of a function.
   - **Stack Pointer**: `rsp` points to the top of the stack.
   - **Base Pointer**: `rbp` points to the base of the current stack frame.

2. **Calling Convention (System V AMD64 ABI)**: 
   When writing assembly functions that are callable from C (and vice-versa), we must follow the System V ABI calling convention (used on Linux/macOS):
   - The first 6 integer/pointer arguments are passed in registers: `rdi`, `rsi`, `rdx`, `rcx`, `r8`, `r9`.
   - Additional arguments are pushed onto the stack.
   - Registers `rbx`, `rbp`, `rsp`, and `r12` to `r15` are **callee-saved** (they must be preserved by our function).
   - All other registers are **caller-saved** (freely volatile).

3. **System Calls (`syscall`)**:
   Sometimes a function needs to ask the operating system to perform an action, such as reading input or writing output. In 64-bit Linux/macOS, this is done via the `syscall` instruction. Setting `rax` to a specific code identifies the system call (e.g., `sys_write`, `sys_read`).

## 📁 Functions Implemented

### Mandatory Part
These are standard library clones written in `.s` files:

* [`ft_strlen.s`](ft_strlen.s): `size_t ft_strlen(const char *s);`
  Calculates the length of a string by iterating through bytes until the null terminator (`\0`) is found.
* [`ft_strcpy.s`](ft_strcpy.s): `char *ft_strcpy(char *dest, const char *src);`
  Copies the string pointed to by `src` into the array pointed to by `dest`.
* [`ft_strcmp.s`](ft_strcmp.s): `int ft_strcmp(const char *s1, const char *s2);`
  Compares two strings byte by byte. Returns the difference of the first unmatched character.
* [`ft_write.s`](ft_write.s): `ssize_t ft_write(int fd, const void *buf, size_t count);`
  Writes data to a file descriptor. This acts as a wrapper for the `write` system call. Checks internal system call errors (Setting `errno`).
* [`ft_read.s`](ft_read.s): `ssize_t ft_read(int fd, void *buf, size_t count);`
  Reads data from a file descriptor. Wrapper for the `read` system call, also updating `errno` on failure.
* [`ft_strdup.s`](ft_strdup.s): `char *ft_strdup(const char *s);`
  Duplicates a string by dynamically allocating memory. This function demonstrates how to call an external C function (`malloc`) from within Assembly.

### Bonus Part
Advanced functions dealing with linked lists and mathematics:

* [`ft_atoi_base.s`](ft_atoi_base.s): `int ft_atoi_base(char *str, char *base);`
  Converts a string representation of a number in a given base string to an integer.
* [`ft_list_push_front.s`](ft_list_push_front.s): `void ft_list_push_front(t_list **begin_list, void *data);`
  Adds a new element of type `t_list` to the beginning of the linked list. 
* [`ft_list_size.s`](ft_list_size.s): `int ft_list_size(t_list *begin_list);`
  Returns the number of elements in the linked list.
* [`ft_list_sort.s`](ft_list_sort.s): `void ft_list_sort(t_list **begin_list, int (*cmp)());`
  Sorts the list's elements by data, using a given comparison function pointer.
* [`ft_list_remove_if.s`](ft_list_remove_if.s): `void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));`
  Removes from the list those elements whose data compared to `data_ref` via `cmp` is 0. The data is freed implicitly using `free_fct`.

## 🛠 Compilation and Usage

The repository includes a `Makefile` to automate assembly and archiving.

### Commands

* `make` : Assembles the mandatory source files and creates the static library `libasm.a`.
* `make bonus` : Compiles the mandatory and bonus files, adding them to `libasm.a`.
* `make clean` : Removes the object files (`.o`).
* `make fclean` : Removes the object files and the generated library (`libasm.a`).
* `make re` : Performs a full recompilation (`fclean` then `make`).

### Using the Library

To use the library in your C projects, link it during compilation. For example:

```bash
# Compile and create the libasm.a
make

# Compile your main C file linking libasm
gcc -Wall -Wextra -Werror main.c -L. -lasm -o my_program

# Run
./my_program
```

### Testing (`main.c`)
Included in the directory is a `main.c` file that tests the implemented functions against the standard C library alternatives to ensure they behave identically (including `errno` assignments). Feel free to modify `main.c` or build your own unit tests to thoroughly analyze the Assembly implementations.

---
*Happy coding at the low-level tier!*
