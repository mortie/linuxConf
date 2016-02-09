cat .zshalias | sed 's/{//; s/}/end/' | . -

set fish_greeting ""
set fish_color_command "yellow"

function fish_prompt
	set_color --bold yellow
	echo -n (uname -n)
	echo -n ' '

	set_color --bold cyan
	echo -n (prompt_pwd)
	echo -n ' '

	set_color --bold green
	echo -n '$'
	echo -n ' '
end
