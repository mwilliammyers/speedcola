#!/bin/sh

repo="mwilliammyers/speedcola"


info() {
	printf "$(tput bold)${@}$(tput sgr0)\n"
}

error() {
	>&2 printf "$(tput bold)$(tput setaf 1)${@}$(tput sgr0)\n"
}


die() {
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
		&& git config --get remote.origin.url | grep -q "${repo}" \
		&& git pull --ff-only --depth=1 \
		&& return
	# git < v2.9.0 do not have the --jobs flag
	git clone "${1}" "${2}" --depth=1 --recursive --jobs=0 2>/dev/null \
		|| git clone "${1}" "${2}" --depth=1 --recursive
}

info "Installing prerequisite packages..."
if ! [ -x "$(command -v git)" ]; then
	system_package "git" || die "Installing git failed"
fi

if ! [ -x "$(command -v vim)" ]; then
	if ! [ -x "$(command -v nvim)" ]; then
		system_package "vim" || die "Installing vim failed"
	fi
fi

# TODO: this assumes nvim provides vim...
config_dir="$(vim -Esc 'verbose echo split(&rtp, ",")[0] | q' 2>&1)"
info "Downloading speedcola..."
git_pull_or_clone \
	"https://github.com/${repo}.git" \
	"${config_dir}" \
	|| die "Downloading speedcola failed"

# TODO: detect if we need sudo...
if [ -x "$(command -v pip3)" ]; then
	info "Installing Python Language Server..."
	sudo -H pip3 install -U 'python-language-server[all]' pyls-mypy pyls-isort
fi

# TODO: detect if we need sudo...
if [ -x "$(command -v npm)" ]; then
	info "Installing Javascript/Typescript Language Servers..."
	sudo -H npm -g install javascript-typescript-langserver
fi

if [ -x "$(command -v rustup)" ]; then
	info "Installing Rust Language Server..."
	rustup update
	rustup component add rls-preview rust-analysis rust-src
fi
