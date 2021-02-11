FROM python:3.6

ARG ANSIBLE_VERSION=2.9.17

RUN pip install ansible==${ANSIBLE_VERSION}