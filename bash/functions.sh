projcd() {
    local dir
    dir=$(
        find ~/projects -mindepth 1 -maxdepth 1 -type d \
        | sort \
        | fzf \
            --preview 'eza --tree --level=2 --icons --color=always --git {}' \
            --preview-window=right:60%
    ) || return
    cd "$dir"
}
