default:

dns:
	@echo "Repopulating DNS entries..."
	@ansible-playbook playbooks/dns.yml -K

node:
	@echo "Bootstrapping Node.JS hosts..."
	@ansible-playbook playbooks/node_hosts.yml -K

traefik:
	@echo "Repopulating DNS entries..."
	@ansible-playbook playbooks/traefik.yml -K

docker-hosts:
	@echo "Installing docker on docker hosts..."
	@ansible-playbook playbooks/docker_hosts.yml -K

traefik-logs:
	@echo "Tailing traefik logs..."
	ssh -t docker@docker.lab.charj.dev "cd /home/docker/docker/traefik && docker compose logs -f traefik"

media-kill:
	@echo "Stopping media server..."
	@ansible-playbook playbooks/media-servers.yml -K -e state=absent

media-stop:
	@echo "Stopping media server..."
	@ansible-playbook playbooks/media-servers.yml -K -e state=stopped

media-start:
	@echo "Starting media server..."
	@ansible-playbook playbooks/media-servers.yml -K -e state=started

media:
	@echo "Media server"
	@echo "-----------"
	@echo "1. Start"
	@echo "2. Stop"
	@echo "3. Kill"
	@echo "-----------"
	@read -p "Enter your choice: " choice; \
	case $$choice in \
		1) make media-start;; \
		2) make media-stop;; \
		3) make media-kill;; \
		4) exit 0;; \
		*) echo "Invalid choice";; \
	esac
