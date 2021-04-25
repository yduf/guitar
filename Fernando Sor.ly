#(define RH rightHandFinger)

%{
#(define (tie::tab-clear-tied-fret-numbers grob)
   (let* ((tied-fret-nr (ly:spanner-bound grob RIGHT)))
      (ly:grob-set-property! tied-fret-nr 'transparent #t)))
%}

\version "2.22.0"
\paper {
   indent = #0
   print-all-headers = ##t
   print-all-headers = ##t
   ragged-right = ##f
   ragged-bottom = ##t
}

\layout {
   % Set global properties of fret diagram
    %\override TextScript.size = #'1.2
   \override TextScript.fret-diagram-details.finger-code = #'below-string
   \override TextScript.fret-diagram-details.barre-type = #'straight

   \context { \Score
      %%\override MetronomeMark.padding = #'5
      
   }
   \context { \Staff
      %%\override TimeSignature.style = #'numbered
      \override StringNumber.transparent = ##t
   }
   \context { \TabStaff
      %% \override TimeSignature.style = #'numbered
      %% \override Stem.transparent = ##t
      %% \override Beam.transparent = ##t
      %% \override Tie.after-line-breaking = #tie::tab-clear-tied-fret-numbers
   }
   \context { \TabVoice
      %%\override Tie.stencil = ##f
   }
   \context { \StaffGroup
      %%\consists "Instrument_name_engraver"

   }
}

%{
deadNote = #(define-music-function (note) (ly:music?)
   (set! (ly:music-property note 'tweaks)
      (acons 'stencil ly:note-head::print
         (acons 'glyph-name "2cross"
            (acons 'style 'special
               (ly:music-property note 'tweaks)))))
   note)

palmMute = #(define-music-function (note) (ly:music?)
   (set! (ly:music-property note 'tweaks)
      (acons 'style 'do (ly:music-property note 'tweaks)))
   note)
%}

TrackAVoiceAMusic = #(define-music-function (inTab) (boolean?)
#{
   \tempo 4=93
   \clef #(if inTab "moderntab" "treble_8")
   \key c \major
   \time 4/4
   \oneVoice
   %{ 1 %}
   <d'\2 \RH #3 b,\5 \RH #1 >8-\tag #'chords ^\markup  \fret-diagram-terse "x;2-1-(;4-3;4-4;3-2;2-1-);" 
   <b\3   \RH #2 >8 
   <fis\4 \RH #1 >8  
   <b\3   \RH #2 >8 

   %{ 1.5 %}
   <d'\2    \RH #3 >8 
   <b\3     \RH #2 >8 
   <fis'\1  \RH #4 >8 
   <d'\2    \RH #3 >8

   %{ 2 %}
   <fis\4  \RH #1 >8 
   <d'\2   \RH #2 >8 
   <fis'\1 \RH #3 >8 
   <d'\2   \RH #2 >8 
   
   %{ 2.5 %}
   <e'\1  \RH #3 >8-\tag #'chords ^\markup 
   % \fret-diagram "1-x;2-2;3-x;4-4;5-x;6-x;"
   \fret-diagram-terse "x;x;4-3;4-4;2-1;o;" 
   <cis'\2 \RH #2 >8 
   <fis\4  \RH #1 >8 
   <cis'\2 \RH #2 >8 

   %{ 3 %}
   <e'\1   \RH #3 >8 
   <cis'\2 \RH #2 >8
   <d'\2   \RH #3 >8 -\tag #'chords ^\markup 
   % \fret-diagram "1-x;2-3;3-4;4-4;5-x;6-x;" 
   \fret-diagram-terse "x;x;4-3;4-4;3-2;o;"  
   <b\3    \RH #2 >8

   %{ 3.5 %}
   <fis\4 \RH #1 >8 
   <b\3 \RH #2 >8 
   <d'\2 \RH #3 >8 
   <b\3 \RH #2 >8
   
   %{ 4 %}
   <cis'\2>8-\tag #'chords ^\markup \fret-diagram "1-o;2-2;3-3;4-4;5-x;6-x;" <ais\3>8 <fis\4>8 <ais\3>8 <cis'\2>8 <ais\3>8 <d'\2>8-\tag #'chords ^\markup \fret-diagram "1-x;2-3;3-4;4-4;5-x;6-x;" <b\3>8 
   <fis\4>8 <b\3>8 <d'\2>8 <b\3>8 <e'\1>8 <b\2>8 <g\3>8 <b\2>8 
   <f'\1>8 <b\2>8 <fis'\1>8 <cis'\2>8 <ais\3>8 <cis'\2>8 <fis\4>8 <ais\3>8 
   \bar "|."
   \pageBreak
#})
TrackALyrics = \lyricmode {
   \set ignoreMelismata = ##t
   
   \unset ignoreMelismata
}
TrackAStaff = \new Staff <<
   \context Voice = "TrackAVoiceAMusic" {
      \TrackAVoiceAMusic ##f
   }
>>
TrackATabStaff = \new TabStaff \with { stringTunings = #`(,(ly:make-pitch 0 2 NATURAL) ,(ly:make-pitch -1 6 NATURAL) ,(ly:make-pitch -1 4 NATURAL) ,(ly:make-pitch -1 1 NATURAL) ,(ly:make-pitch -2 5 NATURAL) ,(ly:make-pitch -2 2 NATURAL) ) } <<
   \context TabVoice = "TrackAVoiceAMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackAVoiceAMusic ##t
   }
>>
TrackAStaffGroup = \new StaffGroup <<
   \chords { 
     \set chordChanges = ##t        % only display when chord change
   % 1
   b1:m | b2:m fis2:7 | fis4:7  b2:m b4:m
   % 4
   | eis2 eis4 b4:m |  b2:m
   }


   \TrackAStaff
   \TrackATabStaff
>>
\score {
   \TrackAStaffGroup
   \header {
      title = "Study In B Minor Op35 No22" 
      composer = "Fernando Sor" 
   }
}
