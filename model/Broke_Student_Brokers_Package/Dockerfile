FROM python:3.7.9-buster

RUN pip install setuptools
RUN pip install twine

COPY . .

RUN python setup.py sdist && twine upload --skip-existing --repository-url https://upload.pypi.org/legacy/ -u shaurya1409 -p w!w?5@rM%4qE.Hb dist/*

