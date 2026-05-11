/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: chanin <chanin@student.42malaga.com>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/04/10 14:02:31 by chanin            #+#    #+#             */
/*   Updated: 2026/05/09 13:46:12 by chanin           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H

# include <stdio.h>
# include <unistd.h>
# include <string.h>
# include <sys/stat.h>
# include <fcntl.h>
# include <stdlib.h>
# include <errno.h>


typedef struct s_list
{
	void *data;
	struct s_list *next;
} t_list;

//int	suma(int a, int b, int c);
size_t	ft_strlen(char *str);
char	*ft_strcpy(char *dest, const char *src);
int		ft_strcmp(const char *s1, const char *s2);
ssize_t ft_write(int fd, const void *buf, size_t count);
ssize_t ft_read(int fd, void *buf, size_t count);
char	*ft_strdup(const char *s);
int		ft_atoi_base(char *str, char *base);

void	ft_list_push_front(t_list **begin_list, void *data);
int		ft_list_size(t_list *begin_list);
void	ft_list_sort(t_list **begin_list, int (*cmp)());
void	ft_list_remove_if(t_list **begin_list, void *data_ref,
						int (*cmp)(), void (*free_fct)(void *));

#endif
