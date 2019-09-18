#!/bin/sh

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
		# TODO: this might fail when installing multiple things
		env HOMEBREW_NO_ANALYTICS=1 HOMEBREW_NO_GITHUB_API=1 \
		brew install "${@}" 2>&1 | grep -q "head-only formula" \
			&& brew install --HEAD "${@}"
    elif [ -x "$(command -v pacman)" ]; then
        sudo pacman -Syu "${@}"
    elif [ -x "$(command -v dnf)" ]; then
        sudo dnf -y "${@}"
    elif [ -x "$(command -v yum)" ]; then
        sudo yum -y "${@}"
    elif [ -x "$(command -v zypper)" ]; then
        sudo zypper install "${@}"
    elif [ -x "$(command -v pkg)" ]; then
        sudo pkg install "${@}"
    elif [ -x "$(command -v pkg_add)" ]; then
        pkg_add "${@}"
    elif [ -x "$(command -v port)" ]; then
        sudo port install "${@}"
    elif [ -x "$(command -v emerge)" ]; then
        emerge "${@}"
    elif [ -x "$(command -v pkgin)" ]; then
        pkgin -y install "${@}"
    elif [ -x "$(command -v nix-env)" ]; then
        nix-env -i "${@}"
    else
        return 1
    fi
}

# TODO: make this smarter
package_exists() {
	if [ -x "$(command -v apt-cache)" ]; then
		sudo apt-cache show "${@}" 2>/dev/null >/dev/null
	elif [ -x "$(command -v brew)" ]; then
		# we don't need this info and it is faster without it
		env HOMEBREW_NO_ANALYTICS=1 HOMEBREW_NO_GITHUB_API=1 \
			brew info "${@}" 2>/dev/null >/dev/null
	else
		return 0
	fi
}

try_add_apt_repository() {
	if grep -q "ID=ubuntu" /etc/os-release 2>/dev/null; then
		if ! [ -x "$(command -v add-apt-repository)" ]; then
			sudo apt-get install -y software-properties-common
		fi
		sudo add-apt-repository -y "${@}"
		sudo apt-get update
		return 0
	fi

	return 1
}

git_pull_or_clone() {
	if git -C "${2}" config --get remote.origin.url 2>/dev/null | grep -q "${3}"; then
		git -C "${2}" pull --autostash --ff-only --depth=1
	else
		git clone "${1}" "${2}" --depth=1
	fi
}

info "Installing prerequisite packages..."
if ! [ -x "$(command -v git)" ]; then
	package_install "git" || die "Installing git failed"
fi

if ! [ -x "$(command -v nvim)" ]; then
	if ! [ -x "$(command -v vim)" ]; then
		package_exists "neovim" || try_add_apt_repository "ppa:neovim-ppa/stable"
		package_install "neovim" || die "Installing neovim failed"
	fi
fi

if ! [ -x "$(command -v rg)" ]; then
	package_exists "ripgrep" || try_add_apt_repository "ppa:x4121/ripgrep"
	package_install "ripgrep" \
		|| warn 'Could not install optional `ripgrep` package'
fi


info "Downloading speedcola..."
program="${1:-nvim}"
use_neovim=true

if echo $program | grep -qi "nvim" && [ -x "$(command -v nvim)" ]; then
	config_dir="$(command nvim --headless --cmd 'echo split(&rtp, ",")[0] | q' 2>&1)"
# TODO: figure out how to handle `update-alternatives`...
elif echo $program | grep -qi "vim" && command vim --version | grep -q 'Vi IMproved'; then
	# TODO: assume path starts with `/`? how to remove junk characters?!
	config_dir="$(command vim -T dumb --not-a-term --cmd 'echo split(&rtp, ",")[0] | q' 2>&1 | egrep -o '/.*' | tr -d '[:cntrl:]')"
	use_neovim=false
else
	die "Could not find vim or neovim"
fi

git_pull_or_clone \
	"https://github.com/mwilliammyers/speedcola.git" \
	"${config_dir}" \
	"mwilliammyers/speedcola" \
		|| die "Downloading speedcola failed"


info "\nInstalling minpac--(neo)vim package manager..."
# TODO: assume packpath lives under runtimepath?
git_pull_or_clone \
	"https://github.com/k-takata/minpac.git" \
	"${config_dir}/pack/minpac/opt/minpac" \
	"k-takata/minpac" \
		|| die "Installing minpac failed"


info "\nInstalling (neo)vim packages; this may take a while..."
# XXX: cannot call `+quit` at the end; `PackBootstrap` handles quitting vim...
if [ "$use_neovim" = true ]; then
	command nvim --headless -u NONE +'set cmdheight=99' +'runtime packages.vim' +'PackBootstrap'
else
	command vim -T dumb --not-a-term -u NONE +'set cmdheight=4' +'runtime packages.vim' +'PackBootstrap'
fi

