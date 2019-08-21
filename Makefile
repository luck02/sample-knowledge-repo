IMAGE_NAME = knowledge-repo

# helper variables for ensuring required arguments are provided
check_variable = \
	$(strip $(foreach 1,$1, $(call __check_variable,$1,$(strip $(value 2)))))
__check_variable = \
	$(if $(value $1),, $(error Variable undefined: $1$(if $2, ($2))))


init:
	docker run -v ${PWD}/repo:/app/repo knowledge-repo "knowledge_repo" "--repo" "/app/repo" "init"
up:
	docker-compose up -d

down: 
	docker-compose down

build-docker:
	docker-build

runit:
	docker run -v ${PWD}/repo:/app/repo knowledge-repo "knowledge_repo" "--repo" "/app/repo" "runserver"

create:
	$(call check_variable, FILEPATH, You must specify a file to create)
	$(call check_variable, TYPE, You must specify a file type)
	docker-compose exec knowledge-repo knowledge_repo --repo /app/repo/ create $(TYPE) $(FILEPATH)

add:
	$(call check_variable, FILEPATH, You must specify a file to create)
	$(call check_variable, DESTINATION, You must specify a place to add the document inside knowledge repo)
	docker-compose exec knowledge-repo knowledge_repo --repo /app/repo/ add $(FILEPATH) -p $(DESTINATION)
