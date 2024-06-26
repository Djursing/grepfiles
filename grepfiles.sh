#! /bin/bash
set -euo pipefail

Help() {
    echo
    echo "Usage: $0 < file.txt"
    echo
    echo "Searches text from stdin and prints out all files found sorted."
    echo "Duplicates are kept to ensure flexibility."
    echo
    echo "Examples:"
    echo "  $0 < file.txt | uniq -c # Print occurrence of each file from given input"
    echo
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check necessary commands exists on system before proceeding
if ! command_exists grep || ! command_exists sort; then
    echo "Error: Required commands are not installed. Please make sure 'grep' and 'sort' are available." >&2
    exit 1
fi

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -h|--help)
            Help
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            Help
            exit 1
            ;;
    esac
done

extensions='7z|a|apk|ar|bz2|cab|cpio|deb|dmg|egg|gz|iso|jar|lha|mar|pea|rar|rpm|s7z|shar|tar|tbz2|tgz|tlz|war|whl|xpi|zip|zipx|xz|pak|aac|aiff|ape|au|flac|gsm|it|m3u|m4a|mid|mod|mp3|mpa|pls|ra|s3m|sid|wav|wma|xm|mobi|epub|azw1|azw3|azw4|azw6|azw|cbr|cbz|1ada|2ada|ada|adb|ads|asm|bas|bash|bat|c|c\+\+|cbl|cc|class|clj|cob|cpp|cs|csh|cxx|d|diff|e|el|f|f77|f90|fish|for|fth|ftn|go|groovy|h|hh|hpp|hs|html|htm|hxx|java|js|jsx|jsp|ksh|kt|lhs|lisp|lua|m|m4|nim|patch|php|pl|po|pp|py|r|rb|rs|s|scala|sh|swg|swift|v|vb|vcxproj|xcodeproj|xml|zsh|exe|msi|bin|command|sh|bat|crx|bash|csh|fish|ksh|zsh|eot|otf|ttf|woff|woff2|3dm|3ds|max|bmp|dds|gif|jpg|jpeg|png|psd|xcf|tga|thm|tif|tiff|yuv|ai|eps|ps|svg|dwg|dxf|gpx|kml|kmz|webp|ods|xls|xlsx|csv|ics|vcf|ppt|odp|doc|docx|ebook|log|md|msg|odt|org|pages|pdf|rtf|rst|tex|txt|wpd|wps|3g2|3gp|aaf|asf|avchd|avi|drc|flv|m2v|m4p|m4v|mkv|mng|mov|mp2|mp4|mpe|mpeg|mpg|mpv|mxf|nsv|ogg|ogv|ogm|qt|rm|rmvb|roq|srt|svi|vob|webm|wmv|yuv|html|htm|css|js|jsx|less|scss|wasm|php'
regstr="\b(?:[\w.-]+\/)*[\w.-]+\.{1}(?:${extensions})(?=\s|,|$)"

grep -P -o "${regstr}" | sort