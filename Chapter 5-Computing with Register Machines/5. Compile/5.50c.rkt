(define evaluator-instructions
  '((assign val (op make-compiled-procedure) (label entry1) (reg env))
  (goto (label after-lambda2))
entry1
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (proc seq)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const null?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch6))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch7))
compiled-branch8
  (assign continue (label after-call9))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch7
  (assign continue (label after-call9))
  (save continue)
  (goto (reg compapp))
primitive-branch6
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call9
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch4))
true-branch3
  (assign val (const ()))
  (goto (reg continue))
false-branch4
  (assign proc (op lookup-variable-value) (const cons) (reg env))
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const map) (reg env))
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const cdr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch18))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch19))
compiled-branch20
  (assign continue (label after-call21))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch19
  (assign continue (label after-call21))
  (save continue)
  (goto (reg compapp))
primitive-branch18
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call21
  (assign argl (op list) (reg val))
  (restore env)
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch22))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch23))
compiled-branch24
  (assign continue (label after-call25))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch23
  (assign continue (label after-call25))
  (save continue)
  (goto (reg compapp))
primitive-branch22
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call25
  (assign argl (op list) (reg val))
  (restore env)
  (save argl)
  (assign proc (op lexical-address-lookup) (const (0 0)) (reg env))
  (save proc)
  (assign proc (op lookup-variable-value) (const car) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch10))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch11))
compiled-branch12
  (assign continue (label after-call13))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch11
  (assign continue (label after-call13))
  (save continue)
  (goto (reg compapp))
primitive-branch10
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call13
  (assign argl (op list) (reg val))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch14))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch15))
compiled-branch16
  (assign continue (label after-call17))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch15
  (assign continue (label after-call17))
  (save continue)
  (goto (reg compapp))
primitive-branch14
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call17
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch26))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch27))
compiled-branch28
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch27
  (save continue)
  (goto (reg compapp))
primitive-branch26
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call29
after-if5
after-lambda2
  (perform (op define-variable!) (const map) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry30) (reg env))
  (goto (label after-lambda31))
entry30
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp env)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const self-evaluating?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch35))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch36))
compiled-branch37
  (assign continue (label after-call38))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch36
  (assign continue (label after-call38))
  (save continue)
  (goto (reg compapp))
primitive-branch35
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call38
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch33))
true-branch32
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (goto (reg continue))
false-branch33
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const variable?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch42))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch43))
compiled-branch44
  (assign continue (label after-call45))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch43
  (assign continue (label after-call45))
  (save continue)
  (goto (reg compapp))
primitive-branch42
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call45
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch40))
true-branch39
  (assign proc (op lookup-variable-value) (const lookup-variable-value) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch46))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch47))
compiled-branch48
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch47
  (save continue)
  (goto (reg compapp))
primitive-branch46
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call49
false-branch40
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const quoted?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch53))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch54))
compiled-branch55
  (assign continue (label after-call56))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch54
  (assign continue (label after-call56))
  (save continue)
  (goto (reg compapp))
primitive-branch53
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call56
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch51))
true-branch50
  (assign proc (op lookup-variable-value) (const text-of-quotation) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch57))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch58))
compiled-branch59
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch58
  (save continue)
  (goto (reg compapp))
primitive-branch57
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call60
false-branch51
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const and?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch64))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch65))
compiled-branch66
  (assign continue (label after-call67))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch65
  (assign continue (label after-call67))
  (save continue)
  (goto (reg compapp))
primitive-branch64
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call67
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch62))
true-branch61
  (assign proc (op lookup-variable-value) (const eval) (reg env))
  (save continue)
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const and->if) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch68))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch69))
compiled-branch70
  (assign continue (label after-call71))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch69
  (assign continue (label after-call71))
  (save continue)
  (goto (reg compapp))
primitive-branch68
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call71
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch72))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch73))
compiled-branch74
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch73
  (save continue)
  (goto (reg compapp))
primitive-branch72
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call75
false-branch62
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const or?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch79))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch80))
compiled-branch81
  (assign continue (label after-call82))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch80
  (assign continue (label after-call82))
  (save continue)
  (goto (reg compapp))
primitive-branch79
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call82
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch77))
true-branch76
  (assign proc (op lookup-variable-value) (const eval) (reg env))
  (save continue)
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const or->if) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch83))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch84))
compiled-branch85
  (assign continue (label after-call86))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch84
  (assign continue (label after-call86))
  (save continue)
  (goto (reg compapp))
primitive-branch83
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call86
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch87))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch88))
compiled-branch89
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch88
  (save continue)
  (goto (reg compapp))
primitive-branch87
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call90
false-branch77
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const do?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch94))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch95))
compiled-branch96
  (assign continue (label after-call97))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch95
  (assign continue (label after-call97))
  (save continue)
  (goto (reg compapp))
primitive-branch94
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call97
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch92))
true-branch91
  (assign proc (op lookup-variable-value) (const eval) (reg env))
  (save continue)
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const do->if) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch98))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch99))
compiled-branch100
  (assign continue (label after-call101))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch99
  (assign continue (label after-call101))
  (save continue)
  (goto (reg compapp))
primitive-branch98
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call101
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch102))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch103))
compiled-branch104
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch103
  (save continue)
  (goto (reg compapp))
primitive-branch102
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call105
false-branch92
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const while?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch109))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch110))
compiled-branch111
  (assign continue (label after-call112))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch110
  (assign continue (label after-call112))
  (save continue)
  (goto (reg compapp))
primitive-branch109
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call112
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch107))
true-branch106
  (assign proc (op lookup-variable-value) (const eval) (reg env))
  (save continue)
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const while->combination) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch113))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch114))
compiled-branch115
  (assign continue (label after-call116))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch114
  (assign continue (label after-call116))
  (save continue)
  (goto (reg compapp))
primitive-branch113
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call116
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch117))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch118))
compiled-branch119
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch118
  (save continue)
  (goto (reg compapp))
primitive-branch117
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call120
false-branch107
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const assignment?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch124))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch125))
compiled-branch126
  (assign continue (label after-call127))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch125
  (assign continue (label after-call127))
  (save continue)
  (goto (reg compapp))
primitive-branch124
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call127
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch122))
true-branch121
  (assign proc (op lookup-variable-value) (const eval-assignment) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch128))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch129))
compiled-branch130
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch129
  (save continue)
  (goto (reg compapp))
primitive-branch128
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call131
false-branch122
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const definition?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch135))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch136))
compiled-branch137
  (assign continue (label after-call138))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch136
  (assign continue (label after-call138))
  (save continue)
  (goto (reg compapp))
primitive-branch135
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call138
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch133))
true-branch132
  (assign proc (op lookup-variable-value) (const eval-definition) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch139))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch140))
compiled-branch141
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch140
  (save continue)
  (goto (reg compapp))
primitive-branch139
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call142
false-branch133
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const if?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch146))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch147))
compiled-branch148
  (assign continue (label after-call149))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch147
  (assign continue (label after-call149))
  (save continue)
  (goto (reg compapp))
primitive-branch146
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call149
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch144))
true-branch143
  (assign proc (op lookup-variable-value) (const eval-if) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch150))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch151))
compiled-branch152
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch151
  (save continue)
  (goto (reg compapp))
primitive-branch150
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call153
false-branch144
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const lambda?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch157))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch158))
compiled-branch159
  (assign continue (label after-call160))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch158
  (assign continue (label after-call160))
  (save continue)
  (goto (reg compapp))
primitive-branch157
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call160
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch155))
true-branch154
  (assign proc (op lookup-variable-value) (const make-procedure) (reg env))
  (save continue)
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const lambda-body) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch165))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch166))
compiled-branch167
  (assign continue (label after-call168))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch166
  (assign continue (label after-call168))
  (save continue)
  (goto (reg compapp))
primitive-branch165
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call168
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save argl)
  (assign proc (op lookup-variable-value) (const lambda-parameters) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch161))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch162))
compiled-branch163
  (assign continue (label after-call164))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch162
  (assign continue (label after-call164))
  (save continue)
  (goto (reg compapp))
primitive-branch161
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call164
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch169))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch170))
compiled-branch171
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch170
  (save continue)
  (goto (reg compapp))
primitive-branch169
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call172
false-branch155
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const let?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch176))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch177))
compiled-branch178
  (assign continue (label after-call179))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch177
  (assign continue (label after-call179))
  (save continue)
  (goto (reg compapp))
primitive-branch176
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call179
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch174))
true-branch173
  (assign proc (op lookup-variable-value) (const eval) (reg env))
  (save continue)
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const let->combination) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch180))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch181))
compiled-branch182
  (assign continue (label after-call183))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch181
  (assign continue (label after-call183))
  (save continue)
  (goto (reg compapp))
primitive-branch180
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call183
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch184))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch185))
compiled-branch186
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch185
  (save continue)
  (goto (reg compapp))
primitive-branch184
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call187
false-branch174
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const begin?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch191))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch192))
compiled-branch193
  (assign continue (label after-call194))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch192
  (assign continue (label after-call194))
  (save continue)
  (goto (reg compapp))
primitive-branch191
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call194
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch189))
true-branch188
  (assign proc (op lookup-variable-value) (const eval-sequence) (reg env))
  (save continue)
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const begin-actions) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch195))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch196))
compiled-branch197
  (assign continue (label after-call198))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch196
  (assign continue (label after-call198))
  (save continue)
  (goto (reg compapp))
primitive-branch195
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call198
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch199))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch200))
compiled-branch201
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch200
  (save continue)
  (goto (reg compapp))
primitive-branch199
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call202
false-branch189
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const cond?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch206))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch207))
compiled-branch208
  (assign continue (label after-call209))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch207
  (assign continue (label after-call209))
  (save continue)
  (goto (reg compapp))
primitive-branch206
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call209
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch204))
true-branch203
  (assign proc (op lookup-variable-value) (const eval) (reg env))
  (save continue)
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const cond->if) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch210))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch211))
compiled-branch212
  (assign continue (label after-call213))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch211
  (assign continue (label after-call213))
  (save continue)
  (goto (reg compapp))
primitive-branch210
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call213
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch214))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch215))
compiled-branch216
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch215
  (save continue)
  (goto (reg compapp))
primitive-branch214
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call217
false-branch204
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const application?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch221))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch222))
compiled-branch223
  (assign continue (label after-call224))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch222
  (assign continue (label after-call224))
  (save continue)
  (goto (reg compapp))
primitive-branch221
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call224
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch219))
true-branch218
  (assign proc (op lookup-variable-value) (const apply) (reg env))
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const list-of-values) (reg env))
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const operands) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch233))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch234))
compiled-branch235
  (assign continue (label after-call236))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch234
  (assign continue (label after-call236))
  (save continue)
  (goto (reg compapp))
primitive-branch233
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call236
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch237))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch238))
compiled-branch239
  (assign continue (label after-call240))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch238
  (assign continue (label after-call240))
  (save continue)
  (goto (reg compapp))
primitive-branch237
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call240
  (assign argl (op list) (reg val))
  (restore env)
  (save argl)
  (assign proc (op lookup-variable-value) (const eval) (reg env))
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const operator) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch225))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch226))
compiled-branch227
  (assign continue (label after-call228))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch226
  (assign continue (label after-call228))
  (save continue)
  (goto (reg compapp))
primitive-branch225
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call228
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch229))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch230))
compiled-branch231
  (assign continue (label after-call232))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch230
  (assign continue (label after-call232))
  (save continue)
  (goto (reg compapp))
primitive-branch229
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call232
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch241))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch242))
compiled-branch243
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch242
  (save continue)
  (goto (reg compapp))
