FROM binaryanalysisplatform/bap:latest as base

RUN sudo apt-get install emacs-nox man2html --yes \
 && eval $(opam env) \
 && opam install odig --yes \
 && git clone https://github.com/BinaryAnalysisPlatform/bap \
 && make doc -C bap \
 && mkdir -p .ssh \
 && cat $SSH_PRIVATE > ~/.ssh/id_rsa \
 && chmod 400 ~/.ssh/id_rsa \
 && git clone git@github.com:gitoleg/binaryanalysisplatform.github.io --no-checkout --single-branch --branch=master --depth=1 blog \
 && cd blog \
 && git reset -- \
 && mkdir -p bap/api \
 && cp -r  ../bap/doc/man1 bap/api \
 && cp -r  ../bap/doc/man3 bap/api \
 && cp -r  ../bap/doc/lisp bap/api \
 && cp -rL ../bap/doc/odoc bap/api \
 && git add bap/api \
 && git push origin master \
 && rm -rf .ssh
