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
lan(zh).
question(q2).

bot sub [cat, sem, list, logic, gap_struct, agr].
    cat sub [gappable, agreeable, dou] intro [logic:logic, qstore:list].
        gappable sub [verbal, n, np, n_np_vp] intro [gap:gap_struct, sem:sem].
            verbal sub [vp, s, v] intro [subcat:list].

        agreeable sub [cl_agreeable, q_agreeable, n_np_vp] intro [agr:agr].
            cl_agreeable sub [cl, n] intro [agr:cl_agr].
            q_agreeable sub [np_vp, q] intro [agr:q_agr].

        n_np_vp sub [n, np_vp].
            np_vp sub [np, vp].

        n intro [cl:cl].

    agr sub [cl_agr, q_agr].
        cl_agr sub [ge, ben].
        q_agr sub [var].

    gap_struct sub [np, none].

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
% 每: the universal quantifier
mei ---> (q,
    % logic:none,
    % qstore:[],
    agr:forall).

% 一: the existential quantifier
yi ---> (q,
    % logic:none,
    % qstore:[],
    agr:exists).

% 个: the classifier for students
ge ---> (cl, agr:ge).
% 本: the classifier for books
ben ---> (cl, agr:ben).

% 都: the distributive operator
dou ---> dou.

% 书: book
shu ---> (n,
    agr:ben,
    % logic:none,
    % qstore:[],
    sem:(book, Book)).

% 学生: student
xuesheng ---> (n,
    agr:ge,
    % logic:none,
    % qstore:[],
    sem:(student, Student)).

% 读过: read
duguo ---> (v,
    % logic:none,
    % qstore:[],
    subcat:[], % the subcat list should not be empty
    sem:(read, Read)).

% Phrase structure rules (incomplete)
np rule
    (np) ===>
    cat> (q),
    cat> (cl),
    sem_head> (n).

vp rule
    (vp) ===>
    sem_head> (v),
    cat> (np).

dou rule
    (vp) ===>
    cat> (dou),
    sem_head> (vp).

s rule
    (s) ===>
    cat> (np),
    sem_head> (vp).

s_gap rule
    (s) ===>
    cat> (Gap),
    cat> (np),
    sem_head> (vp).

% The empty category
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

% Your helper goals:

% Specifying the semantics for generation.
semantics sem1.
sem1(logic:S, S) if true.
sem1(sem:S, S) if true.

% Some examples
prect_test :- prec([yi,ge,xuesheng,duguo,mei,ben,shu]).
translate_test :- translate([yi,ge,xuesheng,duguo,mei,ben,shu]).
