% Student name: Maya Shankar
% Student number: 1005795052
% UTORid: shanka58

% This code is provided solely for the personal and private use of students
% taking the CSC485H/2501H course at the University of Toronto. Copying for
% purposes other than this use is expressly prohibited. All forms of
% distribution of this code, including but not limited to public repositories on
% GitHub, GitLab, Bitbucket, or any other online platform, whether as given or
% with any changes, are expressly prohibited.

% Authors: Jingcheng Niu and Gerald Penn

% All of the files in this directory and all subdirectories are:
% Copyright c 2021 University of Toronto

:- ensure_loaded(csc485).
:- ale_flag(pscompiling, _, parse_and_gen).
lan(en).
question(q2).

bot sub [cat, sem, list, logic, gap_struct, agr].
    cat sub [q, det, gappable, has_sem] intro [logic:logic, qstore:list].
        has_sem sub [n, gappable] intro [sem:sem].
            gappable sub [np, verbal] intro [gap:gap_struct].
                verbal sub [v, vp, s] intro [subcat:list].

    gap_struct sub [none, np].

    sem sub [student, book, read].

    list sub [e_list, ne_list].
        ne_list intro [hd:bot, tl:list].

    logic sub [stmt, nested_logic].
        nested_logic sub [scope, lambda_func] intro [rest:logic].
            lambda_func intro [lambda:logic].
        stmt sub [op, scope, func, var].
            op sub [and, imply] intro [lhs:logic, rhs:logic].
            func intro [func:sem, vars:list].
            scope intro [var:var].
            var sub [forall, exists].

    qelement intro [l:logic, x:logic].

% Lexical entries (incomplete)
every ---> (
    % logic:none,
    % qstore:[]
    q).

a ---> (
    % logic:none,
    % qstore:[]
    q).

book ---> (n,
    % logic:none,
    % qstore:[],
    sem:(book, Book)).

student ---> (n,
    % logic:none,
    % qstore:[],
    sem:(student, Student)).

read ---> (v,
    % logic:none,
    % qstore:[],
    subcat:[], % the subcat list should not be empty
    sem:(read, Read)).

% Phrase structure rules (incomplete)
np rule
    (np) ===>
    cat> (q),
    sem_head> (n).

vp rule
    (vp) ===>
    sem_head> (v),
    cat> (np).

s rule
    (s) ===>
    cat> (np),
    sem_head> (vp).

s_gap rule
    (s) ===>
    cat> (Gap),
    cat> (np),
    sem_head> (vp).

% The empty category:
empty (np, sem:Sem, logic:Logic, qstore:QStore,
    gap:(sem:Sem, logic:Logic, qstore:QStore, gap:none)).

% Helper goals
append([],Xs,Xs) if true.
append([H|T1],L2,[H|T2]) if append(T1,L2,T2).
is_empty([]) if true.

% Beta reduction goal
% beta_reduction(F, X, F(X))
beta_reduction((lambda:X, rest:Result), X, Result) if true.

% Quantifier actions
% A Quantifier action can be either apply or store
quantifier_action(Logic, QStore, NewLogic, NewQStore) if
    apply(Logic, QStore, NewLogic, NewQStore).
quantifier_action(Logic, QStore, NewLogic, NewQStore) if
    store(Logic, QStore, NewLogic, NewQStore).

% Apply, store, and retrieve
apply(Logic, QStore, Logic, QStore) if true.
store(Logic, QStore, (lambda:(F, lambda:X), rest:F), NewQStore) if append([(l:Logic, x:X)], QStore, NewQStore).

retrieve((Empty, []), Logic, Empty, Logic) if true.
retrieve([(l:QLogic, x:X)|T], Logic, T, NewLogic) if beta_reduction(QLogic, (lambda:X, rest:Logic), NewLogic).

% Specifying the semantics for generation.
semantics sem1.
sem1(logic:S, S) if true.
sem1(sem:S, S) if true.

% Some examples
prect_test :- prec([a,student,read,every,book]).
translate_test :- translate([a,student,read,every,book]).
