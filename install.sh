#!/usr/bin/env sh

repo="mwilliammyers/speedcola"


info() {
	printf "$(tput bold)${@}$(tput sgr0)\n"
}

error() {
	>&2 printf "$(tput bold)$(tput setaf 1)${@}$(tput sgr0)\n"
}


fail() {
	rc="${?}"
	error "${@}"
	exit "${rc}"
}

system_package() {
	if [ -x "$(command -v apt-get)" ]; then
		sudo apt-get install -y "${@}"	
	elif [ -x "$(command -v brew)" ]; then
	 	brew install "${@}"
	elif [ -x "$(command -v pacman)" ]; then
		sudo pacman -S "${@}"
	elif [ -x "$(command -v dnf)" ]; then
		dnf -y "${@}"
	elif [ -x "$(command -v zypper)" ]; then
		sudo zypper in "${@}"
	elif [ -x "$(command -v port)" ]; then
		sudo port selfupdate
		sudo port install "${@}"
	else
		return 1
	fi
}

git_pull_or_clone() {
	cd "${2}" 2> /dev/null \
		&& git config --get remote.origin.url | grep -v "${repo}" \
		&& git pull --rebase --autostash --depth=1 \
		&& return
	git clone "${1}" "${2}" --depth=1
}

info "Installing prerequisite packages..."
system_package "git" "neovim" || fail "Installing prerequisite packages failed"

data_dir="$(nvim --headless -u NONE -c 'echo stdpath("data")' -c q 2>&1)"
info "Installing minpac..."
git_pull_or_clone \
	https://github.com/k-takata/minpac.git \
	"${data_dir}/site/pack/minpac/opt/minpac" \
	|| fail "Installing minpac failed"

config_dir="$(nvim --headless -u NONE -c 'echo stdpath("config")' -c q 2>&1)"
info "Downloading neovim configuration..."
git_pull_or_clone \
	"https://github.com/${repo}.git" \
	"${config_dir}" \
	|| fail "Downloading neovim configuration failed"

info "Installing plugins (this may take a few minutes)..."
nvim --headless -u NONE \
	-c 'packadd minpac' \
	-c 'runtime packages.vim' \
	-c "call minpac#update('', {'do': 'quit'})" \
	|| fail "Configuring neovim failed"