primitive-branch241
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call244
false-branch219
  (assign proc (op lookup-variable-value) (const error) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const Unknown expression type -- EVAL))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch245))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch246))
compiled-branch247
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch246
  (save continue)
  (goto (reg compapp))
primitive-branch245
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call248
after-if220
after-if205
after-if190
after-if175
after-if156
after-if145
after-if134
after-if123
after-if108
after-if93
after-if78
after-if63
after-if52
after-if41
after-if34
after-lambda31
  (perform (op define-variable!) (const eval) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry249) (reg env))
  (goto (label after-lambda250))
entry249
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (procedure arguments)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const primitive-procedure?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch254))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch255))
compiled-branch256
  (assign continue (label after-call257))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch255
  (assign continue (label after-call257))
  (save continue)
  (goto (reg compapp))
primitive-branch254
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call257
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch252))
true-branch251
  (assign proc (op lookup-variable-value) (const apply-primitive-procedure) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch258))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch259))
compiled-branch260
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch259
  (save continue)
  (goto (reg compapp))
primitive-branch258
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call261
false-branch252
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const compound-procedure?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch265))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch266))
compiled-branch267
  (assign continue (label after-call268))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch266
  (assign continue (label after-call268))
  (save continue)
  (goto (reg compapp))
primitive-branch265
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call268
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch263))
true-branch262
  (assign proc (op lookup-variable-value) (const eval-sequence) (reg env))
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const extend-environment) (reg env))
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const procedure-environment) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch277))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch278))
compiled-branch279
  (assign continue (label after-call280))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch278
  (assign continue (label after-call280))
  (save continue)
  (goto (reg compapp))
primitive-branch277
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call280
  (assign argl (op list) (reg val))
  (restore env)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (save argl)
  (assign proc (op lookup-variable-value) (const procedure-parameters) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch273))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch274))
compiled-branch275
  (assign continue (label after-call276))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch274
  (assign continue (label after-call276))
  (save continue)
  (goto (reg compapp))
primitive-branch273
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call276
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch281))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch282))
compiled-branch283
  (assign continue (label after-call284))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch282
  (assign continue (label after-call284))
  (save continue)
  (goto (reg compapp))
primitive-branch281
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call284
  (assign argl (op list) (reg val))
  (restore env)
  (save argl)
  (assign proc (op lookup-variable-value) (const procedure-body) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch269))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch270))
compiled-branch271
  (assign continue (label after-call272))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch270
  (assign continue (label after-call272))
  (save continue)
  (goto (reg compapp))
primitive-branch269
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call272
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch285))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch286))
compiled-branch287
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch286
  (save continue)
  (goto (reg compapp))
primitive-branch285
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call288
false-branch263
  (assign proc (op lookup-variable-value) (const error) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const Unknown procedure type -- APPLY))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch289))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch290))
compiled-branch291
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch290
  (save continue)
  (goto (reg compapp))
primitive-branch289
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call292
after-if264
after-if253
after-lambda250
  (perform (op define-variable!) (const apply) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry293) (reg env))
  (goto (label after-lambda294))
entry293
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exps env)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const no-operands?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch298))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch299))
compiled-branch300
  (assign continue (label after-call301))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch299
  (assign continue (label after-call301))
  (save continue)
  (goto (reg compapp))
primitive-branch298
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call301
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch296))
true-branch295
  (assign val (const ()))
  (goto (reg continue))
false-branch296
  (assign proc (op lookup-variable-value) (const cons) (reg env))
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const list-of-values) (reg env))
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const rest-operands) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch310))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch311))
compiled-branch312
  (assign continue (label after-call313))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch311
  (assign continue (label after-call313))
  (save continue)
  (goto (reg compapp))
primitive-branch310
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call313
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch314))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch315))
compiled-branch316
  (assign continue (label after-call317))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch315
  (assign continue (label after-call317))
  (save continue)
  (goto (reg compapp))
primitive-branch314
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call317
  (assign argl (op list) (reg val))
  (restore env)
  (save argl)
  (assign proc (op lookup-variable-value) (const eval) (reg env))
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const first-operand) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch302))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch303))
compiled-branch304
  (assign continue (label after-call305))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch303
  (assign continue (label after-call305))
  (save continue)
  (goto (reg compapp))
primitive-branch302
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call305
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch306))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch307))
compiled-branch308
  (assign continue (label after-call309))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch307
  (assign continue (label after-call309))
  (save continue)
  (goto (reg compapp))
primitive-branch306
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call309
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch318))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch319))
compiled-branch320
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch319
  (save continue)
  (goto (reg compapp))
primitive-branch318
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call321
after-if297
after-lambda294
  (perform (op define-variable!) (const list-of-values) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry322) (reg env))
  (goto (label after-lambda323))
entry322
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp env)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const true?) (reg env))
  (save proc)
  (assign proc (op lookup-variable-value) (const eval) (reg env))
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const if-predicate) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch327))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch328))
compiled-branch329
  (assign continue (label after-call330))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch328
  (assign continue (label after-call330))
  (save continue)
  (goto (reg compapp))
primitive-branch327
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call330
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch331))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch332))
compiled-branch333
  (assign continue (label after-call334))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch332
  (assign continue (label after-call334))
  (save continue)
  (goto (reg compapp))
primitive-branch331
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call334
  (assign argl (op list) (reg val))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch335))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch336))
compiled-branch337
  (assign continue (label after-call338))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch336
  (assign continue (label after-call338))
  (save continue)
  (goto (reg compapp))
primitive-branch335
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call338
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch325))
true-branch324
  (assign proc (op lookup-variable-value) (const eval) (reg env))
  (save continue)
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const if-consequent) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch339))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch340))
compiled-branch341
  (assign continue (label after-call342))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch340
  (assign continue (label after-call342))
  (save continue)
  (goto (reg compapp))
primitive-branch339
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call342
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch343))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch344))
compiled-branch345
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch344
  (save continue)
  (goto (reg compapp))
primitive-branch343
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call346
false-branch325
  (assign proc (op lookup-variable-value) (const eval) (reg env))
  (save continue)
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const if-alternative) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch347))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch348))
compiled-branch349
  (assign continue (label after-call350))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch348
  (assign continue (label after-call350))
  (save continue)
  (goto (reg compapp))
primitive-branch347
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call350
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch351))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch352))
compiled-branch353
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch352
  (save continue)
  (goto (reg compapp))
primitive-branch351
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call354
after-if326
after-lambda323
  (perform (op define-variable!) (const eval-if) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry355) (reg env))
  (goto (label after-lambda356))
entry355
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exps env)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const last-exp?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch360))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch361))
compiled-branch362
  (assign continue (label after-call363))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch361
  (assign continue (label after-call363))
  (save continue)
  (goto (reg compapp))
primitive-branch360
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call363
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch358))
true-branch357
  (assign proc (op lookup-variable-value) (const eval) (reg env))
  (save continue)
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const first-exp) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch364))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch365))
compiled-branch366
  (assign continue (label after-call367))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch365
  (assign continue (label after-call367))
  (save continue)
  (goto (reg compapp))
primitive-branch364
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call367
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch368))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch369))
compiled-branch370
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch369
  (save continue)
  (goto (reg compapp))
primitive-branch368
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call371
false-branch358
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const eval) (reg env))
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const first-exp) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch372))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch373))
compiled-branch374
  (assign continue (label after-call375))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch373
  (assign continue (label after-call375))
  (save continue)
  (goto (reg compapp))
primitive-branch372
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call375
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch376))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch377))
compiled-branch378
  (assign continue (label after-call379))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch377
  (assign continue (label after-call379))
  (save continue)
  (goto (reg compapp))
primitive-branch376
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call379
  (restore env)
  (restore continue)
  (assign proc (op lookup-variable-value) (const eval-sequence) (reg env))
  (save continue)
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const rest-exps) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch380))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch381))
compiled-branch382
  (assign continue (label after-call383))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch381
  (assign continue (label after-call383))
  (save continue)
  (goto (reg compapp))
primitive-branch380
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call383
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch384))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch385))
compiled-branch386
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch385
  (save continue)
  (goto (reg compapp))
primitive-branch384
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call387
after-if359
after-lambda356
  (perform (op define-variable!) (const eval-sequence) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry388) (reg env))
  (goto (label after-lambda389))
entry388
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp env)) (reg argl) (reg env))
  (save continue)
  (assign proc (op lookup-variable-value) (const set-variable-value!) (reg env))
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const eval) (reg env))
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const assignment-value) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch394))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch395))
compiled-branch396
  (assign continue (label after-call397))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch395
  (assign continue (label after-call397))
  (save continue)
  (goto (reg compapp))
primitive-branch394
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call397
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch398))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch399))
compiled-branch400
  (assign continue (label after-call401))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch399
  (assign continue (label after-call401))
  (save continue)
  (goto (reg compapp))
primitive-branch398
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call401
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save argl)
  (assign proc (op lookup-variable-value) (const assignment-variable) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch390))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch391))
compiled-branch392
  (assign continue (label after-call393))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch391
  (assign continue (label after-call393))
  (save continue)
  (goto (reg compapp))
primitive-branch390
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call393
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch402))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch403))
compiled-branch404
  (assign continue (label after-call405))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch403
  (assign continue (label after-call405))
  (save continue)
  (goto (reg compapp))
primitive-branch402
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call405
  (restore continue)
  (assign val (const ok))
  (goto (reg continue))
after-lambda389
  (perform (op define-variable!) (const eval-assignment) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry406) (reg env))
  (goto (label after-lambda407))
entry406
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp env)) (reg argl) (reg env))
  (save continue)
  (assign proc (op lookup-variable-value) (const define-variable!) (reg env))
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const eval) (reg env))
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const definition-value) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch412))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch413))
compiled-branch414
  (assign continue (label after-call415))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch413
  (assign continue (label after-call415))
  (save continue)
  (goto (reg compapp))
primitive-branch412
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call415
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch416))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch417))
compiled-branch418
  (assign continue (label after-call419))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch417
  (assign continue (label after-call419))
  (save continue)
  (goto (reg compapp))
primitive-branch416
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call419
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save argl)
  (assign proc (op lookup-variable-value) (const definition-variable) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch408))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch409))
compiled-branch410
  (assign continue (label after-call411))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch409
  (assign continue (label after-call411))
  (save continue)
  (goto (reg compapp))
primitive-branch408
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call411
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch420))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch421))
compiled-branch422
  (assign continue (label after-call423))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch421
  (assign continue (label after-call423))
  (save continue)
  (goto (reg compapp))
primitive-branch420
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call423
  (restore continue)
  (assign val (const ok))
  (goto (reg continue))
after-lambda407
  (perform (op define-variable!) (const eval-definition) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry424) (reg env))
  (goto (label after-lambda425))
entry424
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (proc)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
  (assign val (const primitive))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch426))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch427))
compiled-branch428
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch427
  (save continue)
  (goto (reg compapp))
primitive-branch426
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call429
after-lambda425
  (perform (op define-variable!) (const primitive-procedure?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry430) (reg env))
  (goto (label after-lambda431))
entry430
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (proc)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cadr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch432))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch433))
compiled-branch434
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch433
  (save continue)
  (goto (reg compapp))
primitive-branch432
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call435
after-lambda431
  (perform (op define-variable!) (const primitive-implementation) (reg val) (reg env))
  (assign val (const ok))
  (save env)
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lookup-variable-value) (const runtime) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const runtime))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch496))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch497))
compiled-branch498
  (assign continue (label after-call499))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch497
  (assign continue (label after-call499))
  (save continue)
  (goto (reg compapp))
primitive-branch496
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call499
  (assign argl (op list) (reg val))
  (restore env)
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lookup-variable-value) (const display) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const display))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch492))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch493))
compiled-branch494
  (assign continue (label after-call495))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch493
  (assign continue (label after-call495))
  (save continue)
  (goto (reg compapp))
