Corewar ASM x86
=====

![Alt text](img/corewar.png?raw=true "Corewar ASM")

Tested with Fedora 20 x86_64.  
I needed to install some librairies:  

`# yum install glibc.i686 ncurses-libs.i686 libstdc libzip.i686 libX11.i686 libXrandr.i686 SDL.i686 SDL_ttf.i686`
  
Command line:   
`$ ./corewar champions/42.cor champions.try_again.cor`  
  
To dissasemble champions:   
`$ ./corewar -d champions/42.cor`

A man page is also available:   
`$ man ./corewar.man  `
