" Vim syntax file
" Language: Build2 manifest
" Maintainer: b8u
" Latest Revision: 24 March 2023
"
" File type specification:
" https://build2.org/bpkg/doc/build2-package-manager-manual.xhtml#manifest-format

" if exists("b:current_syntax")
" 	finish
" endif


let s:name_value = "[^:\s\r\n]"

" Version number needs a huge regex. It doesn't currently follow the
" documentation, but translated from a sublime-text plugin.
" More info: https://build2.org/bpkg/doc/build2-package-manager-manual.xhtml#package-version
" Like: 1.2.3
let s:version_digits = "\\d\\+\\.\\d\\+\\.\\d\\+"
" Like: alpha1
let s:version_digits_suffix_item = "[\\d\\a-]\\+"
" -<prerel>
let s:version_digits_optional_sufix_minus = "\\%(-\\%(".s:version_digits_suffix_item."\\)\\+\\%(\\.".s:version_digits_suffix_item."\\)*\\)\\?"
" +<revision>
let s:version_digits_optional_sufix_plus  = "\\%(+\\%(".s:version_digits_suffix_item."\\)\\+\\%(\\.".s:version_digits_suffix_item."\\)*\\)\\?"

let s:version_value = "\\%(" . s:version_digits . s:version_digits_optional_sufix_minus . "\\)" . s:version_digits_optional_sufix_plus
execute 'syn match build2ManifestVersion '.string(s:version_value)


syntax match build2ManifestName /^\s*[A-Za-z0-9-]\+\s*/ nextgroup=build2ManifestLine

syntax match build2ManifestLineEnd excludenl /end$/ contained
syntax match build2ManifestLineContinue "\\$" contained
syntax region build2ManifestLine start=/:/ end=/$/ contains=build2ManifestLineContinue,build2ManifestLineEnd,build2ManifestFormatVersion,build2ManifestLineComment,build2ManifestVersion  keepend
 
" " A line from '\' to the next '\' or the EOF
syntax region build2ManifestMultiline start=/^\\$/ end=/^[\\$\%$]/ contains=build2ManifestLineComment keepend

" A sandalone comment.
syn match build2ManifestComment "^\s*#.*$"
" A comment in a value line:
" Example: name: value ; comment
syn match build2ManifestLineComment /;.*$/ contained
syn match build2ManifestFormatVersion "^\s*:\s*\d*\s*$"


hi def link build2ManifestComment      Comment
hi def link build2ManifestLineComment  Comment

hi def link build2ManifestFormatVersion PreProc
hi def link build2ManifestVersion       Identifier
" hi def link build2ManifestKeyword       Keyword

hi def link build2ManifestName Keyword
" hi def link build2ManifestLine PreProc
" hi def link build2ManifestMultiline  Identifier
