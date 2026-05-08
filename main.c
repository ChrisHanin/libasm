#include "libasm.h"

void test_str(void)
{
	//printf("%d\n", suma(3, 2, 1));
	printf("***TEST FT_STRLEN***\n");
	printf("%zu\n", ft_strlen("hola"));
	printf("%zu\n", ft_strlen(NULL));

	printf("***TEST FT_STRCPY***\n");
	char src[4] = "abc";
	char dest[4] = "ddd";
	printf("%s\n", ft_strcpy(dest, src));
	printf("%s %s\n", dest, src);

	char src3[4] = "abc";
	char dest3[40] = "ddddddddd";
	printf("%s\n", ft_strcpy(dest3, src3));
	printf("%s %s\n", dest3, src3);

	//printf("%d\n", suma(3, 2, 1));
	printf("***TEST FT_STRCMP***\n");
	printf("%d\n", ft_strcmp("holc", "hold"));
	printf("%d\n", ft_strcmp("hold", "hold"));
	printf("%d\n", ft_strcmp("hold", "holc"));
	printf("%d\n", ft_strcmp("hold", "holda"));
}

void test_str_2(void)
{
	printf("***TEST FT_WRITE***\n");
	printf("%zd\n", ft_write(1, "hola\n", 5));
	printf("%zd\n", ft_write(1, NULL, 4));

	printf("***TEST FT_READ***\n");
	char buff[400];
	int fd = open("Makefile", O_RDONLY);
	printf("%zd\n", ft_read(fd, buff, 400));
	printf("%s\n", buff);

	printf("***TEST FT_STRDUP***\n");
	char *dup = ft_strdup("hola");
	printf("%s\n", dup);
	free(dup);
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
        free(tmp);
        tmp = tmp2;
    }

    *a = NULL;
}

void test_list(void)
{
    t_list *list = NULL;
    t_list **list_ptr = &list;
    char *str = "tophe";
    char *str2 = "chris";
    char *str3 = "hola";

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


    free_list(list_ptr);
}



int main()
{
	//test_str();
	//test_str_2();
	//test_atoi_base();
	test_list();

	return (0);
}