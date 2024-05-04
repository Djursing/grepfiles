# grepfiles
Searches text from stdin and prints out all files with supported file extension in DESC sorted order.\
Duplicates are kept to ensure flexibility

<details>
<summary>List of supported file extensions</summary>

- **Archives:** 7z, a, apk, ar, bz2, cab, cpio, deb, dmg, egg, gz, iso, jar, lha, mar, pea, rar, rpm, s7z, shar, tar, tbz2, tgz, tlz, war, whl, xpi, zip, zipx, xz, pak
- **Books and Documents:** mobi, epub, azw1, azw3, azw4, azw6, azw, cbr, cbz, pdf, ebook, doc, docx, odt, org, txt, rtf, md, tex, log, msg, wpd, wps, pages, ppt, odp, xls, xlsx, csv, ics, vcf
- **Programming and Scripting:** 1ada, 2ada, ada, adb, ads, asm, bas, bash, bat, c, c++, cbl, cc, class, clj, cob, cpp, cs, csh, cxx, d, diff, e, el, f, f77, f90, fish, for, fth, ftn, go, groovy, h, hh, hpp, hs, java, js, jsx, jsp, ksh, kt, lhs, lisp, lua, m, m4, nim, patch, php, pl, po, pp, py, r, rb, rs, s, scala, sh, swg, swift, v, vb, vcxproj, xcodeproj, xml, zsh
- **Executable:** exe, msi, bin, command, sh, bat, crx, bash, csh, fish, ksh, zsh
- **Fonts:** eot, otf, ttf, woff, woff2
- **Images and Graphics:** 3dm, 3ds, max, bmp, dds, gif, jpg, jpeg, png, psd, xcf, tga, thm, tif, tiff, yuv, ai, eps, ps, svg, dwg, dxf, gpx, kml, kmz, webp
- **Video and Animation:** 3g2, 3gp, aaf, asf, avchd, avi, drc, flv, m2v, m4p, m4v, mkv, mng, mov, mp2, mp4, mpe, mpeg, mpg, mpv, mxf, nsv, ogg, ogv, ogm, qt, rm, rmvb, roq, srt, svi, vob, webm, wmv, yuv
- **Web:** html, htm, css, js, jsx, less, scss, wasm, php
</details>

## Prerequisites
Before running this script, ensure you have `grep` and `sort` installed on your system, as it relies on these utilities:

```bash
grep --version
sort --version
```


## Installation
No formal installation is required. Simply download the script and set it as executable:\
That being said. Never trust scripts blindly.\
Give the source code a look before running :)

#### Cloning
```bash
git clone git@github.com:Djursing/grepfiles.git
```

#### Make script executable
```bash
chmod +x grepfiles.sh
```

#### Move to local bin folder
```bash
mv grepfiles/.grepfiles.sh /usr/local/bin/grepfiles
```

#### PATH
Make sure your path includes `/usr/local/bin`.\
Here are some ways to do it with `.profile` and `.bashrc`.
```bash
# ~/.profile
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# ~/.bashrc
export PATH=$PATH:/usr/local/bin
```


## Usage

To use the script, you can either pipe input into it or redirect input from a file:

```bash 
# Piping input from another command
cat file.txt | grepfiles

# Redirecting input from a file
grepfiles < file.txt
```

## Help Options

You can access the help menu by passing the -h or --help option:
```bash
grepfiles -h
```

## Practical Example

### Input from a file
To find and sort all referenced files in a document and count each occurrence, you can chain commands like this:

#### Contents of file.txt
```bash
asdfasdf somefile.c++,asdfasfd Users/worksapacesdf/somethin.go  asdf asoijojweiofjwf owfnmsodkf nsak;fnkwenf wsomething.1.ada sadfasdfsdafsadfsdafasdfonewoifnweoi
aaaa.gaaaa.goo aaaa.go aaaa.go aaaa.go Users/worksapacesdf/somethin.go Users/worksapacesdf/somethin.go aaaa.go
```

#### Command
```bash
grepfiles < file.txt | uniq -c | sort -nr
```

#### Output
```bash
4 aaaa.go
3 Users/worksapacesdf/somethin.go
1 wsomething.1.ada
1 somefile.c++
```

### Find files from git commits
This script idea initially came from my other projected called [hotspot](https://github.com/Djursing/hotspot), which returns number of occurrences of files in git commits with a commit desctiption matching a specific regex string.
It did a decent job at bringing attention to files often occurring in bugfixes, but it was limited to git logs only. 

#### Command
```bash
git log -E --grep 'chore|fix' --name-only --since '1 year' | grepfiles | uniq -c | sort -nr
```

#### Output
```bash
4 README.md
3 example.png
2 investigator.sh
1 LICENSE.txt
1 fixfinder.sh
```