primitive-branch492
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call495
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lookup-variable-value) (const >=) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const >=))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch488))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch489))
compiled-branch490
  (assign continue (label after-call491))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch489
  (assign continue (label after-call491))
  (save continue)
  (goto (reg compapp))
primitive-branch488
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call491
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lookup-variable-value) (const <=) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const <=))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch484))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch485))
compiled-branch486
  (assign continue (label after-call487))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch485
  (assign continue (label after-call487))
  (save continue)
  (goto (reg compapp))
primitive-branch484
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call487
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lookup-variable-value) (const <) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const <))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch480))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch481))
compiled-branch482
  (assign continue (label after-call483))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch481
  (assign continue (label after-call483))
  (save continue)
  (goto (reg compapp))
primitive-branch480
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call483
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lookup-variable-value) (const >) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const >))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch476))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch477))
compiled-branch478
  (assign continue (label after-call479))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch477
  (assign continue (label after-call479))
  (save continue)
  (goto (reg compapp))
primitive-branch476
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call479
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lookup-variable-value) (const =) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const =))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch472))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch473))
compiled-branch474
  (assign continue (label after-call475))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch473
  (assign continue (label after-call475))
  (save continue)
  (goto (reg compapp))
primitive-branch472
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call475
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lookup-variable-value) (const /) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const /))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch468))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch469))
compiled-branch470
  (assign continue (label after-call471))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch469
  (assign continue (label after-call471))
  (save continue)
  (goto (reg compapp))
primitive-branch468
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call471
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lookup-variable-value) (const -) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const -))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch464))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch465))
compiled-branch466
  (assign continue (label after-call467))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch465
  (assign continue (label after-call467))
  (save continue)
  (goto (reg compapp))
primitive-branch464
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call467
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lookup-variable-value) (const *) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const *))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch460))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch461))
compiled-branch462
  (assign continue (label after-call463))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch461
  (assign continue (label after-call463))
  (save continue)
  (goto (reg compapp))
primitive-branch460
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call463
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lookup-variable-value) (const +) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const +))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch456))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch457))
compiled-branch458
  (assign continue (label after-call459))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch457
  (assign continue (label after-call459))
  (save continue)
  (goto (reg compapp))
primitive-branch456
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call459
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lookup-variable-value) (const null?) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const null?))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch452))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch453))
compiled-branch454
  (assign continue (label after-call455))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch453
  (assign continue (label after-call455))
  (save continue)
  (goto (reg compapp))
primitive-branch452
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call455
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lookup-variable-value) (const list) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const list))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch448))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch449))
compiled-branch450
  (assign continue (label after-call451))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch449
  (assign continue (label after-call451))
  (save continue)
  (goto (reg compapp))
primitive-branch448
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call451
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lookup-variable-value) (const cons) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const cons))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch444))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch445))
compiled-branch446
  (assign continue (label after-call447))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch445
  (assign continue (label after-call447))
  (save continue)
  (goto (reg compapp))
primitive-branch444
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call447
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lookup-variable-value) (const cdr) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const cdr))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch440))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch441))
compiled-branch442
  (assign continue (label after-call443))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch441
  (assign continue (label after-call443))
  (save continue)
  (goto (reg compapp))
primitive-branch440
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call443
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save argl)
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lookup-variable-value) (const car) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const car))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch436))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch437))
compiled-branch438
  (assign continue (label after-call439))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch437
  (assign continue (label after-call439))
  (save continue)
  (goto (reg compapp))
primitive-branch436
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call439
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch500))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch501))
compiled-branch502
  (assign continue (label after-call503))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch501
  (assign continue (label after-call503))
  (save continue)
  (goto (reg compapp))
primitive-branch500
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call503
  (restore env)
  (perform (op define-variable!) (const primitive-procedures) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry504) (reg env))
  (goto (label after-lambda505))
entry504
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const ()) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const map) (reg env))
  (assign val (op lookup-variable-value) (const primitive-procedures) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lookup-variable-value) (const car) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch506))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch507))
compiled-branch508
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch507
  (save continue)
  (goto (reg compapp))
primitive-branch506
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call509
after-lambda505
  (perform (op define-variable!) (const primitive-procedure-names) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry510) (reg env))
  (goto (label after-lambda511))
entry510
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const ()) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const map) (reg env))
  (assign val (op lookup-variable-value) (const primitive-procedures) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op make-compiled-procedure) (label entry512) (reg env))
  (goto (label after-lambda513))
entry512
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (proc)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (save continue)
  (save proc)
  (assign proc (op lookup-variable-value) (const cadr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch514))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch515))
compiled-branch516
  (assign continue (label after-call517))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch515
  (assign continue (label after-call517))
  (save continue)
  (goto (reg compapp))
primitive-branch514
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call517
  (assign argl (op list) (reg val))
  (assign val (const primitive))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch518))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch519))
compiled-branch520
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch519
  (save continue)
  (goto (reg compapp))
primitive-branch518
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call521
after-lambda513
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch522))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch523))
compiled-branch524
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch523
  (save continue)
  (goto (reg compapp))
primitive-branch522
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call525
after-lambda511
  (perform (op define-variable!) (const primitive-procedure-objects) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry526) (reg env))
  (goto (label after-lambda527))
entry526
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (proc args)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const apply-in-underlying-scheme) (reg env))
  (save continue)
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const primitive-implementation) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch528))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch529))
compiled-branch530
  (assign continue (label after-call531))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch529
  (assign continue (label after-call531))
  (save continue)
  (goto (reg compapp))
primitive-branch528
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call531
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch532))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch533))
compiled-branch534
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch533
  (save continue)
  (goto (reg compapp))
primitive-branch532
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call535
after-lambda527
  (perform (op define-variable!) (const apply-primitive-procedure) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry536) (reg env))
  (goto (label after-lambda537))
entry536
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (x)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const not) (reg env))
  (save continue)
  (save proc)
  (assign proc (op lookup-variable-value) (const eq?) (reg env))
  (assign val (op lookup-variable-value) (const false) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch538))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch539))
compiled-branch540
  (assign continue (label after-call541))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch539
  (assign continue (label after-call541))
  (save continue)
  (goto (reg compapp))
primitive-branch538
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call541
  (assign argl (op list) (reg val))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch542))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch543))
compiled-branch544
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch543
  (save continue)
  (goto (reg compapp))
primitive-branch542
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call545
after-lambda537
  (perform (op define-variable!) (const true?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry546) (reg env))
  (goto (label after-lambda547))
entry546
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (x)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const eq?) (reg env))
  (assign val (op lookup-variable-value) (const false) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch548))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch549))
compiled-branch550
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch549
  (save continue)
  (goto (reg compapp))
primitive-branch548
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call551
after-lambda547
  (perform (op define-variable!) (const false?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry552) (reg env))
  (goto (label after-lambda553))
entry552
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (parameters body env)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lexical-address-lookup) (const (0 2)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (const procedure))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch554))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch555))
compiled-branch556
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch555
  (save continue)
  (goto (reg compapp))
primitive-branch554
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call557
after-lambda553
  (perform (op define-variable!) (const make-procedure) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry558) (reg env))
  (goto (label after-lambda559))
entry558
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (p)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
  (assign val (const procedure))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch560))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch561))
compiled-branch562
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch561
  (save continue)
  (goto (reg compapp))
primitive-branch560
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call563
after-lambda559
  (perform (op define-variable!) (const compound-procedure?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry564) (reg env))
  (goto (label after-lambda565))
entry564
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (p)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cadr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch566))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch567))
compiled-branch568
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch567
  (save continue)
  (goto (reg compapp))
primitive-branch566
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call569
after-lambda565
  (perform (op define-variable!) (const procedure-parameters) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry570) (reg env))
  (goto (label after-lambda571))
entry570
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (p)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const caddr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch572))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch573))
compiled-branch574
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch573
  (save continue)
  (goto (reg compapp))
primitive-branch572
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call575
after-lambda571
  (perform (op define-variable!) (const procedure-body) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry576) (reg env))
  (goto (label after-lambda577))
entry576
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (p)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cadddr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch578))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch579))
compiled-branch580
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch579
  (save continue)
  (goto (reg compapp))
primitive-branch578
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call581
after-lambda577
  (perform (op define-variable!) (const procedure-environment) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry582) (reg env))
  (goto (label after-lambda583))
entry582
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const number?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch587))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch588))
compiled-branch589
  (assign continue (label after-call590))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch588
  (assign continue (label after-call590))
  (save continue)
  (goto (reg compapp))
primitive-branch587
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call590
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch585))
true-branch584
  (assign val (op lookup-variable-value) (const true) (reg env))
  (goto (reg continue))
false-branch585
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const string?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch594))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch595))
compiled-branch596
  (assign continue (label after-call597))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch595
  (assign continue (label after-call597))
  (save continue)
  (goto (reg compapp))
primitive-branch594
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call597
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch592))
true-branch591
  (assign val (op lookup-variable-value) (const true) (reg env))
  (goto (reg continue))
false-branch592
  (assign val (op lookup-variable-value) (const false) (reg env))
  (goto (reg continue))
after-if593
after-if586
after-lambda583
  (perform (op define-variable!) (const self-evaluating?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry598) (reg env))
  (goto (label after-lambda599))
entry598
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const symbol?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch600))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch601))
compiled-branch602
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch601
  (save continue)
  (goto (reg compapp))
primitive-branch600
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call603
after-lambda599
  (perform (op define-variable!) (const variable?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry604) (reg env))
  (goto (label after-lambda605))
entry604
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
  (assign val (const quote))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch606))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch607))
compiled-branch608
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch607
  (save continue)
  (goto (reg compapp))
primitive-branch606
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call609
after-lambda605
  (perform (op define-variable!) (const quoted?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry610) (reg env))
  (goto (label after-lambda611))
entry610
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cadr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch612))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch613))
compiled-branch614
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch613
  (save continue)
  (goto (reg compapp))
primitive-branch612
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call615
after-lambda611
  (perform (op define-variable!) (const text-of-quotation) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry616) (reg env))
  (goto (label after-lambda617))
entry616
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp tag)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const pair?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch621))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch622))
compiled-branch623
  (assign continue (label after-call624))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch622
  (assign continue (label after-call624))
  (save continue)
  (goto (reg compapp))
primitive-branch621
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call624
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch619))
true-branch618
  (assign proc (op lookup-variable-value) (const eq?) (reg env))
  (save continue)
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const car) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch625))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch626))
compiled-branch627
  (assign continue (label after-call628))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch626
  (assign continue (label after-call628))
  (save continue)
  (goto (reg compapp))
primitive-branch625
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call628
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch629))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch630))
compiled-branch631
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch630
  (save continue)
  (goto (reg compapp))
primitive-branch629
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call632
false-branch619
  (assign val (op lookup-variable-value) (const false) (reg env))
  (goto (reg continue))
after-if620
after-lambda617
  (perform (op define-variable!) (const tagged-list?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry633) (reg env))
  (goto (label after-lambda634))
entry633
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
  (assign val (const set!))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch635))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch636))
compiled-branch637
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch636
  (save continue)
  (goto (reg compapp))
primitive-branch635
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call638
after-lambda634
  (perform (op define-variable!) (const assignment?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry639) (reg env))
  (goto (label after-lambda640))
entry639
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cadr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch641))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch642))
compiled-branch643
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch642
  (save continue)
  (goto (reg compapp))
primitive-branch641
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call644
after-lambda640
  (perform (op define-variable!) (const assignment-variable) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry645) (reg env))
  (goto (label after-lambda646))
entry645
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const caddr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch647))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch648))
compiled-branch649
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch648
  (save continue)
  (goto (reg compapp))
