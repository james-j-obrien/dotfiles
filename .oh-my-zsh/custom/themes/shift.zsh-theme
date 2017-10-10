PCHAR="%#"

ZSH_TIME_THRESHOLD=1.0


# Before executing command store current time
function preexec() {
	last_start_time=$EPOCHREALTIME
	last_command=$1
}

# After executing command store time elapsed and exit code 
function precmd() {
	exit_status=$?
	
	if [[ $last_start_time != 'invalid' ]]; then
		last_status=$exit_status
		last_run_time=$((EPOCHREALTIME - last_start_time))
		
		last_start_time='invalid'
		last_command=""	
	fi
}

# Convert time to human readable from epoch
function time_to_human() {
	seconds=$1
	if (( seconds < 10 )); then
		printf "%4.1fs" $seconds
	elif (( seconds < 60 )); then
		printf "%4.1fs" $seconds
	elif (( seconds < (60*60) )); then
		printf "%4.1fm" $(( seconds / 60 ))
	elif (( seconds < (60*60*24) )); then
		printf "%4.1fh" $(( seconds / (60*60) ))
	elif (( seconds < (60*60*24*100) )); then
		printf "%4.1fd" $(( seconds / (60*60*24) ))
	fi
}

# Get prefixes based on return code
function check_return_code() {
	if [[ last_status -ne 0 ]]; then
		echo "%{$fg_bold[red]%}"
	else
		echo "%{$fg[yellow]%}"
	fi
}

# Assemble full command runtime status
function command_time() {
	if (( last_run_time >= ZSH_TIME_THRESHOLD )); then
		echo -n "$TIME_PREFIX"
		echo -n "$(check_return_code)"
		time_to_human $last_run_time
		echo -n "%{$reset_color%}"
		echo -n "$TIME_SUFFIX"
	fi
}

# Get ssh info
function ssh_info() {
	if [ -n "$SSH_CONNECTION" ]; then
		echo -n " %{$fg_bold[black]%}%n@%M%{$reset_color%}"
	else
		echo -n ""
	fi
}

# Get leading character
function get_lead_char() {
	if [ -n "$SSH_CONNECTION" ]; then
		echo -n ": "	
	else
		echo -n "> "
	fi
}

TIME_PREFIX=" "
TIME_SUFFIX=""

DARK=%{$fg_bold[green]%}
LIGHT=%{$fg_bold[cyan]%}
RESET=%{$reset_color%}

RPROMPT='$(command_time)$(git_prompt_info)$(ssh_info)'

PROMPT='$DARK$(get_lead_char)[$LIGHT%2~$DARK] $PCHAR$RESET '

#PROMPT='$DAR$(get_lead_char)[%{$fg[cyan]%}%2~%{$fg_bold[green]%}] $PCHAR%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$reset_color%}:%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}:%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}"
