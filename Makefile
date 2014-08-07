
NAME		= corewar

SRCS		= src/main.asm						\
		  src/arguments.asm					\
		  src/get_dump.asm					\
		  src/save_args.asm					\
		  src/save_champion.asm					\
		  src/list_champions.asm				\
		  src/load_file_in_arena.asm				\
		  src/init_reg.asm					\
		  src/load_arena.asm					\
		  src/init_values_champions.asm				\
		  src/find_max_prog_number.asm				\
		  src/load_champions_in_arena.asm			\
		  src/utils/check_args.asm				\
		  src/utils/usage.asm					\
		  src/utils/attribute_i_to_someone.asm			\
		  src/utils/check_same_prog_number.asm			\
		  src/utils/check_big_prog_number.asm			\
		  src/utils/attribute_prog_number.asm			\
		  src/utils/attribute_one_def.asm			\
		  src/utils/attribute_two_def.asm			\
		  src/utils/is_already_define.asm			\
		  src/utils/attribute_address_defined.asm		\
		  src/utils/attribute_address.asm			\
		  src/utils/swap_int.asm				\
		  src/utils/init_arena.asm				\
		  src/utils/check_place_arena.asm			\
		  src/utils/convert_endian.asm				\
		  src/utils/get_magic.asm				\
		  src/utils/get_size.asm				\
		  src/utils/get_name.asm				\
		  src/utils/get_name_comment_champions.asm		\
		  src/utils/get_comment.asm				\
		  src/utils/read_arena.asm				\
		  src/utils/write_arena_two.asm				\
		  src/utils/write_arena_four.asm			\
		  src/utils/my_strcmp.asm				\
		  src/utils/my_strlen.asm				\
		  src/utils/my_putnbr.asm				\
		  src/utils/my_putstr.asm				\
		  src/utils/my_strcat.asm				\
		  src/utils/to_negativ.asm				\
		  src/utils/int_to_str.asm				\
		  src/utils/my_showmem.asm				\
		  src/gui/my_gui.asm					\
		  src/gui/get_image_path.asm				\
		  src/gui/load_players_name.asm				\
		  src/gui/put_background.asm				\
		  src/gui/get_list_pc.asm				\
		  src/gui/is_pc.asm					\
		  src/gui/set_color_with_pc.asm				\
		  src/gui/hex_to_str.asm				\
		  src/gui/get_color.asm					\
		  src/gui/events.asm					\
		  src/gui/print_bytes.asm				\
		  src/gui/disp_arena.asm				\
		  src/gui/get_arena.asm					\
		  src/gui/disp_players.asm				\
		  src/gui/disp_info_players.asm				\
		  src/gui/get_color_champions.asm			\
		  src/exec_instructions/winner.asm			\
		  src/exec_instructions/check_first_in_list.asm		\
		  src/exec_instructions/check_live_process.asm		\
		  src/exec_instructions/is_special.asm			\
		  src/exec_instructions/fulfil_dir.asm			\
		  src/exec_instructions/fulfil_params.asm		\
		  src/exec_instructions/get_type_and_param.asm		\
		  src/exec_instructions/get_instruction.asm		\
		  src/exec_instructions/exec_function.asm		\
		  src/exec_instructions/exec_instructions.asm		\
		  src/exec_instructions/manage_instructions.asm		\
		  src/exec_instructions/get_cycle_to_wait.asm		\
		  src/exec_instructions/search_who_still_alive.asm	\
		  src/functions/is_good_register.asm			\
		  src/functions/is_indirect.asm				\
		  src/functions/is_register.asm				\
		  src/functions/my_add.asm				\
		  src/functions/my_and.asm				\
		  src/functions/get_value.asm				\
		  src/functions/get_size_param.asm			\
		  src/functions/copy_reg.asm				\
		  src/functions/my_lfork.asm				\
		  src/functions/my_fork.asm				\
		  src/functions/my_ld.asm				\
		  src/functions/my_lld.asm				\
		  src/functions/my_ldi.asm				\
		  src/functions/my_lldi.asm				\
		  src/functions/my_or.asm				\
		  src/functions/my_st.asm				\
		  src/functions/my_sti.asm				\
		  src/functions/my_sub.asm				\
		  src/functions/my_live.asm				\
		  src/functions/my_zjmp.asm				\
		  src/functions/my_xor.asm				\
		  src/functions/get_first_value.asm			\
		  src/functions/get_second_value.asm			\
		  src/functions/is_direct.asm				\
		  src/desassembleur/print_instruction.asm		\
		  src/desassembleur/my_desassembler.asm			\
		  src/desassembleur/desassemble_it.asm			\
		  src/desassembleur/print_args.asm


OBJS		= $(SRCS:.asm=.o)

NASM		= nasm

CC		= gcc

INC		= -I includes/

NASMFLAGS	= -f elf $(INC) -g -F dwarf -Werror

CFLAGS		= -lSDL -lSDL_ttf
# CFLAGS		= -Wall -Wextra -L./SDL -lSDL -lSDL_ttf -Xlinker "-rpath=./SDL" -lpthread -lm -ldl -lSDL 

RM		= rm -f

all:		$(NAME)

$(NAME):	$(OBJS)
#		$(CC) -m32 -o $(NAME) $(OBJS) tmp.o $(CFLAGS)
		$(CC) -m32 -o $(NAME) $(OBJS) tmp.o -ggdb $(CFLAGS)
		@echo -e "\033[0;032m[$(NAME)] Compiled\033[0;0m"

%.o:		%.asm
		$(NASM) $(NASMFLAGS) -o $@ $<

clean:
		@echo -e "\033[0;031m[clean] " | tr -d '\n'
		$(RM) $(OBJS)
		@echo -e "\033[0;0m" | tr -d '\n'

fclean:		clean
		@echo -e "\033[0;031m[fclean] " | tr -d '\n'
		$(RM) $(NAME)
		@echo -e "\033[0;0m" | tr -d '\n'

re:		fclean all
