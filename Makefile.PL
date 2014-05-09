#======================================================================
# Makefile Maker for ltxMojo - LaTeXML's web service
# d.ginev@jacobs-university.de
#======================================================================
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME => 'latexmls',
  AUTHOR => 'Deyan Ginev <d.ginev@jacobs-university.de>',
  ABSTRACT => "latexmls - A socket server for daemonized LaTeXML processing",
  VERSION_FROM => 'bin/latexmls',
  PREREQ_PM => {
    'LaTeXML' => '0.8.0',
  },
  EXE_FILES => ['bin/latexmls'],
  test => {TESTS => 't/*.t'}
);
