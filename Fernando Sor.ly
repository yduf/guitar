\include "predefined-guitar-fretboards.ly"

#(define (tie::tab-clear-tied-fret-numbers grob)
   (let* ((tied-fret-nr (ly:spanner-bound grob RIGHT)))
      (ly:grob-set-property! tied-fret-nr 'transparent #t)))

\version "2.20.0"
\paper {
   indent = #0
   print-all-headers = ##t
   print-all-headers = ##t
   ragged-right = ##f
   ragged-bottom = ##t
}
\layout {
   \context { \Score
      \override MetronomeMark.padding = #'5
   }
   \context { \Staff
      \override TimeSignature.style = #'numbered
      \override StringNumber.transparent = ##t
   }
   \context { \TabStaff
      \override TimeSignature.style = #'numbered
      \override Stem.transparent = ##t
      \override Beam.transparent = ##t
      \override Tie.after-line-breaking = #tie::tab-clear-tied-fret-numbers
   }
   \context { \TabVoice
      \override Tie.stencil = ##f
   }
   \context { \StaffGroup
      \consists "Instrument_name_engraver"
   }
}
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

TrackAVoiceAMusic = #(define-music-function (inTab) (boolean?)
#{
   \tempo 4=93
   \clef #(if inTab "moderntab" "treble_8")
   \key c \major
   \time 4/4
   \oneVoice
   %{ 1 %}
   <d'\2 \rightHandFinger #3 b,\5 \rightHandFinger #1 >8-\tag #'chords ^\markup \fret-diagram "1-2;2-3;3-4;4-4;5-2;6-x;"
   <b\3  \rightHandFinger #2 >8 
   <fis\4  \rightHandFinger #1 >8 
   <b\3  \rightHandFinger #2 >8 
      %{ 1.4 %}
   <d'\2  \rightHandFinger #3 >8 
   <b\3  \rightHandFinger #2 >8 
   <fis'\1  \rightHandFinger #4 >8 
   <d'\2  \rightHandFinger #3 >8

   %{ 2 %}
   <fis\4  \rightHandFinger #1 >8 <d'\2  \rightHandFinger #2 >8 <fis'\1  \rightHandFinger #3 >8 <d'\2  \rightHandFinger #2 >8 <e'\1  \rightHandFinger #3 >8-\tag #'chords ^\markup \fret-diagram "1-x;2-2;3-x;4-4;5-x;6-x;"
   <cis'\2 \rightHandFinger #2 >8 <fis\4 \rightHandFinger #1 >8 <cis'\2 \rightHandFinger #2 >8 
   %{ 3 %}
   <e'\1 \rightHandFinger #3 >8 
   <cis'\2 \rightHandFinger #2 >8-\tag #'chords ^\markup \fret-diagram "1-x;2-3;3-4;4-4;5-x;6-x;" 
   <d'\2 \rightHandFinger #3 >8 <b\3 \rightHandFinger #2 >8 
   <fis\4 \rightHandFinger #1 >8 <b\3 \rightHandFinger #2 >8 <d'\2 \rightHandFinger #3 >8 <b\3 \rightHandFinger #2 >8
   %{ 4 %}

   <cis'\2>8-\tag #'chords ^\markup \fret-diagram "1-o;2-2;3-3;4-4;5-x;6-x;" <ais\3>8 <fis\4>8 <ais\3>8 <cis'\2>8 <ais\3>8 <d'\2>8-\tag #'chords ^\markup \fret-diagram "1-x;2-3;3-4;4-4;5-x;6-x;" <b\3>8 
   <fis\4>8 <b\3>8 <d'\2>8 <b\3>8 <e'\1>8 <b\2>8 <g\3>8 <b\2>8 
   <f'\1>8 <b\2>8 <fis'\1>8 <cis'\2>8 <ais\3>8 <cis'\2>8 <fis\4>8 <ais\3>8 
   \bar "|."
   \pageBreak
#})
TrackAVoiceBMusic = #(define-music-function (inTab) (boolean?)
#{
   
#})
TrackALyrics = \lyricmode {
   \set ignoreMelismata = ##t
   
   \unset ignoreMelismata
}
TrackAStaff = \new Staff <<
   \context Voice = "TrackAVoiceAMusic" {
      \TrackAVoiceAMusic ##f
   }
   \context Voice = "TrackAVoiceBMusic" {
      \TrackAVoiceBMusic ##f
   }
>>
TrackATabStaff = \new TabStaff \with { stringTunings = #`(,(ly:make-pitch 0 2 NATURAL) ,(ly:make-pitch -1 6 NATURAL) ,(ly:make-pitch -1 4 NATURAL) ,(ly:make-pitch -1 1 NATURAL) ,(ly:make-pitch -2 5 NATURAL) ,(ly:make-pitch -2 2 NATURAL) ) } <<
   \context TabVoice = "TrackAVoiceAMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackAVoiceAMusic ##t
   }
   \context TabVoice = "TrackAVoiceBMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackAVoiceBMusic ##t
   }
>>
TrackAStaffGroup = \new StaffGroup <<
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
