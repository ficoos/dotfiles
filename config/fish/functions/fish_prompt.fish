function fish_prompt --description 'Write out the prompt'
    set last_status $status
    if [ $last_status -ne 0 ]
        echo (set_color $fish_color_error)'status: '$last_status(set_color normal)
    end
    set ranger_prompt ""
    if [ -n "$RANGER_LEVEL" ]
        set ranger_prompt " {ranger}"
    end
    printf '%s%s %s@%s %s%s'(set_color normal)'\f\r$ %s' \
        (set_color $fish_color_clock)'['(date +%T)']' \
        (set_color $fish_color_ranger)"$ranger_prompt" \
        (set_color $fish_color_user)$USER(set_color --dim $fish_color_host) \
        (set_color normal)(set_color $fish_color_host)(prompt_hostname) \
        (set_color $fish_color_cwd)(prompt_pwd) \
        (set_color $fish_color_vcs)(__scm_prompt) \
        (tput sgr0)
end
