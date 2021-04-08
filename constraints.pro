% Predicate to test if WorkspaceCwd is an example
workspace_is_example(WorkspaceCwd) :-
  atom_concat('examples', _, WorkspaceCwd).

% Enforces the license
gen_enforced_field(WorkspaceCwd, 'license', 'MIT').

% Enforces that examples are private
gen_enforced_field(WorkspaceCwd, 'private', 'true') :-
  workspace_is_example(WorkspaceCwd).

% Enforces that examples don't specify the repository field
gen_enforced_field(WorkspaceCwd, 'repository', null) :-
  workspace_is_example(WorkspaceCwd).

% Enforces that all workspaces except examples and the root specify the 'homepage' field
gen_enforced_field(WorkspaceCwd, 'homepage', HomepageValue) :-
  \+ workspace_is_example(WorkspaceCwd),
  WorkspaceCwd \= '.',
  atom_concat('https://github.com/storybookjs/storybook/tree/master/', WorkspaceCwd, HomepageValue).

% Enforces that all workspaces except examples specify the same bugs.url field
gen_enforced_field(WorkspaceCwd, 'bugs.url', 'https://github.com/storybookjs/storybook/issues') :-
  \+ workspace_is_example(WorkspaceCwd).

% Enforces the repository field is consistent across all workspaces
gen_enforced_field(WorkspaceCwd, 'repository.type', 'git') :-
  \+ workspace_is_example(WorkspaceCwd).
gen_enforced_field(WorkspaceCwd, 'repository.url', 'https://github.com/storybookjs/storybook.git') :-
  \+ workspace_is_example(WorkspaceCwd).
gen_enforced_field(WorkspaceCwd, 'repository.directory', WorkspaceCwd) :-
  \+ workspace_is_example(WorkspaceCwd),
  WorkspaceCwd \= '.'.

% Enforces the engines.node version is consistent
gen_enforced_field(WorkspaceCwd, 'engines.node', '>=10.13.0') :-
  \+ workspace_is_example(WorkspaceCwd).
