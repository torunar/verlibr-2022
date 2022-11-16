FROM ubuntu:20.04 as build-stage

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt update \
 && apt install --yes \
      texlive-latex-base \
      texlive-latex-recommended \
      texlive-humanities \
      texlive-latex-extra \
      texlive-lang-cyrillic \
      scalable-cyrfonts-tex \
      poppler-utils

ADD src /app/src
ADD bin /app/bin

RUN cd /app/src \
 && for i in main main_with_toc; do \
      pdflatex -file-line-error -output-directory /app/bin/ -halt-on-error main.latex || exit 1; \
    done \
 && pdfunite \
      /app/bin/title-page.pdf \
      /app/bin/title-page-rev.pdf \
      /app/bin/main.pdf \
      /app/bin/colophon.pdf \
      /app/bin/verlibr.pdf

FROM scratch AS export-stage
COPY --from=build-stage /app/bin/verlibr.pdf /