primitive-branch647
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call650
after-lambda646
  (perform (op define-variable!) (const assignment-value) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry651) (reg env))
  (goto (label after-lambda652))
entry651
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (var val)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (const set!))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch653))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch654))
compiled-branch655
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch654
  (save continue)
  (goto (reg compapp))
primitive-branch653
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call656
after-lambda652
  (perform (op define-variable!) (const make-assignment) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry657) (reg env))
  (goto (label after-lambda658))
entry657
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
  (assign val (const define))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch659))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch660))
compiled-branch661
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch660
  (save continue)
  (goto (reg compapp))
primitive-branch659
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call662
after-lambda658
  (perform (op define-variable!) (const definition?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry663) (reg env))
  (goto (label after-lambda664))
entry663
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const symbol?) (reg env))
  (save proc)
  (assign proc (op lookup-variable-value) (const cadr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch668))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch669))
compiled-branch670
  (assign continue (label after-call671))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch669
  (assign continue (label after-call671))
  (save continue)
  (goto (reg compapp))
primitive-branch668
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call671
  (assign argl (op list) (reg val))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch672))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch673))
compiled-branch674
  (assign continue (label after-call675))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch673
  (assign continue (label after-call675))
  (save continue)
  (goto (reg compapp))
primitive-branch672
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call675
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch666))
true-branch665
  (assign proc (op lookup-variable-value) (const cadr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch676))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch677))
compiled-branch678
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch677
  (save continue)
  (goto (reg compapp))
primitive-branch676
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call679
false-branch666
  (assign proc (op lookup-variable-value) (const caadr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch680))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch681))
compiled-branch682
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch681
  (save continue)
  (goto (reg compapp))
primitive-branch680
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call683
after-if667
after-lambda664
  (perform (op define-variable!) (const definition-variable) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry684) (reg env))
  (goto (label after-lambda685))
entry684
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const symbol?) (reg env))
  (save proc)
  (assign proc (op lookup-variable-value) (const cadr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch689))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch690))
compiled-branch691
  (assign continue (label after-call692))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch690
  (assign continue (label after-call692))
  (save continue)
  (goto (reg compapp))
primitive-branch689
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call692
  (assign argl (op list) (reg val))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch693))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch694))
compiled-branch695
  (assign continue (label after-call696))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch694
  (assign continue (label after-call696))
  (save continue)
  (goto (reg compapp))
primitive-branch693
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call696
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch687))
true-branch686
  (assign proc (op lookup-variable-value) (const caddr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch697))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch698))
compiled-branch699
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch698
  (save continue)
  (goto (reg compapp))
primitive-branch697
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call700
false-branch687
  (assign proc (op lookup-variable-value) (const make-lambda) (reg env))
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const cddr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch705))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch706))
compiled-branch707
  (assign continue (label after-call708))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch706
  (assign continue (label after-call708))
  (save continue)
  (goto (reg compapp))
primitive-branch705
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call708
  (assign argl (op list) (reg val))
  (restore env)
  (save argl)
  (assign proc (op lookup-variable-value) (const cdadr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch701))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch702))
compiled-branch703
  (assign continue (label after-call704))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch702
  (assign continue (label after-call704))
  (save continue)
  (goto (reg compapp))
primitive-branch701
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call704
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch709))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch710))
compiled-branch711
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch710
  (save continue)
  (goto (reg compapp))
primitive-branch709
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call712
after-if688
after-lambda685
  (perform (op define-variable!) (const definition-value) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry713) (reg env))
  (goto (label after-lambda714))
entry713
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (var parameters body)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cons) (reg env))
  (save continue)
  (save proc)
  (assign proc (op lookup-variable-value) (const cons) (reg env))
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 2)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const cons) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch715))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch716))
compiled-branch717
  (assign continue (label after-call718))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch716
  (assign continue (label after-call718))
  (save continue)
  (goto (reg compapp))
primitive-branch715
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call718
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch719))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch720))
compiled-branch721
  (assign continue (label after-call722))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch720
  (assign continue (label after-call722))
  (save continue)
  (goto (reg compapp))
primitive-branch719
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call722
  (assign argl (op list) (reg val))
  (assign val (const define))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch723))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch724))
compiled-branch725
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch724
  (save continue)
  (goto (reg compapp))
primitive-branch723
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call726
after-lambda714
  (perform (op define-variable!) (const make-definition) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry727) (reg env))
  (goto (label after-lambda728))
entry727
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
  (assign val (const lambda))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch729))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch730))
compiled-branch731
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch730
  (save continue)
  (goto (reg compapp))
primitive-branch729
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call732
after-lambda728
  (perform (op define-variable!) (const lambda?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry733) (reg env))
  (goto (label after-lambda734))
entry733
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cadr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch735))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch736))
compiled-branch737
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch736
  (save continue)
  (goto (reg compapp))
primitive-branch735
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call738
after-lambda734
  (perform (op define-variable!) (const lambda-parameters) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry739) (reg env))
  (goto (label after-lambda740))
entry739
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cddr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch741))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch742))
compiled-branch743
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch742
  (save continue)
  (goto (reg compapp))
primitive-branch741
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call744
after-lambda740
  (perform (op define-variable!) (const lambda-body) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry745) (reg env))
  (goto (label after-lambda746))
entry745
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (parameters body)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cons) (reg env))
  (save continue)
  (save proc)
  (assign proc (op lookup-variable-value) (const cons) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch747))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch748))
compiled-branch749
  (assign continue (label after-call750))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch748
  (assign continue (label after-call750))
  (save continue)
  (goto (reg compapp))
primitive-branch747
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call750
  (assign argl (op list) (reg val))
  (assign val (const lambda))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch751))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch752))
compiled-branch753
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch752
  (save continue)
  (goto (reg compapp))
primitive-branch751
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call754
after-lambda746
  (perform (op define-variable!) (const make-lambda) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry755) (reg env))
  (goto (label after-lambda756))
entry755
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
  (assign val (const if))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch757))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch758))
compiled-branch759
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch758
  (save continue)
  (goto (reg compapp))
primitive-branch757
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call760
after-lambda756
  (perform (op define-variable!) (const if?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry761) (reg env))
  (goto (label after-lambda762))
entry761
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cadr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch763))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch764))
compiled-branch765
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch764
  (save continue)
  (goto (reg compapp))
primitive-branch763
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call766
after-lambda762
  (perform (op define-variable!) (const if-predicate) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry767) (reg env))
  (goto (label after-lambda768))
entry767
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const caddr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch769))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch770))
compiled-branch771
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch770
  (save continue)
  (goto (reg compapp))
primitive-branch769
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call772
after-lambda768
  (perform (op define-variable!) (const if-consequent) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry773) (reg env))
  (goto (label after-lambda774))
entry773
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const not) (reg env))
  (save proc)
  (assign proc (op lookup-variable-value) (const null?) (reg env))
  (save proc)
  (assign proc (op lookup-variable-value) (const cdddr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch778))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch779))
compiled-branch780
  (assign continue (label after-call781))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch779
  (assign continue (label after-call781))
  (save continue)
  (goto (reg compapp))
primitive-branch778
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call781
  (assign argl (op list) (reg val))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch782))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch783))
compiled-branch784
  (assign continue (label after-call785))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch783
  (assign continue (label after-call785))
  (save continue)
  (goto (reg compapp))
primitive-branch782
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call785
  (assign argl (op list) (reg val))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch786))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch787))
compiled-branch788
  (assign continue (label after-call789))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch787
  (assign continue (label after-call789))
  (save continue)
  (goto (reg compapp))
primitive-branch786
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call789
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch776))
true-branch775
  (assign proc (op lookup-variable-value) (const cadddr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch790))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch791))
compiled-branch792
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch791
  (save continue)
  (goto (reg compapp))
primitive-branch790
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call793
false-branch776
  (assign val (const false))
  (goto (reg continue))
after-if777
after-lambda774
  (perform (op define-variable!) (const if-alternative) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry794) (reg env))
  (goto (label after-lambda795))
entry794
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (predicate consequent alternative)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (assign val (op lexical-address-lookup) (const (0 2)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (const if))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch796))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch797))
compiled-branch798
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch797
  (save continue)
  (goto (reg compapp))
primitive-branch796
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call799
after-lambda795
  (perform (op define-variable!) (const make-if) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry800) (reg env))
  (goto (label after-lambda801))
entry800
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
  (assign val (const begin))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch802))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch803))
compiled-branch804
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch803
  (save continue)
  (goto (reg compapp))
primitive-branch802
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call805
after-lambda801
  (perform (op define-variable!) (const begin?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry806) (reg env))
  (goto (label after-lambda807))
entry806
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cdr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch808))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch809))
compiled-branch810
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch809
  (save continue)
  (goto (reg compapp))
primitive-branch808
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call811
after-lambda807
  (perform (op define-variable!) (const begin-actions) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry812) (reg env))
  (goto (label after-lambda813))
entry812
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const null?) (reg env))
  (save continue)
  (save proc)
  (assign proc (op lookup-variable-value) (const cdr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch814))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch815))
compiled-branch816
  (assign continue (label after-call817))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch815
  (assign continue (label after-call817))
  (save continue)
  (goto (reg compapp))
primitive-branch814
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call817
  (assign argl (op list) (reg val))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch818))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch819))
compiled-branch820
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch819
  (save continue)
  (goto (reg compapp))
primitive-branch818
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call821
after-lambda813
  (perform (op define-variable!) (const last-exp?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry822) (reg env))
  (goto (label after-lambda823))
entry822
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const car) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch824))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch825))
compiled-branch826
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch825
  (save continue)
  (goto (reg compapp))
primitive-branch824
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call827
after-lambda823
  (perform (op define-variable!) (const first-exp) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry828) (reg env))
  (goto (label after-lambda829))
entry828
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cdr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch830))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch831))
compiled-branch832
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch831
  (save continue)
  (goto (reg compapp))
primitive-branch830
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call833
after-lambda829
  (perform (op define-variable!) (const rest-exps) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry834) (reg env))
  (goto (label after-lambda835))
entry834
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (seq)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const null?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch839))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch840))
compiled-branch841
  (assign continue (label after-call842))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch840
  (assign continue (label after-call842))
  (save continue)
  (goto (reg compapp))
primitive-branch839
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call842
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch837))
true-branch836
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (goto (reg continue))
false-branch837
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const last-exp?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch846))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch847))
compiled-branch848
  (assign continue (label after-call849))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch847
  (assign continue (label after-call849))
  (save continue)
  (goto (reg compapp))
primitive-branch846
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call849
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch844))
true-branch843
  (assign proc (op lookup-variable-value) (const first-exp) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch850))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch851))
compiled-branch852
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch851
  (save continue)
  (goto (reg compapp))
primitive-branch850
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call853
false-branch844
  (assign proc (op lookup-variable-value) (const make-begin) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch854))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch855))
compiled-branch856
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch855
  (save continue)
  (goto (reg compapp))
primitive-branch854
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call857
after-if845
after-if838
after-lambda835
  (perform (op define-variable!) (const sequence->exp) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry858) (reg env))
  (goto (label after-lambda859))
entry858
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (seq)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cons) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const begin))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch860))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch861))
compiled-branch862
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch861
  (save continue)
  (goto (reg compapp))
primitive-branch860
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call863
after-lambda859
  (perform (op define-variable!) (const make-begin) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry864) (reg env))
  (goto (label after-lambda865))
entry864
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const pair?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch866))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch867))
compiled-branch868
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch867
  (save continue)
  (goto (reg compapp))
primitive-branch866
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call869
after-lambda865
  (perform (op define-variable!) (const application?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry870) (reg env))
  (goto (label after-lambda871))
