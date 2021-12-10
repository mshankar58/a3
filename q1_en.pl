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

:- ale_flag(pscompiling, _, parse_and_gen).
:- ensure_loaded(csc485).
lan(en).
question(q1).

bot sub [cate, sem, agr, number, count, list].
    sem sub [n_sem, v_sem].
        n_sem sub [cat, dog, professor] intro [count:count].
        v_sem sub [see, chase] intro [subj:sem, obj:sem].

    cate sub [nominal, verbal] intro [agr:agr, sem:sem].
        nominal sub [n, np, det, num] intro [sem:n_sem].
        verbal sub [v, vp, s] intro [sem:v_sem, subcat:list].

    % Define your agreement
    agr intro [number:number].
    number sub [sing, plural].

    count sub [one, two, three].

    list sub [e_list, ne_list].
        ne_list intro [hd:bot, tl:list].

% Specifying the semantics for generation.
semantics sem1.
sem1(sem:S, S) if true.

% Define your Lexicons

a ---> (det, sem:count:one, agr:number:sing).
one ---> (num, sem:count:one, agr:number:sing).
two ---> (num, sem:count:two, agr:number:plural).
three ---> (num, sem:count:three, agr:number:plural).
cat ---> (n, sem:cat, agr:number:sing).
cats ---> (n, sem:cat, agr:number:plural).
dog ---> (n, sem:dog, agr:number:sing).
dogs ---> (n, sem:dog, agr:number:plural).
professor ---> (n, sem:professor, agr:number:sing).
professors ---> (n, sem:professor, agr:number:plural).
see ---> (v, sem:(see, subj:Subj, obj:Obj), agr:number:plural, subcat:[Subj, Obj]).
sees ---> (v, sem:see, agr:number:sing, subcat:[Subj, Obj]).
saw ---> (v, sem:see, subcat:[Subj, Obj]).
chase ---> (v, sem:chase, agr:number:plural, subcat:[Subj, Obj]).
chases ---> (v, sem:chase, agr:number:sing, subcat:[Subj, Obj]).

% Define your Rules


np_det rule
(np, sem:(Sem, count:Count), agr:Agr) ===>
cat> (det, sem:count:Count, agr:Agr),
sem_head> (n, sem:Sem, agr:Agr).

np_num rule
(np, sem:(Sem, count:Count), agr:Agr) ===>
cat> (num, sem:count:Count, agr:Agr),
sem_head> (n, sem:Sem, agr:Agr).

vp rule
(vp, sem:Sem, agr:Agr, subcat:(Rest, [_|_])) ===>
sem_head> (v, sem:Sem, agr:Agr, subcat:[Obj|Rest]),
cat> (np, sem:Subj).

s rule
(s, sem:Sem, agr:Agr, subcat:([], Rest)) ===>
cat> (np, agr:Agr),
sem_head> (vp, agr:Agr, subcat:[Subj|Rest]).
