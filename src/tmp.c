#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
// #include "SDL/SDL.h"
#include "SDL/SDL_ttf.h"

typedef struct          s_champions
{
  char                  *filename;
  int                   size;
  unsigned int          prog_number;
  unsigned int          load_address;
  char                  *name;
  char                  *comment;
  int                   *reg;
  int                   pc;
  unsigned int          carry;
  unsigned int          last_live;
  int                   cycle_to_wait;
  int                   color_gui;
  struct s_champions    *next;
}                       t_champions;

typedef struct          s_corewar
{
  unsigned char         *arena;
  unsigned char         *info_arena;
  unsigned int          nb_champions;
  t_champions           *champions;
  t_champions           *last_champions;
  int                   last_live_nb;
  char                  *last_live_name;
  int                   prog_number_max;
  unsigned long long    nbr_cycle_dump;
  int                   nbr_live_cur;
  int                   is_desassembler;
  int                   cycle_to_die_cur;
}                       t_corewar;

typedef struct          s_gui
{
  void			*screen;
  void			*byte_arena;
  void			*background;
  void			 *players[5];
  /* SDL_Surface           *screen; */
  /* SDL_Surface           *byte_arena; */
  /* SDL_Surface           *background; */
  /* SDL_Surface           *players[5]; */
  void              *font;
  void              *font_info;
  /* TTF_Font              *font; */
  /* TTF_Font              *font_info; */
  int                   *list_pc;
  SDL_Rect              pos_background;
  SDL_Color             my_color;
}                       t_gui;

typedef struct          s_instruction
{
  unsigned char         code;
  unsigned char         type;
  int                   params[4];
}                       t_instruction;

void	disp_reg(int *reg)
{
  int	i;

  i = 1;
  while (i <= 16)
  {
    printf("reg[%d] = %d\n", i, reg[i]);
    i += 1;
  }
}

void disp_carry(t_champions *champions)
{
  printf("carry = %d\n", champions->carry);
}

/* void	disp_inst(t_instruction *instruction) */
/* { */
/*   printf("&instruction = %x sizeof(instruction) = %d\n", instruction, sizeof(*instruction)); */
/*   printf("code = %d type = %c p[0] = %d p[1] = %d p[2] = %d p[3] = %d\n", */
/* 	 instruction->code, instruction + 1, instruction + 2, instruction + 6, */
/* 	 instruction + 10, instruction + 14); */
/*   /\* printf("code = %d type = %d p[0] = %d p[1] = %d p[2] = %d p[3] = %d\n", *\/ */
/*   /\* 	 instruction->code, instruction->type, instruction->params[0], *\/ */
/*   /\* 	 instruction->params[1], instruction->params[2], *\/ */
/*   /\* 	 instruction->params[3]); *\/ */
/* } */

void	disp_core(t_corewar *core)
{
  printf("&core = %x\n&arena = %x\n&info_arena = %x\n&champions = %x\n\n",
	 core, core->arena, core->info_arena, core->champions);
}

void		disp_list(t_corewar *core, t_gui *gui)
{
  t_champions	*tmp;
  int		i;
  int		*list;

  i = 0;
  list = gui->list_pc;
  tmp = core->champions;
  while (tmp)
  {
    printf("pc = %d couleur = %d\n", list[i], list[i + 1]);
    i += 2;
    tmp = tmp->next;
  }
  printf("END\n");
}

void	disp_gui(t_gui *gui)
{
  printf(" &gui = %x\n &screen = %x\n &byte_arena = %x\n &list_pc = %x\n\n",
	 gui, gui->screen, gui->byte_arena, gui->list_pc);
}

int		printa(t_corewar *core)
{
  t_champions	*tmp;

  tmp = core->champions;
  while (tmp)
  {
    printf("filename = %s addr = %d prog_number = %d size = %d name = '%s' comment = '%s' pc = %d\n\n",
	   tmp->filename, tmp->load_address, tmp->prog_number, tmp->size, tmp->name, tmp->comment, tmp->pc);
    tmp = tmp->next;
  }
  return (0);
}

/* void	my_putchar(char c) */
/* { */
/*   write(1, &c, 1); */
/* } */

/* void	my_putnbr(int nb) */
/* { */
/*   if (nb < 0) */
/*   { */
/*     nb = -nb; */
/*     my_putchar('-'); */
/*   } */
/*   if (nb >= 10) */
/*     my_putnbr(nb / 10); */
/*   my_putchar((nb % 10) + '0'); */
/* } */

void	adisp_arena(unsigned char *arena)
{
  int	i;

  i = 0;
  printf("ptr = %x\n", arena);
  while (i + 1 < 1024 * 6)
  {
    my_putnbr(arena[i]);
    i += 1;
  }
}

/* void            my_put_hexa(unsigned char nb, char *base, int is_first) */
/* { */
/*   if (nb < 16 && is_first == 1) */
/*     my_putchar('0'); */
/*   if (nb >= 16) */
/*     my_put_hexa(nb / 16, base, 0); */
/*   my_putchar(base[(nb % 16)]); */
/* } */

/* void            write_hex(int i, int line_cur, int size, unsigned char *str) */
/* { */
/*   while (i < (32 * line_cur + 32) && i < size) */
/*   { */
/*     my_put_hexa(str[i], "0123456789ABCDEF", 1); */
/*     i = i + 1; */
/*   } */
/* } */

/* int             my_showmem(unsigned char *str, int size) */
/* { */
/*   int           nb_lines; */
/*   int           line_cur; */
/*   int           i; */

/*   line_cur = 0; */
/*   i = 0; */
/*   nb_lines = 1 + size / 32; */
/*   while (line_cur < nb_lines && i < size) */
/*   { */
/*     write_hex(i, line_cur, size, str); */
/*     my_putchar('\n'); */
/*     line_cur = line_cur + 1; */
/*     i = 32 * line_cur; */
/*   } */
/*   return (0); */
/* } */

/* int      to_negativ(int nb, int nb_octet) */
/* { */
/*   int           i; */
/*   int           tmp; */
/*   int           res; */

/*   res = 0; */
/*   i = 0; */
/*   if ((nb_octet == 4 && (nb & 0b1000000000000000000000000000000) != 0) */
/*       || (nb_octet == 2 && (nb & 0b100000000000000) != 0)) */
/*   { */
/*     if (nb_octet == 4) */
/*       i = 0b1000000000000000000000000000000; */
/*     else if (nb_octet == 2) */
/*       i = 0b1000000000000000; */
/*     while (i) */
/*     { */
/*       tmp = nb & i; */
/*       if (tmp == 0) */
/*         res += i; */
/*       i = i >> 1; */
/*     } */
/*     res += 1; */
/*     nb = -res; */
/*   } */
/*   return (nb); */
/* } */