entry870
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const car) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch872))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch873))
compiled-branch874
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch873
  (save continue)
  (goto (reg compapp))
primitive-branch872
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call875
after-lambda871
  (perform (op define-variable!) (const operator) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry876) (reg env))
  (goto (label after-lambda877))
entry876
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cdr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch878))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch879))
compiled-branch880
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch879
  (save continue)
  (goto (reg compapp))
primitive-branch878
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call881
after-lambda877
  (perform (op define-variable!) (const operands) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry882) (reg env))
  (goto (label after-lambda883))
entry882
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (ops)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const null?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch884))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch885))
compiled-branch886
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch885
  (save continue)
  (goto (reg compapp))
primitive-branch884
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call887
after-lambda883
  (perform (op define-variable!) (const no-operands?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry888) (reg env))
  (goto (label after-lambda889))
entry888
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (ops)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const car) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch890))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch891))
compiled-branch892
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch891
  (save continue)
  (goto (reg compapp))
primitive-branch890
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call893
after-lambda889
  (perform (op define-variable!) (const first-operand) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry894) (reg env))
  (goto (label after-lambda895))
entry894
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (ops)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cdr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch896))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch897))
compiled-branch898
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch897
  (save continue)
  (goto (reg compapp))
primitive-branch896
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call899
after-lambda895
  (perform (op define-variable!) (const rest-operands) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry900) (reg env))
  (goto (label after-lambda901))
entry900
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (proc arguments)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cons) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch902))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch903))
compiled-branch904
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch903
  (save continue)
  (goto (reg compapp))
primitive-branch902
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call905
after-lambda901
  (perform (op define-variable!) (const make-application) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry906) (reg env))
  (goto (label after-lambda907))
entry906
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
  (assign val (const cond))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch908))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch909))
compiled-branch910
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch909
  (save continue)
  (goto (reg compapp))
primitive-branch908
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call911
after-lambda907
  (perform (op define-variable!) (const cond?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry912) (reg env))
  (goto (label after-lambda913))
entry912
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cdr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch914))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch915))
compiled-branch916
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch915
  (save continue)
  (goto (reg compapp))
primitive-branch914
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call917
after-lambda913
  (perform (op define-variable!) (const cond-clauses) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry918) (reg env))
  (goto (label after-lambda919))
entry918
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (clause)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const eq?) (reg env))
  (save continue)
  (save proc)
  (assign val (const else))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const cond-predicate) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch920))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch921))
compiled-branch922
  (assign continue (label after-call923))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch921
  (assign continue (label after-call923))
  (save continue)
  (goto (reg compapp))
primitive-branch920
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call923
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch924))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch925))
compiled-branch926
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch925
  (save continue)
  (goto (reg compapp))
primitive-branch924
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call927
after-lambda919
  (perform (op define-variable!) (const cond-else-clause?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry928) (reg env))
  (goto (label after-lambda929))
entry928
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (clause)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const car) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch930))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch931))
compiled-branch932
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch931
  (save continue)
  (goto (reg compapp))
primitive-branch930
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call933
after-lambda929
  (perform (op define-variable!) (const cond-predicate) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry934) (reg env))
  (goto (label after-lambda935))
entry934
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (clause)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cdr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch936))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch937))
compiled-branch938
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch937
  (save continue)
  (goto (reg compapp))
primitive-branch936
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call939
after-lambda935
  (perform (op define-variable!) (const cond-actions) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry940) (reg env))
  (goto (label after-lambda941))
entry940
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const expand-clauses) (reg env))
  (save continue)
  (save proc)
  (assign proc (op lookup-variable-value) (const cond-clauses) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch942))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch943))
compiled-branch944
  (assign continue (label after-call945))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch943
  (assign continue (label after-call945))
  (save continue)
  (goto (reg compapp))
primitive-branch942
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call945
  (assign argl (op list) (reg val))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch946))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch947))
compiled-branch948
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch947
  (save continue)
  (goto (reg compapp))
primitive-branch946
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call949
after-lambda941
  (perform (op define-variable!) (const cond->if) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry950) (reg env))
  (goto (label after-lambda951))
entry950
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (clauses)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const null?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch955))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch956))
compiled-branch957
  (assign continue (label after-call958))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch956
  (assign continue (label after-call958))
  (save continue)
  (goto (reg compapp))
primitive-branch955
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call958
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch953))
true-branch952
  (assign val (const false))
  (goto (reg continue))
false-branch953
  (assign proc (op make-compiled-procedure) (label entry959) (reg env))
  (goto (label after-lambda960))
entry959
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (first rest)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const cond-else-clause?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch964))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch965))
compiled-branch966
  (assign continue (label after-call967))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch965
  (assign continue (label after-call967))
  (save continue)
  (goto (reg compapp))
primitive-branch964
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call967
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch962))
true-branch961
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const null?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch971))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch972))
compiled-branch973
  (assign continue (label after-call974))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch972
  (assign continue (label after-call974))
  (save continue)
  (goto (reg compapp))
primitive-branch971
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call974
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch969))
true-branch968
  (assign proc (op lookup-variable-value) (const sequence->exp) (reg env))
  (save continue)
  (save proc)
  (assign proc (op lookup-variable-value) (const cond-actions) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch975))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch976))
compiled-branch977
  (assign continue (label after-call978))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch976
  (assign continue (label after-call978))
  (save continue)
  (goto (reg compapp))
primitive-branch975
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call978
  (assign argl (op list) (reg val))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch979))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch980))
compiled-branch981
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch980
  (save continue)
  (goto (reg compapp))
primitive-branch979
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call982
false-branch969
  (assign proc (op lookup-variable-value) (const error) (reg env))
  (assign val (op lexical-address-lookup) (const (1 0)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const ELSE clause isn't last -- COND->IF))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch983))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch984))
compiled-branch985
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch984
  (save continue)
  (goto (reg compapp))
primitive-branch983
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call986
after-if970
false-branch962
  (assign proc (op lookup-variable-value) (const make-if) (reg env))
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const expand-clauses) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch999))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1000))
compiled-branch1001
  (assign continue (label after-call1002))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1000
  (assign continue (label after-call1002))
  (save continue)
  (goto (reg compapp))
primitive-branch999
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1002
  (assign argl (op list) (reg val))
  (restore env)
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const sequence->exp) (reg env))
  (save proc)
  (assign proc (op lookup-variable-value) (const cond-actions) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch991))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch992))
compiled-branch993
  (assign continue (label after-call994))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch992
  (assign continue (label after-call994))
  (save continue)
  (goto (reg compapp))
primitive-branch991
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call994
  (assign argl (op list) (reg val))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch995))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch996))
compiled-branch997
  (assign continue (label after-call998))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch996
  (assign continue (label after-call998))
  (save continue)
  (goto (reg compapp))
primitive-branch995
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call998
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save argl)
  (assign proc (op lookup-variable-value) (const cond-predicate) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch987))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch988))
compiled-branch989
  (assign continue (label after-call990))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch988
  (assign continue (label after-call990))
  (save continue)
  (goto (reg compapp))
primitive-branch987
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call990
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1003))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1004))
compiled-branch1005
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1004
  (save continue)
  (goto (reg compapp))
primitive-branch1003
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1006
after-if963
after-lambda960
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const cdr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1011))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1012))
compiled-branch1013
  (assign continue (label after-call1014))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1012
  (assign continue (label after-call1014))
  (save continue)
  (goto (reg compapp))
primitive-branch1011
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1014
  (assign argl (op list) (reg val))
  (restore env)
  (save argl)
  (assign proc (op lookup-variable-value) (const car) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1007))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1008))
compiled-branch1009
  (assign continue (label after-call1010))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1008
  (assign continue (label after-call1010))
  (save continue)
  (goto (reg compapp))
primitive-branch1007
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1010
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1015))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1016))
compiled-branch1017
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1016
  (save continue)
  (goto (reg compapp))
primitive-branch1015
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1018
after-if954
after-lambda951
  (perform (op define-variable!) (const expand-clauses) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1019) (reg env))
  (goto (label after-lambda1020))
entry1019
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
  (assign val (const let))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1021))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1022))
compiled-branch1023
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1022
  (save continue)
  (goto (reg compapp))
primitive-branch1021
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1024
after-lambda1020
  (perform (op define-variable!) (const let?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1025) (reg env))
  (goto (label after-lambda1026))
entry1025
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cadr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1027))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1028))
compiled-branch1029
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1028
  (save continue)
  (goto (reg compapp))
primitive-branch1027
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1030
after-lambda1026
  (perform (op define-variable!) (const let-bindings) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1031) (reg env))
  (goto (label after-lambda1032))
entry1031
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const map) (reg env))
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const let-bindings) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1033))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1034))
compiled-branch1035
  (assign continue (label after-call1036))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1034
  (assign continue (label after-call1036))
  (save continue)
  (goto (reg compapp))
primitive-branch1033
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1036
  (assign argl (op list) (reg val))
  (restore env)
  (assign val (op lookup-variable-value) (const car) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1037))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1038))
compiled-branch1039
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1038
  (save continue)
  (goto (reg compapp))
primitive-branch1037
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1040
after-lambda1032
  (perform (op define-variable!) (const let-vars) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1041) (reg env))
  (goto (label after-lambda1042))
entry1041
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const map) (reg env))
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const let-bindings) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1043))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1044))
compiled-branch1045
  (assign continue (label after-call1046))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1044
  (assign continue (label after-call1046))
  (save continue)
  (goto (reg compapp))
primitive-branch1043
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1046
  (assign argl (op list) (reg val))
  (restore env)
  (assign val (op lookup-variable-value) (const cadr) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1047))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1048))
compiled-branch1049
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1048
  (save continue)
  (goto (reg compapp))
primitive-branch1047
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1050
after-lambda1042
  (perform (op define-variable!) (const let-vals) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1051) (reg env))
  (goto (label after-lambda1052))
entry1051
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cddr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1053))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1054))
compiled-branch1055
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1054
  (save continue)
  (goto (reg compapp))
primitive-branch1053
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1056
after-lambda1052
  (perform (op define-variable!) (const let-body) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1057) (reg env))
  (goto (label after-lambda1058))
entry1057
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op make-compiled-procedure) (label entry1059) (reg env))
  (goto (label after-lambda1060))
entry1059
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (vars vals)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const make-application) (reg env))
  (save continue)
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const make-lambda) (reg env))
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const let-body) (reg env))
  (assign val (op lexical-address-lookup) (const (1 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1061))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1062))
compiled-branch1063
  (assign continue (label after-call1064))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1062
  (assign continue (label after-call1064))
  (save continue)
  (goto (reg compapp))
primitive-branch1061
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1064
  (assign argl (op list) (reg val))
  (restore env)
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1065))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1066))
compiled-branch1067
  (assign continue (label after-call1068))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1066
  (assign continue (label after-call1068))
  (save continue)
  (goto (reg compapp))
primitive-branch1065
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1068
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1069))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1070))
compiled-branch1071
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1070
  (save continue)
  (goto (reg compapp))
primitive-branch1069
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1072
after-lambda1060
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const let-vals) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1077))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1078))
compiled-branch1079
  (assign continue (label after-call1080))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1078
  (assign continue (label after-call1080))
  (save continue)
  (goto (reg compapp))
primitive-branch1077
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1080
  (assign argl (op list) (reg val))
  (restore env)
  (save argl)
  (assign proc (op lookup-variable-value) (const let-vars) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1073))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1074))
compiled-branch1075
  (assign continue (label after-call1076))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1074
  (assign continue (label after-call1076))
  (save continue)
  (goto (reg compapp))
primitive-branch1073
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1076
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1081))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1082))
compiled-branch1083
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1082
  (save continue)
  (goto (reg compapp))
primitive-branch1081
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1084
after-lambda1058
  (perform (op define-variable!) (const let->combination) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1085) (reg env))
  (goto (label after-lambda1086))
