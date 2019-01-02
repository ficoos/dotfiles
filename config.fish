function hg_branch
	hg branch ^ /dev/null | awk '{print $1}'
end

function __scm_prompt
	set gitps (__fish_git_prompt | string trim -c '() ')
	set hgps (hg_branch)
	if test -n "$gitps"
		echo " (git:$gitps)";
	else if test -n "$hgps"
		echo " (hg:$hgps)"
	else
		echo ""
	end
end

function fish_prompt
    echo -e "\033[32m["(date +%T)"]\033[0m "(whoami)"\033[38;5;8m@\033[38;5;7m"(hostname) "\033[36m"(pwd)"\033[35m"(__scm_prompt)"\033[0m\n\$ "(tput sgr0)
end

function fish_greeting
	fortune | cowsay
end

function vim
	nvim $argv
end

function viconf
	 nvim ~/.config/nvim/init.vim
end

function pfzf
	pass fzf $argv
end


set --export PATH $PATH $HOME/.bin
set --export PATH "$HOME/.cargo/bin" $PATH
set --export PATH "$HOME/go/bin" $PATH
set --export PASSWORD_STORE_ENABLE_EXTENSIONS true

set EDITOR nvim
