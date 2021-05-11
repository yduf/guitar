\include "predefined-guitar-fretboards.ly"
#(define custom-fretboard-table-one (make-fretboard-table))

#(define RH rightHandFinger)


#(define (tie::tab-clear-tied-fret-numbers grob)
   (let* ((tied-fret-nr (ly:spanner-bound grob RIGHT)))
      (ly:grob-set-property! tied-fret-nr 'transparent #t)))

\version "2.22.0"
\paper {
   indent = #0
   print-all-headers = ##t
   print-all-headers = ##t
   ragged-right = ##f
   ragged-bottom = ##t
}
\layout {

   \override TextScript.fret-diagram-details.finger-code = #'below-string
   \override TextScript.fret-diagram-details.barre-type = #'straight

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
   \tempo 4=120
   \clef #(if inTab "moderntab" "treble_8")
   \key c \major
   \time 4/4
   \oneVoice
   %\time #'(8 3) 4/4
    %{ 1 %}
   <\tweak duration-log #1 e\4  \RH #1 >8 
   <a\3  \RH #2 >8 
   <c'\2 \RH #3 >8 
   <e'\1 \RH #4 >8 
   
   <c'\2 \RH #3 >8 
   <a\3 \RH #2 >8 
   <e\4 \RH #1 >8 
   <a\3 \RH #2 >8 

    %{ 2 %}
   <\tweak duration-log #1 f\4>8 <a\3>8 <c'\2>8 <e'\1>8 
   <c'\2>8 <a\3>8 <f\4>8 <a\3>8 

    %{ 3 %}
   <\tweak duration-log #1 fis\4>8 <a\3>8 <c'\2>8 <e'\1>8
   <c'\2>8 <a\3>8 <fis\4>8 <a\3>8 

    %{ 4 %}
   <\tweak duration-log #1 f\4>8 <a\3>8 <c'\2>8 <e'\1>8 
   <c'\2>8 <a\3>8 <f\4>8 <a\3>8 

    %{ 5 %}
   <\tweak duration-log #1 e\4>8 <a\3>8 <c'\2>8 <e'\1>8 
   <\tweak duration-log #1 d\4>8 <a\3>8 <c'\2>8 <e'\1>8 

    %{ 6 %}
   <\tweak duration-log #1 c\5>8 <a\3>8 <c'\2>8 <e'\1>8 
   <\tweak duration-log #1 b,\5>8 <a\3>8 <c'\2>8 <e'\1>8 

    %{ 7 %}
   <\tweak duration-log #1 a,\5  \RH #1 >8 
   <e\4  \RH #1 >8 
   <a\3  \RH #2 >8 
   <b\2  \RH #3 >8( <c'\2 >8 )
   <a\3  \RH #2 >8 
   <e'\1  \RH #4 >8 
   <c'\2  \RH #3 >8 

    %{ 8 %}
   <\tweak duration-log #1 a,\5 \RH #1 >8 
   <e\4 \RH #1 >8 
   <a\3 \RH #2 >8 
   <c'\2 \RH #3 >8 
   <e'\1 \RH #4 >2 

    \break

  %{ 9 
   <e\4>8 <a\3>8 <c'\2>8 <e'\1>8
   <c'\2>8 <a\3>8 <e\4>8 <a\3>8 

   <f\4>8 <a\3>8 <c'\2>8 <e'\1>8 
   <c'\2>8 <a\3>8 <f\4>8 <a\3>8 

   <fis\4>8 <a\3>8 <c'\2>8 <e'\1>8 
   <c'\2>8 <a\3>8 <fis\4>8 <a\3>8 

   <f\4>8 <a\3>8 <c'\2>8 <e'\1>8 
   <c'\2>8 <a\3>8 <f\4>8 <a\3>8 

   <f\4>8 <a\3>8 <c'\2>8 <e'\1>8 
   <c'\2>8 <a\3>8 <f\4>8 <a\3>8 

   <f\4>8 <a\3>8 <c'\2>8 <e\4>8 
   <d\4>8 <a\3>8 <c'\2>8 <e'\1>8 

   <d\4>8 <a\3>8 <c'\2>8 <e'\1>8 
   <c'\2>8 <a\3>8 <c\5>8 <b,\5>8 

   <a,\5>8 <e\4>8 <a\3>8 <b\2>8 <c'\2>8 
   <a\3>8 <e'\1>8 <c'\2>8 

   <a,\5>8 <e\4>8 <a\3>8 <c'\2>8 <e'\1>2 
   %}


   <c\5>8 <e\4>8 <g\3>8 <c'\2>8 <e'\1>8 <c'\2>8 <g\3>8 <e\4>8 
   <b,\5>8 <d\4>8 <g\3>8 <c'\2>8 <d'\2>8 <e'\1>8 <d'\2>8 <c'\2>8 
   <a,\5>8 <e\4>8 <a\3>8 <b\2>8 <c'\2>8 <a\3>8 <c'\2>8 <e'\1>8 
   <e'\2 c'\3 >8 <e'\1>8 <d'\2 b\3 >8 <e'\1>8 <c'\2 a\3 >8 <e'\1>8 <b\2 g\3 >8 <e'\1>8 
   <c\5>8 <e\4>8 <g\3>8 <c'\2>8 <e'\1>8 <c'\2>8 <g\3>8 <e\4>8 
   <b,\5>8 <e\4>8 <g\3>8 <c'\2>8 <d'\2>8 <e'\1>8 <d'\2>8 <c'\2>8 
   <a,\5>8 <e\4>8 <a\3>8 <b\2>8 <c'\2>8 <a\3>8 <cis'\2>8 <b\2>8 
   <c''\1>2. <d'\3>8 <b'\1>8 
   <e\4>8 <a\3>8 <c'\2>8 <e'\1>8 <c'\2>8 <a\3>8 <e\4>8 <a\3>8 
   <f\4>8 <a\3>8 <c'\2>8 <e'\1>8 <c'\2>8 <a\3>8 <f\4>8 <a\3>8 
   <fis\4>8 <a\3>8 <c'\2>8 <e'\1>8 <c'\2>8 <a\3>8 <fis\4>8 <a\3>8 
   <f\4>8 <a\3>8 <c'\2>8 <e'\1>8 <c'\2>8 <a\3>8 <f\4>8 <a\3>8 
   <e\4>8 <a\3>8 <c'\2>8 <e'\1>8 <d\4>8 <a\3>8 <c'\2>8 <e'\1>8 
   <c\5>8 <a\3>8 <c'\2>8 <e'\1>8 <b,\5>8 <a\3>8 <c'\2>8 <e'\1>8 
   <a,\5>8 <e\4>8 <a\3>8 <b\2>8 <c'\2>8 <a\3>8 <c'\2>8 <e'\1>8 
   <a\4>1 
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
   \chords { 
     \set chordChanges = ##t        % only display when chord change
   % 1
    a1:m f:maj7 a:m6 f:maj7 
    a1:m 
   }
\new FretBoards {
    \chordmode {
      \set predefinedDiagramTable = #default-fret-table
    a1:m f:maj7  a:m6 f:maj7 
    }
}
   \TrackAStaff
   \TrackATabStaff
>>
\score {
   \TrackAStaffGroup
   \header {
      title = "Is there anybody out there" 
      composer = "Pink Floyd's" 
   }
}