entry1085
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (bindings body)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cons) (reg env))
  (save continue)
  (save proc)
  (assign proc (op lookup-variable-value) (const cons) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1087))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1088))
compiled-branch1089
  (assign continue (label after-call1090))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1088
  (assign continue (label after-call1090))
  (save continue)
  (goto (reg compapp))
primitive-branch1087
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1090
  (assign argl (op list) (reg val))
  (assign val (const let))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1091))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1092))
compiled-branch1093
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1092
  (save continue)
  (goto (reg compapp))
primitive-branch1091
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1094
after-lambda1086
  (perform (op define-variable!) (const make-let) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1095) (reg env))
  (goto (label after-lambda1096))
entry1095
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
  (assign val (const and))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1097))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1098))
compiled-branch1099
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1098
  (save continue)
  (goto (reg compapp))
primitive-branch1097
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1100
after-lambda1096
  (perform (op define-variable!) (const and?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1101) (reg env))
  (goto (label after-lambda1102))
entry1101
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cdr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1103))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1104))
compiled-branch1105
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1104
  (save continue)
  (goto (reg compapp))
primitive-branch1103
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1106
after-lambda1102
  (perform (op define-variable!) (const and-predicates) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1107) (reg env))
  (goto (label after-lambda1108))
entry1107
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const expand-and-predicates) (reg env))
  (save continue)
  (save proc)
  (assign proc (op lookup-variable-value) (const and-predicates) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1109))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1110))
compiled-branch1111
  (assign continue (label after-call1112))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1110
  (assign continue (label after-call1112))
  (save continue)
  (goto (reg compapp))
primitive-branch1109
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1112
  (assign argl (op list) (reg val))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1113))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1114))
compiled-branch1115
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1114
  (save continue)
  (goto (reg compapp))
primitive-branch1113
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1116
after-lambda1108
  (perform (op define-variable!) (const and->if) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1117) (reg env))
  (goto (label after-lambda1118))
entry1117
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (preds)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const null?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1122))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1123))
compiled-branch1124
  (assign continue (label after-call1125))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1123
  (assign continue (label after-call1125))
  (save continue)
  (goto (reg compapp))
primitive-branch1122
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1125
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch1120))
true-branch1119
  (assign val (const true))
  (goto (reg continue))
false-branch1120
  (assign proc (op make-compiled-procedure) (label entry1126) (reg env))
  (goto (label after-lambda1127))
entry1126
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (first rest)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const null?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1131))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1132))
compiled-branch1133
  (assign continue (label after-call1134))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1132
  (assign continue (label after-call1134))
  (save continue)
  (goto (reg compapp))
primitive-branch1131
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1134
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch1129))
true-branch1128
  (assign proc (op lookup-variable-value) (const make-if) (reg env))
  (assign val (const false))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1135))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1136))
compiled-branch1137
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1136
  (save continue)
  (goto (reg compapp))
primitive-branch1135
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1138
false-branch1129
  (assign proc (op lookup-variable-value) (const make-if) (reg env))
  (save continue)
  (save proc)
  (assign val (const false))
  (assign argl (op list) (reg val))
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const expand-and-predicates) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1139))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1140))
compiled-branch1141
  (assign continue (label after-call1142))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1140
  (assign continue (label after-call1142))
  (save continue)
  (goto (reg compapp))
primitive-branch1139
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1142
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1143))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1144))
compiled-branch1145
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1144
  (save continue)
  (goto (reg compapp))
primitive-branch1143
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1146
after-if1130
after-lambda1127
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const cdr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1151))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1152))
compiled-branch1153
  (assign continue (label after-call1154))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1152
  (assign continue (label after-call1154))
  (save continue)
  (goto (reg compapp))
primitive-branch1151
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1154
  (assign argl (op list) (reg val))
  (restore env)
  (save argl)
  (assign proc (op lookup-variable-value) (const car) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1147))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1148))
compiled-branch1149
  (assign continue (label after-call1150))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1148
  (assign continue (label after-call1150))
  (save continue)
  (goto (reg compapp))
primitive-branch1147
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1150
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1155))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1156))
compiled-branch1157
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1156
  (save continue)
  (goto (reg compapp))
primitive-branch1155
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1158
after-if1121
after-lambda1118
  (perform (op define-variable!) (const expand-and-predicates) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1159) (reg env))
  (goto (label after-lambda1160))
entry1159
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const tagged-list?) (reg env))
  (assign val (const or))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1161))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1162))
compiled-branch1163
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1162
  (save continue)
  (goto (reg compapp))
primitive-branch1161
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1164
after-lambda1160
  (perform (op define-variable!) (const or?) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1165) (reg env))
  (goto (label after-lambda1166))
entry1165
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cdr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1167))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1168))
compiled-branch1169
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1168
  (save continue)
  (goto (reg compapp))
primitive-branch1167
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1170
after-lambda1166
  (perform (op define-variable!) (const or-predicates) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1171) (reg env))
  (goto (label after-lambda1172))
entry1171
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (exp)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const expand-or-predicates) (reg env))
  (save continue)
  (save proc)
  (assign proc (op lookup-variable-value) (const or-predicates) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1173))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1174))
compiled-branch1175
  (assign continue (label after-call1176))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1174
  (assign continue (label after-call1176))
  (save continue)
  (goto (reg compapp))
primitive-branch1173
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1176
  (assign argl (op list) (reg val))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1177))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1178))
compiled-branch1179
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1178
  (save continue)
  (goto (reg compapp))
primitive-branch1177
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1180
after-lambda1172
  (perform (op define-variable!) (const or->if) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1181) (reg env))
  (goto (label after-lambda1182))
entry1181
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (preds)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const null?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1186))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1187))
compiled-branch1188
  (assign continue (label after-call1189))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1187
  (assign continue (label after-call1189))
  (save continue)
  (goto (reg compapp))
primitive-branch1186
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1189
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch1184))
true-branch1183
  (assign val (const false))
  (goto (reg continue))
false-branch1184
  (assign proc (op lookup-variable-value) (const make-if) (reg env))
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const expand-or-predicates) (reg env))
  (save proc)
  (assign proc (op lookup-variable-value) (const cdr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1198))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1199))
compiled-branch1200
  (assign continue (label after-call1201))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1199
  (assign continue (label after-call1201))
  (save continue)
  (goto (reg compapp))
primitive-branch1198
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1201
  (assign argl (op list) (reg val))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1202))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1203))
compiled-branch1204
  (assign continue (label after-call1205))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1203
  (assign continue (label after-call1205))
  (save continue)
  (goto (reg compapp))
primitive-branch1202
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1205
  (assign argl (op list) (reg val))
  (restore env)
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const car) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1194))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1195))
compiled-branch1196
  (assign continue (label after-call1197))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1195
  (assign continue (label after-call1197))
  (save continue)
  (goto (reg compapp))
primitive-branch1194
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1197
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save argl)
  (assign proc (op lookup-variable-value) (const car) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1190))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1191))
compiled-branch1192
  (assign continue (label after-call1193))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1191
  (assign continue (label after-call1193))
  (save continue)
  (goto (reg compapp))
primitive-branch1190
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1193
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1206))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1207))
compiled-branch1208
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1207
  (save continue)
  (goto (reg compapp))
primitive-branch1206
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1209
after-if1185
after-lambda1182
  (perform (op define-variable!) (const expand-or-predicates) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1210) (reg env))
  (goto (label after-lambda1211))
entry1210
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (env)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cdr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1212))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1213))
compiled-branch1214
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1213
  (save continue)
  (goto (reg compapp))
primitive-branch1212
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1215
after-lambda1211
  (perform (op define-variable!) (const enclosing-environment) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1216) (reg env))
  (goto (label after-lambda1217))
entry1216
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (env)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const car) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1218))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1219))
compiled-branch1220
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1219
  (save continue)
  (goto (reg compapp))
primitive-branch1218
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1221
after-lambda1217
  (perform (op define-variable!) (const first-frame) (reg val) (reg env))
  (assign val (const ok))
  (assign val (const ()))
  (perform (op define-variable!) (const the-empty-environment) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1222) (reg env))
  (goto (label after-lambda1223))
entry1222
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (variables values)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cons) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1224))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1225))
compiled-branch1226
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1225
  (save continue)
  (goto (reg compapp))
primitive-branch1224
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1227
after-lambda1223
  (perform (op define-variable!) (const make-frame) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1228) (reg env))
  (goto (label after-lambda1229))
entry1228
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (frame)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const car) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1230))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1231))
compiled-branch1232
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1231
  (save continue)
  (goto (reg compapp))
primitive-branch1230
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1233
after-lambda1229
  (perform (op define-variable!) (const frame-variables) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1234) (reg env))
  (goto (label after-lambda1235))
entry1234
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (frame)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const cdr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1236))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1237))
compiled-branch1238
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1237
  (save continue)
  (goto (reg compapp))
primitive-branch1236
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1239
after-lambda1235
  (perform (op define-variable!) (const frame-values) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1240) (reg env))
  (goto (label after-lambda1241))
entry1240
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (var val frame)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const set-car!) (reg env))
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const cons) (reg env))
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const car) (reg env))
  (assign val (op lexical-address-lookup) (const (0 2)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1242))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1243))
compiled-branch1244
  (assign continue (label after-call1245))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1243
  (assign continue (label after-call1245))
  (save continue)
  (goto (reg compapp))
primitive-branch1242
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1245
  (assign argl (op list) (reg val))
  (restore env)
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1246))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1247))
compiled-branch1248
  (assign continue (label after-call1249))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1247
  (assign continue (label after-call1249))
  (save continue)
  (goto (reg compapp))
primitive-branch1246
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1249
  (assign argl (op list) (reg val))
  (restore env)
  (assign val (op lexical-address-lookup) (const (0 2)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1250))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1251))
compiled-branch1252
  (assign continue (label after-call1253))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1251
  (assign continue (label after-call1253))
  (save continue)
  (goto (reg compapp))
primitive-branch1250
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1253
  (restore env)
  (restore continue)
  (assign proc (op lookup-variable-value) (const set-cdr!) (reg env))
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const cons) (reg env))
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const cdr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 2)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1254))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1255))
compiled-branch1256
  (assign continue (label after-call1257))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1255
  (assign continue (label after-call1257))
  (save continue)
  (goto (reg compapp))
primitive-branch1254
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1257
  (assign argl (op list) (reg val))
  (restore env)
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1258))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1259))
compiled-branch1260
  (assign continue (label after-call1261))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1259
  (assign continue (label after-call1261))
  (save continue)
  (goto (reg compapp))
primitive-branch1258
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1261
  (assign argl (op list) (reg val))
  (restore env)
  (assign val (op lexical-address-lookup) (const (0 2)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1262))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1263))
compiled-branch1264
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1263
  (save continue)
  (goto (reg compapp))
primitive-branch1262
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1265
after-lambda1241
  (perform (op define-variable!) (const add-binding-to-frame!) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1266) (reg env))
  (goto (label after-lambda1267))
entry1266
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (vars vals base-env)) (reg argl) (reg env))
  (save continue)
  (save env)
  (save env)
  (assign proc (op lookup-variable-value) (const length) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1271))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1272))
compiled-branch1273
  (assign continue (label proc-return1275))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
proc-return1275
  (assign arg1 (reg val))
  (goto (label after-call1274))
compound-branch1272
  (assign continue (label proc-return1276))
  (save continue)
  (goto (reg compapp))
proc-return1276
  (assign arg1 (reg val))
  (goto (label after-call1274))
primitive-branch1271
  (assign arg1 (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1274
  (restore env)
  (assign proc (op lookup-variable-value) (const length) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1277))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1278))
compiled-branch1279
  (assign continue (label proc-return1281))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
proc-return1281
  (assign arg2 (reg val))
  (goto (label after-call1280))
compound-branch1278
  (assign continue (label proc-return1282))
  (save continue)
  (goto (reg compapp))
proc-return1282
  (assign arg2 (reg val))
  (goto (label after-call1280))
