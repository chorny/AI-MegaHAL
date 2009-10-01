use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile1('NAME'          => 'AI::MegaHAL',
	      'VERSION_FROM'  => 'lib/AI/MegaHAL.pm',
	      ($] >= 5.005 ?
	       (ABSTRACT_FROM => 'lib/AI/MegaHAL.pm',
		AUTHOR        => 'Alexandr Ciornii <alexchorny'.'@gmail.com>') : ()),
    ($ExtUtils::MakeMaker::VERSION ge '6.31'? 
     ('LICENSE'		=> 'gpl', ) : ()),
	      'OBJECT'        => 'MegaHAL.o libmegahal.o',
              PREREQ_PM    => {
                    }
              BUILD_REQUIRES    => {
                     'Test::More'      => '0.47',
                    }
	      );


sub WriteMakefile1 {
        my %params=@_;
        my $eumm_version=$ExtUtils::MakeMaker::VERSION;
        $eumm_version=eval $eumm_version;
        die "EXTRA_META is deprecated" if exists $params{EXTRA_META};
        die "License not specified" if not exists $params{LICENSE};
        if ($params{BUILD_REQUIRES}) { #and $eumm_version < 6.5503
            #Should be modified in future when EUMM will
            #correctly support BUILD_REQUIRES.
            #EUMM 6.5502 has problems with BUILD_REQUIRES
            $params{PREREQ_PM}={ %{$params{PREREQ_PM} || {}} , %{$params{BUILD_REQUIRES}} };
            delete $params{BUILD_REQUIRES};
        }
        delete $params{CONFIGURE_REQUIRES} if $eumm_version < 6.52;
        delete $params{MIN_PERL_VERSION} if $eumm_version < 6.48;
        delete $params{META_MERGE} if $eumm_version < 6.46;
        delete $params{META_ADD} if $eumm_version < 6.46;
        delete $params{LICENSE} if $eumm_version < 6.31;
        delete $params{AUTHOR} if $] < 5.005;
        delete $params{ABSTRACT_FROM} if $] < 5.005;
        WriteMakefile(%params);
}
