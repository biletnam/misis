;
; The following file contains glue code for calling
; routines defined outside of the "Integrat" unit.
;
DATA      SEGMENT  PUBLIC
DATA      ENDS

CODE      SEGMENT  PUBLIC

          ASSUME   CS:CODE, DS:DATA

          PUBLIC   UserFunction        ;Make routines known

;function UserFunction(X : real; ProcAddr : Pointer) : real;

UserFunction   PROC FAR

               POP      AX             ;Get return address
               POP      BX
               POP      CX             ;Proc offset
               POP      DX             ;Proc segment
               PUSH     BX             ;Push return address
               PUSH     AX
               PUSH     DX
               PUSH     CX
               RET                     ;Jump to proc

UserFunction   ENDP

CODE           ENDS
               END
