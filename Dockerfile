FROM python:3.6

RUN mkdir /app
RUN mkdir /app/repo

WORKDIR /app

RUN pip install --upgrade "knowledge-repo[all]"

EXPOSE 7000

CMD ["knowledge_repo", "--repo", "/app/repo", "runserver"]