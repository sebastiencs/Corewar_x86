
%ifndef COREWAR_INC
 %define COREWAR_INC

 %include "macro.inc"
 %include "SDL_definitions.inc"

struc		s_instruction
 .code:			resb	1
 .type:			resb	1
 .params:		resd	4
endstruc

struc		s_corewar
 .arena:		resd	1		; char *
 .info_arena:		resd	1		; char *
 .nb_champions:		resd	1		; unsigned int
 .champions:		resd	1		; t_champions *
 .last_champions:	resd	1		; t_champions *
 .last_live_nb:		resd	1		; int
 .last_live_name:	resd	1		; char *
 .prog_number_max:	resd	1		; unsigned int
 .nbr_cycle_dump:	resd	1		; int
 .nbr_live_cur:		resd	1		; int
 .is_desassembler:	resd	1		; int
 .cycle_to_die_cur:	resd	1		; int
endstruc

struc		s_champions
 .filename:		resd	1		; char *
 .size:			resd	1		; int
 .prog_number:		resd	1		; unsigned int
 .load_address:		resd	1		; unsigned int
 .name:			resd	1		; char *
 .comment:		resd	1		; char *
 .reg:			resd	1		; int *
 .pc:			resd	1		; int
 .carry:		resd	1		; unsigned int
 .last_live:		resd	1		; unsigned int
 .cycle_to_wait:	resd	1		; int
 .color_gui:		resd	1		; int
 .next:			resd	1		; s_champions *
endstruc

struc		s_gui
 .screen:		resd	1		; SDL_Surface *
 .byte_arena:		resd	1		; SDL_Surface *
 .background:		resd	1		; SDL_Surface *
 .players:		resd	5		; SDL_Surface[5] *
 .font:			resd	1		; TTF_Font *
 .font_info:		resd	1		; TTF_Font *
 .list_pc:		resd	1		; int *
 .pos_background:	resd	2		; SDL_Rect
 .my_color:		resd	1		; SDL_Color
endstruc

struc		s_functions
 .numero:		resd	1
 .function:		resd	1
endstruc

struc		SDL_Surface
 .flags:		resd	1
 .format:		resd	1
 .w:			resd	1
 .h:			resd	1
 .pitch:		resw	1
 .pixels:		resd	1
 .offset:		resd	1
 .hwdata:		resd	1
 .clip_rect:		resd	2
 .unused1:		resd	1
 .locked:		resd	1
 .map:			resd	1
 .format_version:	resd	1
 .refcount:		resd	1
endstruc

struc		SDL_Rect
 .x:			resw	1
 .y:			resw	1
 .w:			resw	1
 .h:			resw	1
endstruc

struc		SDL_Color
 .r:			resb	1
 .g:			resb	1
 .b:			resb	1
 .unused:		resb	1
endstruc

extern printf
extern atoi

 %define SIZE_S_COREWAR		(48)
 %define SIZE_S_CHAMPIONS	(52)
 %define MALLOC_FAILED		'error: malloc failed !', 10, 0

 %define MAX_PC			(15000)
 %define WIN_X			(1345)
 %define WIN_Y			(800)
 %define MEM_SIZE		(6 * 1024)
 %define CYCLE_TO_DIE		(1536)
 %define CYCLE_DELTA		(5)
 %define NBR_LIVE		(40)
 %define COREWAR_EXEC_MAGIC	(0xea83f3)
 %define PROG_NAME_LENGTH	(128)
 %define COMMENT_LENGTH		(2048)
 %define REG_NUMBER		(16)
 %define IDX_MOD		(512)

 %define O_RDONLY		(0)
 %define SEEK_SET		(0)
 %define SDL_INIT_VIDEO		(32)
 %define SDL_HWSURFACE		(1)
 %define SDL_BlitSurface	SDL_UpperBlit

 %define LIVE			(1)
 %define LD			(2)
 %define ST			(3)
 %define ADD			(4)
 %define SUB			(5)
 %define AND			(6)
 %define OR			(7)
 %define XOR			(8)
 %define ZJMP			(9)
 %define LDI			(10)
 %define STI			(11)
 %define FORK			(12)
 %define LLD			(13)
 %define LLDI			(14)
 %define LFORK			(15)
 %define AFF			(16)

 %define SEPARATOR_CHAR		(',')
 %define DIRECT_CHAR		('%')

%endif
