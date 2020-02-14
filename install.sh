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

download_to_file() {
	curl -LO "$@" || wget "$@" || die "Downloading $@ failed"
}

install_package() {
	if [ ! -f "piu" ]; then
		download_to_file "https://raw.githubusercontent.com/keithieopia/piu/master/piu" >/dev/null && \
		chmod u+x piu
	fi

	./piu install "$@"
}

git_pull_or_clone() {
	if git -C "$2" config --get remote.origin.url 2>/dev/null | grep -q "$3"; then
		args="-C $2 pull --autostash --ff-only --depth=1"
		if [ -n "$4" ]; then
			args="$args origin $4"
		fi

	else
		args="clone $1 $2 --depth=1"
		if [ -n "$4" ]; then
			args="$args --branch=$4"
		fi
	fi

	git $args
}


tmpdir="$(mktemp -d)"
cd "$tmpdir"

cleanup() {
	if [ -n "$tmpdir" ]; then
		rm -rf "$tmpdir"
	fi
}

trap cleanup EXIT


info "Installing prerequisite packages..."
if ! [ -x "$(command -v git)" ]; then
	install_package "git" || die "Installing git failed"
fi

if ! [ -x "$(command -v nvim)" ]; then
	if ! install_package "neovim"; then
		if "$(uname)" | grep -q Linux; then
			download_to_file "https://github.com/neovim/neovim/releases/download/stable/nvim.appimage"
			chmod u+x nvim.appimage
			sudo mkdir -p /usr/local
			sudo mv nvim.appimage /usr/local/nvim
		else
			die "Installing neovim failed"
		fi
	fi
fi


info "Downloading speedcola..."
if [ -x "$(command -v nvim)" ]; then
	config_dir="$(command nvim --headless --cmd 'echo split(&rtp, ",")[0] | q' 2>&1)"
else
	die "Could not find neovim"
fi

git_pull_or_clone \
	"https://github.com/mwilliammyers/speedcola.git" \
	"$config_dir" \
	"mwilliammyers/speedcola" \
	"${SPEEDCOLA_BRANCH:-master}" \
		|| die "Downloading speedcola failed"


info "Installing (neo)vim packages; this may take a while..."
# XXX: cannot call `+quit` at the end; `PackBootstrap` handles quitting vim...
command nvim --headless -u NONE +'set cmdheight=99' +'runtime packages.vim' +'PackBootstrap'

