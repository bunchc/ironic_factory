FROM cytopia/ansible:latest

COPY entrypoint.sh /entrypoint.sh
COPY ansible/ /ansible
CMD ["ansible-playbook" "--version"]
ENTRYPOINT ["/entrypoint.sh"]
