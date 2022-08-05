# meh. Dark Blood Rewind, a new beginning.
# modified from the original Oh-My-Zsh theme "darkblood.zsh-theme"

PROMPT=$'%{$fg[red]%}[%{$fg_bold[green]%}%n%{$reset_color%}%{$fg[green]%}@%{$fg_bold[green]%}%m%{$reset_color%}%{$fg[red]%}][%{$fg_bold[blue]%}%~%{$reset_color%}%{$fg[red]%}]%{$(git_prompt_info)%}%(?,,%{$fg[red]%}[%{$fg_bold[white]%}%?%{$reset_color%}%{$fg[red]%}])
%{$fg[red]%}%{%G$%}%{$reset_color%} '
PS2=$'%{$fg[red]%}>%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}[%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[red]%}]"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}⚡%{$reset_color%}"
