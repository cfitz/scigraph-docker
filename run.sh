#!/bin/bash


cd /source/scigraph/SciGraph-services
mvn exec:java -Dexec.mainClass="io.scigraph.services.MainApplication" -Dexec.args="server /source/scigraph/services.yaml" 
