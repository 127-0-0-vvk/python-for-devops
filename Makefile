install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt
		
lint:
	pylint --disable=R,C *.py devopslib

test:
	python -m pytest -vv --cov=devopslib test_*.py

format:
	black *.py devopslib/*.py
	
post-install:
	python -m textblob.download_corpora
	
deploy:
	#deploy
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 428141977686.dkr.ecr.us-east-1.amazonaws.com
	docker build -t devops-main .
	docker tag devops-main:latest 428141977686.dkr.ecr.us-east-1.amazonaws.com/devops-main:latest
	docker push 428141977686.dkr.ecr.us-east-1.amazonaws.com/devops-main:latest

all: install post-install lint test format deploy