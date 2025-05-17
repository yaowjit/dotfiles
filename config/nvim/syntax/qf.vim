if exists('b:current_syntax')
    finish
endif

syntax clear
" fname|lnum:col|message
syntax clear
syntax match qfFileName       /^[^|]*/ nextgroup=qfSeparatorLeft             skipwhite
syntax match qfSeparatorLeft  /|/      nextgroup=qfLineNr,qfSeparatorRight   contained skipwhite
syntax match qfLineNr         /\d\+/   nextgroup=col                         contained skipwhite
syntax match col              /\:/     nextgroup=qfColNr                     contained skipwhite
syntax match qfColNr          /\d\+/   nextgroup=qfSeparatorRight            contained skipwhite
syntax match qfSeparatorRight /|/      nextgroup=qfError,qfWarning,qfInfo,qfNote,qfMessage, contained skipwhite
syntax match qfMessage        /.*$/    contained

syntax match qfError /ERROR.*$/ contained
syntax match qfWarning /WARN.*$/ contained
syntax match qfInfo /INFO.*$/ contained
syntax match qfNote /NOTE.*$/ contained

hi def link qfFileName       Directory
hi def link qfSeparatorLeft  Operator
hi def link qfLineNr         LineNr
hi def link col              Operator
hi def link qfColNr          LineNr
hi def link qfSeparatorRight Operator

hi def link qfError          DiagnosticError
hi def link qfWarning        DiagnosticWarn
hi def link qfInfo           DiagnosticInfo
hi def link qfNote           DiagnosticHint
hi def link qfMessage        String

let b:current_syntax = 'qf'
