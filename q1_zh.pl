% Student name: NAME
% Student number: NUMBER
% UTORid: ID

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
lan(zh).
question(q1).

bot sub [cate, sem, agr, cl_types].
    sem sub [n_sem, v_sem].
        n_sem sub [cat, dog, professor] intro [count:count].
        v_sem sub [see, chase] intro [subj:sem, obj:sem].

    cl_types sub [ge, wei, zhi, tiao].

    cate sub [nominal, verbal] intro [agr:agr, sem:sem].
        nominal sub [n, np, clp, num, cl] intro [sem:n_sem].
        verbal sub [v, vp, s] intro [sem:v_sem, subcat:list].

    % Define your agreement
    agr intro [].

    count sub [one, two, three].

    list sub [e_list, ne_list].
        ne_list intro [hd:bot, tl:list].

% Specifying the semantics for generation.
semantics sem1.
sem1(sem:S, S) if true.

% Define your Lexical items

yi ---> (num, sem:count:one).
liang ---> (num, sem:count:two).
san ---> (num, sem:count:three).
mao ---> (n, sem:cat, agr:cl_type:zhi).
gou ---> (n, sem:dog, agr:cl_type:zhi).
gou ---> (n, sem:dog, agr:cl_type:tiao).
jiaoshou ---> (n, sem:professor, agr:cl_type:ge).
jiaoshou ---> (n, sem:professor, agr:cl_type:wei).
kanjian ---> (v, sem:see).
zhui ---> (v, sem:chase).
ge ---> (cl, agr:cl_type:ge).
wei ---> (cl, agr:cl_type:wei).
zhi ---> (cl, agr:cl_type:zhi).
tiao ---> (cl, agr:cl_type:tiao).

% Define your Rules

clp rule
(clp, agr:Agr) ===>
cat> (num),
sem_head> (cl, agr:Agr).

np rule
(np, sem:Sem, agr:Agr) ===>
cat> (clp, agr:Agr),
sem_head> (nominal, sem:Sem, agr:Agr).
