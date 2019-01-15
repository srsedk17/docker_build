#!/usr/bin/perl
system qq(mkdir -p ~/.ssh && echo "$ANSIBLE_KEY" | base64 -d > ~/.ssh/ansible_deploy && chmod 600  ~/.ssh/ansible_deploy);
$env=shift @ARGV;
sub apply_infra{
$out_plan=system qq(ansible-playbook -i envs/$env/ playbooks/infra.yml --check --diff --limit 'all:!basket'   --private-key=~/.ssh/ansible_deploy --vault-id ./scripts/vault-pwd.py);
if ($out_plan eq 0){
system qq(ansible-playbook -i envs/$env/ playbooks/infra.yml --diff   --private-key=~/.ssh/ansible_deploy --vault-id ./scripts/vault-pwd.py);
}}


sub apply_app1{
$env=shift @_;
$host=shift @_;
$out_plan1=system qq(ansible-playbook -i envs/$env/$host/ playbooks/services.yml --check --diff  --private-key=~/.ssh/ansible_deploy);
if ($out_plan1 eq 0){
system qq(ansible-playbook -i envs/$env/$host/ playbooks/services.yml --check --diff  --private-key=~/.ssh/ansible_deploy);
}}

sub apply_app2{
$env=shift @_;
$host=shift @_;
$out_plan1=system qq(ansible-playbook -i envs/$env/$host playbooks/services.yml --check --diff  --private-key=~/.ssh/ansible_deploy --extra-vars="@vars/$env_secrets.yml" --vault-id ./scripts/vault-pwd.py);
if ($out_plan1 eq 0){
system qq(ansible-playbook -i envs/$env/$host playbooks/services.yml --diff  --private-key=~/.ssh/ansible_deploy --extra-vars="@vars/$env_secrets.yml" --vault-id ./scripts/vault-pwd.py);
}}


##app1##
apply_app1($env,'srs');
#apply_app1($env,'brand');
#apply_app1($env,'atp');
#apply_app1($env,'track-and-trace');
#apply_app1($env,'article-hierarchy');
#apply_app1($env,'indexable-filter-service');
#apply_app1($env,'browse-redirect');

##app2##
#apply_app2($env,'article-restrictions');
#apply_app2($env,'my-account');