primitive-branch1277
  (assign arg2 (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1280
  (assign val (op =) (reg arg1) (reg arg2))
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch1269))
true-branch1268
  (assign proc (op lookup-variable-value) (const cons) (reg env))
  (save continue)
  (save proc)
  (assign val (op lexical-address-lookup) (const (0 2)) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const make-frame) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1283))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1284))
compiled-branch1285
  (assign continue (label after-call1286))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1284
  (assign continue (label after-call1286))
  (save continue)
  (goto (reg compapp))
primitive-branch1283
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1286
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1287))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1288))
compiled-branch1289
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1288
  (save continue)
  (goto (reg compapp))
primitive-branch1287
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1290
false-branch1269
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const <) (reg env))
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const length) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1298))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1299))
compiled-branch1300
  (assign continue (label after-call1301))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1299
  (assign continue (label after-call1301))
  (save continue)
  (goto (reg compapp))
primitive-branch1298
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1301
  (assign argl (op list) (reg val))
  (restore env)
  (save argl)
  (assign proc (op lookup-variable-value) (const length) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1294))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1295))
compiled-branch1296
  (assign continue (label after-call1297))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1295
  (assign continue (label after-call1297))
  (save continue)
  (goto (reg compapp))
primitive-branch1294
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1297
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1302))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1303))
compiled-branch1304
  (assign continue (label after-call1305))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1303
  (assign continue (label after-call1305))
  (save continue)
  (goto (reg compapp))
primitive-branch1302
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1305
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch1292))
true-branch1291
  (assign proc (op lookup-variable-value) (const error) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (const Too many arguments supplied))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1306))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1307))
compiled-branch1308
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1307
  (save continue)
  (goto (reg compapp))
primitive-branch1306
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1309
false-branch1292
  (assign proc (op lookup-variable-value) (const error) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (const Too few arguments supplied))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1310))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1311))
compiled-branch1312
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1311
  (save continue)
  (goto (reg compapp))
primitive-branch1310
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1313
after-if1293
after-if1270
after-lambda1267
  (perform (op define-variable!) (const extend-environment) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1314) (reg env))
  (goto (label after-lambda1315))
entry1314
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (env var var-not-in-frame proc)) (reg argl) (reg env))
  (assign proc (op make-compiled-procedure) (label entry1316) (reg env))
  (goto (label after-lambda1317))
entry1316
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (scan)) (reg argl) (reg env))
  (assign val (op make-compiled-procedure) (label entry1318) (reg env))
  (goto (label after-lambda1319))
entry1318
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (vars vals)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const null?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1323))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1324))
compiled-branch1325
  (assign continue (label after-call1326))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1324
  (assign continue (label after-call1326))
  (save continue)
  (goto (reg compapp))
primitive-branch1323
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1326
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch1321))
true-branch1320
  (assign proc (op lexical-address-lookup) (const (2 2)) (reg env))
  (assign val (op lexical-address-lookup) (const (2 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1327))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1328))
compiled-branch1329
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1328
  (save continue)
  (goto (reg compapp))
primitive-branch1327
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1330
false-branch1321
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const eq?) (reg env))
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const car) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1334))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1335))
compiled-branch1336
  (assign continue (label after-call1337))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1335
  (assign continue (label after-call1337))
  (save continue)
  (goto (reg compapp))
primitive-branch1334
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1337
  (assign argl (op list) (reg val))
  (restore env)
  (assign val (op lexical-address-lookup) (const (2 1)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1338))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1339))
compiled-branch1340
  (assign continue (label after-call1341))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1339
  (assign continue (label after-call1341))
  (save continue)
  (goto (reg compapp))
primitive-branch1338
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1341
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch1332))
true-branch1331
  (assign proc (op lexical-address-lookup) (const (2 3)) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1342))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1343))
compiled-branch1344
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1343
  (save continue)
  (goto (reg compapp))
primitive-branch1342
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1345
false-branch1332
  (assign proc (op lexical-address-lookup) (const (1 0)) (reg env))
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const cdr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 1)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1350))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1351))
compiled-branch1352
  (assign continue (label after-call1353))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1351
  (assign continue (label after-call1353))
  (save continue)
  (goto (reg compapp))
primitive-branch1350
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1353
  (assign argl (op list) (reg val))
  (restore env)
  (save argl)
  (assign proc (op lookup-variable-value) (const cdr) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1346))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1347))
compiled-branch1348
  (assign continue (label after-call1349))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1347
  (assign continue (label after-call1349))
  (save continue)
  (goto (reg compapp))
primitive-branch1346
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1349
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1354))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1355))
compiled-branch1356
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1355
  (save continue)
  (goto (reg compapp))
primitive-branch1354
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1357
after-if1333
after-if1322
after-lambda1319
  (perform (op lexical-address-set!) (const (0 0)) (reg val) (reg env))
  (assign val (const ok))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const eq?) (reg env))
  (assign val (op lookup-variable-value) (const the-empty-environment) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (1 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1361))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1362))
compiled-branch1363
  (assign continue (label after-call1364))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1362
  (assign continue (label after-call1364))
  (save continue)
  (goto (reg compapp))
primitive-branch1361
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1364
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch1359))
true-branch1358
  (assign proc (op lookup-variable-value) (const error) (reg env))
  (assign val (op lexical-address-lookup) (const (1 1)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (const Unbound variable))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1365))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1366))
compiled-branch1367
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1366
  (save continue)
  (goto (reg compapp))
primitive-branch1365
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1368
false-branch1359
  (assign proc (op make-compiled-procedure) (label entry1369) (reg env))
  (goto (label after-lambda1370))
entry1369
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (frame)) (reg argl) (reg env))
  (assign proc (op lexical-address-lookup) (const (1 0)) (reg env))
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const frame-values) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1375))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1376))
compiled-branch1377
  (assign continue (label after-call1378))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1376
  (assign continue (label after-call1378))
  (save continue)
  (goto (reg compapp))
primitive-branch1375
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1378
  (assign argl (op list) (reg val))
  (restore env)
  (save argl)
  (assign proc (op lookup-variable-value) (const frame-variables) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1371))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1372))
compiled-branch1373
  (assign continue (label after-call1374))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1372
  (assign continue (label after-call1374))
  (save continue)
  (goto (reg compapp))
primitive-branch1371
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1374
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1379))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1380))
compiled-branch1381
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1380
  (save continue)
  (goto (reg compapp))
primitive-branch1379
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1382
after-lambda1370
  (save continue)
  (save proc)
  (assign proc (op lookup-variable-value) (const first-frame) (reg env))
  (assign val (op lexical-address-lookup) (const (1 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1383))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1384))
compiled-branch1385
  (assign continue (label after-call1386))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1384
  (assign continue (label after-call1386))
  (save continue)
  (goto (reg compapp))
primitive-branch1383
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1386
  (assign argl (op list) (reg val))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1387))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1388))
compiled-branch1389
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1388
  (save continue)
  (goto (reg compapp))
primitive-branch1387
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1390
after-if1360
after-lambda1317
  (assign val (const *unassigned*))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1391))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1392))
compiled-branch1393
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1392
  (save continue)
  (goto (reg compapp))
primitive-branch1391
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1394
after-lambda1315
  (perform (op define-variable!) (const env-loop) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1395) (reg env))
  (goto (label after-lambda1396))
entry1395
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (var env)) (reg argl) (reg env))
  (assign proc (op make-compiled-procedure) (label entry1397) (reg env))
  (goto (label after-lambda1398))
entry1397
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (var-not-in-frame)) (reg argl) (reg env))
  (assign val (op make-compiled-procedure) (label entry1399) (reg env))
  (goto (label after-lambda1400))
entry1399
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (env)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const lookup-variable-value) (reg env))
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const enclosing-environment) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1401))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1402))
compiled-branch1403
  (assign continue (label after-call1404))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1402
  (assign continue (label after-call1404))
  (save continue)
  (goto (reg compapp))
primitive-branch1401
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1404
  (assign argl (op list) (reg val))
  (restore env)
  (assign val (op lexical-address-lookup) (const (2 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1405))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1406))
compiled-branch1407
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1406
  (save continue)
  (goto (reg compapp))
primitive-branch1405
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1408
after-lambda1400
  (perform (op lexical-address-set!) (const (0 0)) (reg val) (reg env))
  (assign val (const ok))
  (assign proc (op lookup-variable-value) (const env-loop) (reg env))
  (assign val (op lookup-variable-value) (const car) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (op lexical-address-lookup) (const (1 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (op lexical-address-lookup) (const (1 1)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1409))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1410))
compiled-branch1411
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1410
  (save continue)
  (goto (reg compapp))
primitive-branch1409
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1412
after-lambda1398
  (assign val (const *unassigned*))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1413))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1414))
compiled-branch1415
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1414
  (save continue)
  (goto (reg compapp))
primitive-branch1413
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1416
after-lambda1396
  (perform (op define-variable!) (const lookup-variable-value) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1417) (reg env))
  (goto (label after-lambda1418))
entry1417
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (val)) (reg argl) (reg env))
  (assign val (op make-compiled-procedure) (label entry1419) (reg env))
  (goto (reg continue))
entry1419
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (vals)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const set-car!) (reg env))
  (assign val (op lexical-address-lookup) (const (1 0)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1421))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1422))
compiled-branch1423
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1422
  (save continue)
  (goto (reg compapp))
primitive-branch1421
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1424
after-lambda1420
after-lambda1418
  (perform (op define-variable!) (const set-val!) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1425) (reg env))
  (goto (label after-lambda1426))
entry1425
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (var val env)) (reg argl) (reg env))
  (assign proc (op make-compiled-procedure) (label entry1427) (reg env))
  (goto (label after-lambda1428))
entry1427
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (var-not-in-frame)) (reg argl) (reg env))
  (assign val (op make-compiled-procedure) (label entry1429) (reg env))
  (goto (label after-lambda1430))
entry1429
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (env)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const set-variable-value!) (reg env))
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const enclosing-environment) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1431))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1432))
compiled-branch1433
  (assign continue (label after-call1434))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1432
  (assign continue (label after-call1434))
  (save continue)
  (goto (reg compapp))
primitive-branch1431
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1434
  (assign argl (op list) (reg val))
  (restore env)
  (assign val (op lexical-address-lookup) (const (2 1)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (op lexical-address-lookup) (const (2 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1435))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1436))
compiled-branch1437
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1436
  (save continue)
  (goto (reg compapp))
primitive-branch1435
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1438
after-lambda1430
  (perform (op lexical-address-set!) (const (0 0)) (reg val) (reg env))
  (assign val (const ok))
  (assign proc (op lookup-variable-value) (const env-loop) (reg env))
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const set-val!) (reg env))
  (assign val (op lexical-address-lookup) (const (1 1)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1439))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1440))
compiled-branch1441
  (assign continue (label after-call1442))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1440
  (assign continue (label after-call1442))
  (save continue)
  (goto (reg compapp))
primitive-branch1439
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1442
  (assign argl (op list) (reg val))
  (restore env)
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (op lexical-address-lookup) (const (1 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (op lexical-address-lookup) (const (1 2)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1443))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1444))
compiled-branch1445
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1444
  (save continue)
  (goto (reg compapp))
primitive-branch1443
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1446
after-lambda1428
  (assign val (const *unassigned*))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1447))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1448))
compiled-branch1449
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1448
  (save continue)
  (goto (reg compapp))
primitive-branch1447
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1450
after-lambda1426
  (perform (op define-variable!) (const set-variable-value!) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1451) (reg env))
  (goto (label after-lambda1452))
entry1451
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (var val env)) (reg argl) (reg env))
  (assign proc (op make-compiled-procedure) (label entry1453) (reg env))
  (goto (label after-lambda1454))
entry1453
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (var-not-in-frame)) (reg argl) (reg env))
  (assign val (op make-compiled-procedure) (label entry1455) (reg env))
  (goto (label after-lambda1456))
