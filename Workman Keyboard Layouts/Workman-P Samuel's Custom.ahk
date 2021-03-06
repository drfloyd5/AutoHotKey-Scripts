#Persistent
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#NoEnv

#MaxHotkeysPerInterval 300

SetTitleMatchMode 3  ; Exact matching to avoid confusing T/B with Tab/Backspace.

;q::q
w::d
e::r
r::w
t::b
y::j
u::f
i::u
o::p

                    ; samuel's mods
$+p::send, [        ; P => [
$p::{              ; p => {

${::send, ]         ; { => ]
$[::send, {}}       ; ] => }

$]::'               ; ] => '
$}::"               ; } => "


;\::\

;a::a
;s::s
d::h
f::t
;g::g
h::y
j::n
k::e
l::o


SC027::i            ; ; => i  (SC027 is semicolon)
$^'::send, `;       ; ^' => ;
$'::send, {end}`;   ; ; => ; at end of line
$"::send, :         ; " => :

;z::z
;x::x
c::m
v::c
b::v
n::k
m::l
;,::,
;.::.
;/::/

;$`::send, ~
;$1::send, {!}
;$2::send, @
;$3::send, {#}
;$4::send, $
;$5::send, `%
;$6::send, {^}
;$7::send, &
;$8::send, *
;$9::send, (
;$0::send, )



;$'::send, "
;$/::send, ?

;$~::send, ``
;$!::send, 1
;$@::send, 2
;$#::send, 3
;$$::send, 4
;$%::send, 5
;$^::send, 6
;$&::send, 7
;$*::send, 8
;$(::send, 9
;$)::send, 0

;$"::send, '
;$?::send,

;BackSpace::send, {Delete}

#Include, %A_ScriptDir%\..\Utility\Utilities.ahk