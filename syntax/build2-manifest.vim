" Vim syntax file
" Language: Build2 manifest
" Maintainer: b8u
" Latest Revision: 21 March 2023
"
" File type specification:
" https://build2.org/bpkg/doc/build2-package-manager-manual.xhtml#manifest-format

if exists("b:current_syntax")
	finish
endif


let s:name_value = "[^:\s\r\n]"

" Version number needs a huge regex (and it's currently wrong).
" Examples:
"   0+1
"   +0-20180112
"   1.2.3
"   1.2.3-a1
"   1.2.3-b2
"   1.2.3-rc1
"   1.2.3-alpha1
"   1.2.3-alpha.1
"   1.2.3-beta.1
"   1.2.3+1
"   +2-1.2.3
"   +2-1.2.3-alpha.1+3
"   +2.2.3#1
"   1.2.3+1#1
"   +2-1.2.3+1#2

" Like: 1.2.3
let s:version_digits = "\\d\\+\\.\\d\\+\\.\\d\\+"
" Like: alpha1
let s:version_digits_suffix_item = "[\\d\\a-]\\+"
let s:version_digits_optional_sufix_minus = "\\%(-\\%(".s:version_digits_suffix_item."\\)\\+\\%(\\.".s:version_digits_suffix_item."\\)*\\)\\?"
let s:version_digits_optional_sufix_plus  = "\\%(+\\%(".s:version_digits_suffix_item."\\)\\+\\%(\\.".s:version_digits_suffix_item."\\)*\\)\\?"
let s:version_value = "\\%(" . s:version_digits . s:version_digits_optional_sufix_minus . "\\)" . s:version_digits_optional_sufix_plus

" Allowed names (before ':')
syn match build2ManifestKeyword "^\s*\%(name\|version\|project\|priority\|summary\|license\|topics\|keywords\|description\|description-file\|description-type\|changes\|changes-file\|url\|doc-url\|src-url\|package-url\|email\|package-email\|build-email\|build-warning-email\|build-error-email\|depends\|requires\|tests\|examples\|benchmarks\|builds\|build-include\|build-exclude\|build-file\)\s*:"


" TODO: after \ it's not a comment
syn match build2ManifestComment "^\s*#.*$"
syn match build2ManifestFormatVersion "^\s*:\s*\d*\s*$"

echom s:version_value

execute 'syn match build2ManifestVersion '.string(s:version_value)

hi def link build2ManifestComment       Comment
hi def link build2ManifestFormatVersion	PreProc
hi def link build2ManifestVersion       Identifier
hi def link build2ManifestKeyword       Keyword
