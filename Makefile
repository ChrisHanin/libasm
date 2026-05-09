# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: chanin <chanin@student.42malaga.com>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/10 14:02:31 by chanin            #+#    #+#              #
#    Updated: 2026/05/09 13:46:29 by chanin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = libasm.a

NASM = nasm
NASMFLAGS = -f elf64

AR = ar rcs

VAL = valgrind --show-leak-kinds=all --leak-check=full -s

SRC = 	ft_strlen.s \
		ft_strcpy.s \
		ft_strcmp.s \
		ft_write.s \
		ft_read.s \
		ft_strdup.s \
		ft_atoi_base.s \
		ft_list_push_front.s \
		ft_list_size.s \
		ft_list_sort.s \
		ft_list_remove_if.s 
		
#SRC_B =

OBJ = $(SRC:.s=.o)
#OBJ_B = $(SRC_B:.s=.o)

INCLUDE = libasm.h

#####################################
# make re && make cae && make clean #
#####################################

all: $(NAME)

$(NAME): $(OBJ)
	$(AR) $(NAME) $(OBJ)

#bonus: $(OBJ) $(OBJ_B)
#	$(AR) $(NAME) $(OBJ) $(OBJ_B)

%.o: %.s $(INCLUDE)
	$(NASM) $(NASMFLAGS) $< -o $@

clean:
	rm -f $(OBJ) $(OBJ_B)

fclean: clean
	rm -f $(NAME)

# compile and execute
cae: $(NAME)
	cc -g main.c $(NAME) -o test
	$(VAL) ./test

re: fclean all

.PHONY: all bonus clean fclean re
