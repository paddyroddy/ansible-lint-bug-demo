#!/usr/bin/env bash
printf "INSTALL ANSIBLE & ANSIBLE-LINT\n"
python -m pip install ansible ansible-lint

printf "\n\n\nMAKE SURE ~/.ansible CACHE DIRECTORY IS EMPTY\n"
rm -rf $HOME/.ansible

printf "\n\n\nMAKE SURE .ansible-lint FILE IS DELETED\n"
rm .ansible-lint

printf "\n\n\nRUN ansible-lint, EXPECT IT TO COMPLAIN ABOUT MISSING ROLES\n"
ansible-lint

printf "\n\n\nINSTALL GALAXY ROLES\n"
ansible-galaxy install -r ansible/playbooks/roles/requirements.yml

printf "\n\n\nRUN ansible-lint, EXPECT IT TO COMPLAIN ABOUT ROLES IN ~/.ansible FOLDER\n"
ansible-lint

printf "\n\n\nCREATE .ansible-lint FILE EXLCUDING ~/.ansible FOLDER\n"
echo "exclude_paths:" > .ansible-lint
echo "    - ~/.ansible/" >> .ansible-lint

printf "\n\n\nRUN ansible-lint, EXPECT IT TO PASS\n"
ansible-lint
