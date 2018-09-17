#!/bin/sh

repo="mwilliammyers/speedcola"


info() {
	printf "$(tput bold)${@}$(tput sgr0)\n"
}

warn() {
	printf "$(tput setaf 3)${@}$(tput sgr0)\n"
}

error() {
	>&2 printf "$(tput bold)$(tput setaf 1)${@}$(tput sgr0)\n"
}


die() {
	rc="${?}"
	error "${@}"
	exit "${rc}"
}

# TODO: update first, only if we haven't already
package_install() {
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

# TODO: make this smarter
package_exists() {
	if [ -x "$(command -v apt-cache)" ]; then
		sudo apt-cache show "${@}" 2>/dev/null >/dev/null
	else
		return 0
	fi
}

add_apt_repository() {
	if ! [ -x "$(command -v add-apt-repository)" ]; then
		sudo apt-get install -y software-properties-common
	fi
	sudo add-apt-repository -y "${@}"
}


git_pull_or_clone() {
	# git < v2.9.0 do not have the --jobs flag
	git -C "${2}" config --get remote.origin.url 2>/dev/null | grep -q "${repo}"
	if [ "${?}" -eq 0 ]; then
		git -C "${2}" pull --ff-only --depth=1
		git -C "${2}" submodule update --depth=1 --remote --init --checkout
	else
		git clone "${1}" "${2}" --depth=1 --recursive
	fi
}

info "Installing prerequisite packages..."
if ! [ -x "$(command -v git)" ]; then
	package_install "git" || die "Installing git failed"
fi

if ! [ -x "$(command -v vim)" ]; then
	if ! [ -x "$(command -v nvim)" ]; then
		package_install "vim" || die "Installing vim failed"
	fi
fi

if ! [ -x "$(command -v rg)" ]; then
	package_exists "ripgrep" || add_apt_repository "ppa:x4121/ripgrep"
	package_install "ripgrep" \
		|| warn 'Could not install optional `ripgrep` package'
fi

if ! [ -x "$(command -v ctags)" ]; then
	package_exists "universal-ctags" || add_apt_repository "ppa:hnakamur/universal-ctags"
	package_install "universal-ctags" \
		|| warn 'Could not install optional `universal-ctags` package'
fi

# TODO: this assumes nvim provides vim...
config_dir="${1}"
[ -z "${config_dir}" ] && config_dir="$(vim -Esc 'verbose echo split(&rtp, ",")[0] | q' 2>&1)"
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
