;
; The following file contains glue code for calling
; routines defined outside of the "InitVal" unit.
;
DATA      SEGMENT  PUBLIC
DATA      ENDS

CODE      SEGMENT  PUBLIC

          ASSUME   CS:CODE, DS:DATA

          PUBLIC   UserFunction1, UserFunction2
          PUBLIC   UserFunction3, UserFunction4

;function UserFunction1(T, X : real; ProcAddr : Pointer) : real;

UserFunction1  PROC FAR

               POP      AX             ;Get return address
               POP      BX
               POP      CX             ;Proc offset
               POP      DX             ;Proc segment
               PUSH     BX             ;Push return address
               PUSH     AX
               PUSH     DX
               PUSH     CX
               RET                     ;Jump to proc

UserFunction1  ENDP

;function UserFunction2(T, X, XPrime : real; ProcAddr : Pointer) : real;

UserFunction2  PROC FAR

               POP      AX             ;Get return address
               POP      BX
               POP      CX             ;Proc offset
               POP      DX             ;Proc segment
               PUSH     BX             ;Push return address
               PUSH     AX
               PUSH     DX
               PUSH     CX
               RET                     ;Jump to proc

UserFunction2  ENDP

;function UserFunction3(V : TNvector; ProcAddr : Pointer) : real;

UserFunction3  PROC FAR

               POP      AX             ;Get return address
               POP      BX
               POP      CX             ;Proc offset
               POP      DX             ;Proc segment
               PUSH     BX             ;Push return address
               PUSH     AX
               PUSH     DX
               PUSH     CX
               RET                     ;Jump to proc

UserFunction3  ENDP

;function UserFunction4(V : TNvector2; ProcAddr : Pointer) : real;

UserFunction4  PROC FAR

               POP      AX             ;Get return address
               POP      BX
               POP      CX             ;Proc offset
               POP      DX             ;Proc segment
               PUSH     BX             ;Push return address
               PUSH     AX
               PUSH     DX
               PUSH     CX
               RET                     ;Jump to proc

UserFunction4  ENDP

CODE           ENDS
               END
