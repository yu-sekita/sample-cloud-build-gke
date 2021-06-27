FROM python:3.8 AS build

WORKDIR /server
COPY Pipfile Pipfile.lock /server/
RUN pip install pipenv && pipenv install --system

FROM python:3.8
WORKDIR /server
COPY --from=build /usr/local/lib/python3.8/site-packages /usr/local/lib/python3.8/site-packages
COPY --from=build /usr/local/bin /usr/local/bin
COPY ./ /server
CMD ["uvicorn", "main:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]