entry1455
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (env)) (reg argl) (reg env))
  (assign proc (op lookup-variable-value) (const add-binding-to-frame!) (reg env))
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const first-frame) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1457))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1458))
compiled-branch1459
  (assign continue (label after-call1460))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1458
  (assign continue (label after-call1460))
  (save continue)
  (goto (reg compapp))
primitive-branch1457
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1460
  (assign argl (op list) (reg val))
  (restore env)
  (assign val (op lexical-address-lookup) (const (2 1)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (op lexical-address-lookup) (const (2 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1461))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1462))
compiled-branch1463
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1462
  (save continue)
  (goto (reg compapp))
primitive-branch1461
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1464
after-lambda1456
  (perform (op lexical-address-set!) (const (0 0)) (reg val) (reg env))
  (assign val (const ok))
  (assign proc (op lookup-variable-value) (const env-loop) (reg env))
  (save continue)
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const set-val!) (reg env))
  (assign val (op lexical-address-lookup) (const (1 1)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1465))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1466))
compiled-branch1467
  (assign continue (label after-call1468))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1466
  (assign continue (label after-call1468))
  (save continue)
  (goto (reg compapp))
primitive-branch1465
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1468
  (assign argl (op list) (reg val))
  (restore env)
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (op lexical-address-lookup) (const (1 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (op lexical-address-lookup) (const (1 2)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1469))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1470))
compiled-branch1471
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1470
  (save continue)
  (goto (reg compapp))
primitive-branch1469
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1472
after-lambda1454
  (assign val (const *unassigned*))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1473))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1474))
compiled-branch1475
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1474
  (save continue)
  (goto (reg compapp))
primitive-branch1473
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1476
after-lambda1452
  (perform (op define-variable!) (const define-variable!) (reg val) (reg env))
  (assign val (const ok))
  (assign val (const ">>> M-Eval input:"))
  (perform (op define-variable!) (const input-prompt) (reg val) (reg env))
  (assign val (const ok))
  (assign val (const ">>> M-Eval value:"))
  (perform (op define-variable!) (const output-prompt) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1477) (reg env))
  (goto (label after-lambda1478))
entry1477
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const ()) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const prompt-for-input) (reg env))
  (assign val (op lookup-variable-value) (const input-prompt) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1479))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1480))
compiled-branch1481
  (assign continue (label after-call1482))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1480
  (assign continue (label after-call1482))
  (save continue)
  (goto (reg compapp))
primitive-branch1479
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1482
  (restore env)
  (restore continue)
  (save continue)
  (save env)
  (assign proc (op make-compiled-procedure) (label entry1483) (reg env))
  (goto (label after-lambda1484))
entry1483
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (input)) (reg argl) (reg env))
  (assign proc (op make-compiled-procedure) (label entry1485) (reg env))
  (goto (label after-lambda1486))
entry1485
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (output)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const announce-output) (reg env))
  (assign val (op lookup-variable-value) (const output-prompt) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1487))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1488))
compiled-branch1489
  (assign continue (label after-call1490))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1488
  (assign continue (label after-call1490))
  (save continue)
  (goto (reg compapp))
primitive-branch1487
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1490
  (restore env)
  (restore continue)
  (assign proc (op lookup-variable-value) (const user-print) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1491))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1492))
compiled-branch1493
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1492
  (save continue)
  (goto (reg compapp))
primitive-branch1491
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1494
after-lambda1486
  (save continue)
  (save proc)
  (assign proc (op lookup-variable-value) (const eval) (reg env))
  (assign val (op lookup-variable-value) (const the-global-environment) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1495))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1496))
compiled-branch1497
  (assign continue (label after-call1498))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1496
  (assign continue (label after-call1498))
  (save continue)
  (goto (reg compapp))
primitive-branch1495
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1498
  (assign argl (op list) (reg val))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1499))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1500))
compiled-branch1501
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1500
  (save continue)
  (goto (reg compapp))
primitive-branch1499
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1502
after-lambda1484
  (save proc)
  (assign proc (op lookup-variable-value) (const read) (reg env))
  (assign argl (const ()))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1503))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1504))
compiled-branch1505
  (assign continue (label after-call1506))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1504
  (assign continue (label after-call1506))
  (save continue)
  (goto (reg compapp))
primitive-branch1503
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1506
  (assign argl (op list) (reg val))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1507))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1508))
compiled-branch1509
  (assign continue (label after-call1510))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1508
  (assign continue (label after-call1510))
  (save continue)
  (goto (reg compapp))
primitive-branch1507
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1510
  (restore env)
  (restore continue)
  (assign proc (op lookup-variable-value) (const driver-loop) (reg env))
  (assign argl (const ()))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1511))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1512))
compiled-branch1513
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1512
  (save continue)
  (goto (reg compapp))
primitive-branch1511
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1514
after-lambda1478
  (perform (op define-variable!) (const driver-loop) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1515) (reg env))
  (goto (label after-lambda1516))
entry1515
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (string)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const newline) (reg env))
  (assign argl (const ()))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1517))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1518))
compiled-branch1519
  (assign continue (label after-call1520))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1518
  (assign continue (label after-call1520))
  (save continue)
  (goto (reg compapp))
primitive-branch1517
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1520
  (restore env)
  (restore continue)
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const newline) (reg env))
  (assign argl (const ()))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1521))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1522))
compiled-branch1523
  (assign continue (label after-call1524))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1522
  (assign continue (label after-call1524))
  (save continue)
  (goto (reg compapp))
primitive-branch1521
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1524
  (restore env)
  (restore continue)
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const display) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1525))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1526))
compiled-branch1527
  (assign continue (label after-call1528))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1526
  (assign continue (label after-call1528))
  (save continue)
  (goto (reg compapp))
primitive-branch1525
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1528
  (restore env)
  (restore continue)
  (assign proc (op lookup-variable-value) (const newline) (reg env))
  (assign argl (const ()))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1529))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1530))
compiled-branch1531
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1530
  (save continue)
  (goto (reg compapp))
primitive-branch1529
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1532
after-lambda1516
  (perform (op define-variable!) (const prompt-for-input) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1533) (reg env))
  (goto (label after-lambda1534))
entry1533
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (string)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const newline) (reg env))
  (assign argl (const ()))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1535))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1536))
compiled-branch1537
  (assign continue (label after-call1538))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1536
  (assign continue (label after-call1538))
  (save continue)
  (goto (reg compapp))
primitive-branch1535
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1538
  (restore env)
  (restore continue)
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const display) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1539))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1540))
compiled-branch1541
  (assign continue (label after-call1542))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1540
  (assign continue (label after-call1542))
  (save continue)
  (goto (reg compapp))
primitive-branch1539
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1542
  (restore env)
  (restore continue)
  (assign proc (op lookup-variable-value) (const newline) (reg env))
  (assign argl (const ()))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1543))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1544))
compiled-branch1545
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1544
  (save continue)
  (goto (reg compapp))
primitive-branch1543
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1546
after-lambda1534
  (perform (op define-variable!) (const announce-output) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1547) (reg env))
  (goto (label after-lambda1548))
entry1547
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (object)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const compound-procedure?) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1552))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1553))
compiled-branch1554
  (assign continue (label after-call1555))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1553
  (assign continue (label after-call1555))
  (save continue)
  (goto (reg compapp))
primitive-branch1552
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1555
  (restore env)
  (restore continue)
  (test (op false?) (reg val))
  (branch (label false-branch1550))
true-branch1549
  (assign proc (op lookup-variable-value) (const display) (reg env))
  (save continue)
  (save proc)
  (assign proc (op lookup-variable-value) (const list) (reg env))
  (save proc)
  (save env)
  (assign proc (op lookup-variable-value) (const procedure-body) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1560))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1561))
compiled-branch1562
  (assign continue (label after-call1563))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1561
  (assign continue (label after-call1563))
  (save continue)
  (goto (reg compapp))
primitive-branch1560
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1563
  (assign argl (op list) (reg val))
  (restore env)
  (save argl)
  (assign proc (op lookup-variable-value) (const procedure-parameters) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1556))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1557))
compiled-branch1558
  (assign continue (label after-call1559))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1557
  (assign continue (label after-call1559))
  (save continue)
  (goto (reg compapp))
primitive-branch1556
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1559
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (const compound-procedure))
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1564))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1565))
compiled-branch1566
  (assign continue (label after-call1567))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1565
  (assign continue (label after-call1567))
  (save continue)
  (goto (reg compapp))
primitive-branch1564
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1567
  (assign argl (op list) (reg val))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1568))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1569))
compiled-branch1570
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1569
  (save continue)
  (goto (reg compapp))
primitive-branch1568
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1571
false-branch1550
  (assign proc (op lookup-variable-value) (const display) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1572))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1573))
compiled-branch1574
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1573
  (save continue)
  (goto (reg compapp))
primitive-branch1572
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1575
after-if1551
after-lambda1548
  (perform (op define-variable!) (const user-print) (reg val) (reg env))
  (assign val (const ok))
  (assign val (op make-compiled-procedure) (label entry1576) (reg env))
  (goto (label after-lambda1577))
entry1576
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const ()) (reg argl) (reg env))
  (assign proc (op make-compiled-procedure) (label entry1578) (reg env))
  (goto (label after-lambda1579))
entry1578
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (initial-env)) (reg argl) (reg env))
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const define-variable!) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lookup-variable-value) (const true) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (const true))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1580))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1581))
compiled-branch1582
  (assign continue (label after-call1583))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1581
  (assign continue (label after-call1583))
  (save continue)
  (goto (reg compapp))
primitive-branch1580
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1583
  (restore env)
  (restore continue)
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const define-variable!) (reg env))
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (assign argl (op list) (reg val))
  (assign val (op lookup-variable-value) (const false) (reg env))
  (assign argl (op cons) (reg val) (reg argl))
  (assign val (const false))
  (assign argl (op cons) (reg val) (reg argl))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1584))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1585))
compiled-branch1586
  (assign continue (label after-call1587))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1585
  (assign continue (label after-call1587))
  (save continue)
  (goto (reg compapp))
primitive-branch1584
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1587
  (restore env)
  (restore continue)
  (assign val (op lexical-address-lookup) (const (0 0)) (reg env))
  (goto (reg continue))
after-lambda1579
  (save continue)
  (save proc)
  (assign proc (op lookup-variable-value) (const extend-environment) (reg env))
  (save proc)
  (assign val (op lookup-variable-value) (const the-empty-environment) (reg env))
  (assign argl (op list) (reg val))
  (save env)
  (save argl)
  (assign proc (op lookup-variable-value) (const primitive-procedure-objects) (reg env))
  (assign argl (const ()))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1592))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1593))
compiled-branch1594
  (assign continue (label after-call1595))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1593
  (assign continue (label after-call1595))
  (save continue)
  (goto (reg compapp))
primitive-branch1592
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1595
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore env)
  (save argl)
  (assign proc (op lookup-variable-value) (const primitive-procedure-names) (reg env))
  (assign argl (const ()))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1588))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1589))
compiled-branch1590
  (assign continue (label after-call1591))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1589
  (assign continue (label after-call1591))
  (save continue)
  (goto (reg compapp))
primitive-branch1588
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1591
  (restore argl)
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1596))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1597))
compiled-branch1598
  (assign continue (label after-call1599))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1597
  (assign continue (label after-call1599))
  (save continue)
  (goto (reg compapp))
primitive-branch1596
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1599
  (assign argl (op list) (reg val))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1600))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1601))
compiled-branch1602
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1601
  (save continue)
  (goto (reg compapp))
primitive-branch1600
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (goto (reg continue))
after-call1603
after-lambda1577
  (perform (op define-variable!) (const setup-environment) (reg val) (reg env))
  (assign val (const ok))
  (save env)
  (assign proc (op lookup-variable-value) (const setup-environment) (reg env))
  (assign argl (const ()))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1604))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-branch1605))
compiled-branch1606
  (assign continue (label after-call1607))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
compound-branch1605
  (assign continue (label after-call1607))
  (save continue)
  (goto (reg compapp))
primitive-branch1604
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
after-call1607
  (restore env)
  (perform (op define-variable!) (const the-global-environment) (reg val) (reg env))
  (assign val (const ok))))