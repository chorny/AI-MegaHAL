use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile('NAME'          => 'AI::MegaHAL',
	      'VERSION_FROM'  => 'lib/AI/MegaHAL.pm',
	      ($] >= 5.005 ?
	       (ABSTRACT_FROM => 'lib/AI/MegaHAL.pm',
		AUTHOR        => 'Cory Spencer <cspencer@sprocket.org>') : ()),
	      'OBJECT'        => 'MegaHAL.o libmegahal.o');
