#!/bin/bash

git log --format='%aN <%aE>' | sort -f | uniq >> ../AUTHORS
