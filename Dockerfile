FROM ubuntu:trusty
MAINTAINER Chris Fitzpatrick <chris@incf.org>

RUN apt-get update
RUN apt-get -y install maven git default-jdk curl


ENV SCIGRAPH_REPO=https://github.com/SciCrunch/SciGraph

RUN mkdir -p /source
RUN git clone $SCIGRAPH_REPO /source/scigraph

# PROCESS THE BUILD
WORKDIR /source/scigraph

ADD run.sh /run.sh
RUN chmod u+x /*.sh

RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/SciCrunch/NIF-Ontology/master/scigraph/make_yamls.sh)"
RUN mvn  -DskipTests -DskipITs install

WORKDIR /source/scigraph/SciGraph-core
RUN mvn exec:java -Dexec.mainClass="io.scigraph.owlapi.loader.BatchOwlLoader" -Dexec.args="-c /source/scigraph/graphload.yaml" 

CMD ["/run.sh"]

EXPOSE 9000

