#!/bin/bash

kubectl delete deploy -n task-namespace --all

kubectl delete pods -n task-namespace --all

