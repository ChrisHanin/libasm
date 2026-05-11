#include "libasm.h"

void test_str(void)
{
	//printf("%d\n", suma(3, 2, 1));
	printf("***TEST FT_STRLEN***\n");
	printf("%zu\n", ft_strlen("hola"));
	printf("%zu\n", ft_strlen("holayyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"));
	printf("%zu\n", ft_strlen(""));
	printf("%zu\n", ft_strlen(NULL));

	printf("***TEST FT_STRCPY***\n");
	char src[4] = "abc";
	char dest[4] = "ddd";
	printf("%s\n", ft_strcpy(dest, src));
	printf("%s %s\n", dest, src);

	char src3[1] = "";
	char dest3[40] = "ddddddddd";
	printf("%s\n", ft_strcpy(dest3, src3));
	printf("%s %s\n", dest3, src3);

	//printf("%d\n", suma(3, 2, 1));
	printf("***TEST FT_STRCMP***\n");
	printf("%d\n", ft_strcmp("holc", "hold"));
	printf("%d\n", ft_strcmp("", ""));
	printf("%d\n", ft_strcmp("", "hold"));
	printf("%d\n", ft_strcmp("hold", ""));
	printf("%d\n", ft_strcmp("hold", "holda"));
}

void test_str_2(void)
{
	int fd = open("test.txt", O_RDWR);
	printf("***TEST FT_WRITE***\n");
	printf("%zd\n", ft_write(1, "hola\n", 5));
	printf("%d\n", errno);
	printf("%s\n", strerror(errno));

	printf("%zd\n", ft_write(fd, "hola\n", 5));
	printf("%zd\n", ft_write(2, "hola\n", 5));

	printf("%zd\n", ft_write(-2, "hola\n", 5));
	printf("%d\n", errno);
	printf("%s\n", strerror(errno));

	printf("%zd\n", ft_write(1, NULL, 4));
	printf("%d\n", errno);
	printf("%s\n", strerror(errno));

	close(fd);

	printf("***TEST FT_READ***\n");
	char buff[400];
	bzero(buff, 400);
	int fd2 = open("Makefile", O_RDONLY);
	printf("%zd\n", ft_read(fd2, buff, 399));
	buff[399] = '\0';
	printf("%s\n", buff);
	close(fd2);
	printf("%zd\n", ft_read(0, buff, 400));
	printf("%zd\n", ft_read(-12, buff, 400));
	printf("%d\n", errno);
	printf("%s\n", strerror(errno));


	printf("***TEST FT_STRDUP***\n");
	char *dup = ft_strdup("hola");
	printf("%s\n", dup);
	free(dup);
	char *dup2 = ft_strdup("");
	printf("%s\n", dup2);
	free(dup2);
	printf("%s\n", (char *)NULL);

}

void test_atoi_base(void)
{
	printf("***TEST FT_ATOI_BASE***\n");
	printf("%d\n", ft_atoi_base("16", "+123456789abcdef"));
	printf("%d\n", ft_atoi_base("16", "-123456789abcdef"));
	printf("%d\n", ft_atoi_base("16", "00"));
	printf("%d\n", ft_atoi_base("0", "0123456789abcdef"));
	printf("%d\n", ft_atoi_base("1", "0123456789abcdef"));
	printf("%d\n", ft_atoi_base("9", "0123456789abcdef"));
	printf("%d\n", ft_atoi_base("a", "0123456789abcdef"));
	printf("%d\n", ft_atoi_base("f", "0123456789abcdef"));
	printf("%d\n", ft_atoi_base("10", "0123456789abcdef"));
	printf("%d\n", ft_atoi_base("1000", "01"));
	printf("%d\n", ft_atoi_base("+2", "0123456789abcdef"));
	printf("%d\n", ft_atoi_base("-2", "0123456789abcdef"));
	printf("%d\n", ft_atoi_base("345678", "01"));
}

void print_list(t_list **a)
{
	static int num = 0;
    printf("\nstep %d\n", num);
	num++;

    if (!a || !*a)  // Verificar NULL
        return;
    
    t_list *tmp = *a;
    while (tmp)  // ✅ Cambiado: recorrer hasta NULL
    {
        printf("%s\n", (char *)tmp->data);
        tmp = tmp->next;
    }
}

void free_list(t_list **a)
{
    if (!a || !*a)  // Verificar NULL
        return;
    
    t_list *tmp = *a;
    t_list *tmp2;
    
    while (tmp)
    {
        tmp2 = tmp->next;
		free(tmp->data);
        free(tmp);
        tmp = tmp2;
    }

    *a = NULL;
}

void test_list(void)
{
    t_list *list = NULL;
    t_list **list_ptr = &list;
    char *str = ft_strdup("tophe");
    char *str2 = ft_strdup("chris");
    char *str3 = ft_strdup("hola");

    printf("***TEST FT_LIST***\n");
    
	printf("%d\n", ft_list_size(list));
    ft_list_push_front(list_ptr, str);
    print_list(list_ptr);
	printf("size is %d\n", ft_list_size(list));
    
    ft_list_push_front(list_ptr, str2);
    print_list(list_ptr);
	printf("size is %d\n", ft_list_size(list));

	ft_list_push_front(list_ptr, str3);
    print_list(list_ptr);
	printf("size is %d\n", ft_list_size(list));

	ft_list_sort(list_ptr, ft_strcmp);
    print_list(list_ptr);

	char *data_ref = "hola";

	ft_list_remove_if(list_ptr, data_ref, ft_strcmp, free);
    print_list(list_ptr);


    free_list(list_ptr);
    print_list(list_ptr);

}



int main()
{
	test_str();
	test_str_2();
	test_atoi_base();
	test_list();

	/*ft_write(-1, NULL, 6);
	printf("%d\n", errno);
	printf("%s\n", strerror(errno));*/

	return (0);
}
