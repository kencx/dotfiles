function get_latest_release {
	curl -s "https://api.github.com/repos/$1/releases/latest" |
	grep '"tag_name":' |
	sed -E 's/.*"([^"]+)".*/\1/'
}

function download {
	RELEASE=$(get_latest_release $1)
	curl -s https://api.github.com/repos/$1/releases/latest | \
	grep "browser_download_url" | \
	cut -d '"' -f4 | \
	wget -qi -
}

function download_linux_amd64 {
	curl -s https://api.github.com/repos/$1/releases/latest | \
	grep "browser_download_url.*linux.*amd64" | \
	cut -d '"' -f4 | \
	wget -qi -
}
