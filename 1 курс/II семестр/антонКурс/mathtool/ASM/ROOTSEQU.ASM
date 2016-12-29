;
; The following file contains glue code for calling
; routines defined outside of the "RootsEqu" unit.
;
DATA      SEGMENT  PUBLIC
DATA      ENDS

CODE      SEGMENT  PUBLIC

          ASSUME   CS:CODE, DS:DATA

          PUBLIC   UserFunction, UserProcedure  ;Make routines known

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

;procedure UserProcedure(X : TNcomplex; var Y : TNcomplex; ProcAddr : Pointer);

UserProcedure  PROC FAR

               POP      AX             ;Get return address
               POP      BX
               POP      CX             ;Proc offset
               POP      DX             ;Proc segment
               PUSH     BX             ;Push return address
               PUSH     AX
               PUSH     DX
               PUSH     CX
               RET                     ;Jump to proc

UserProcedure  ENDP

CODE           ENDS
               END
